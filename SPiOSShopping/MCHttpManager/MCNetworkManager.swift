//
//  MCNetworkManager.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation
import Moya
import RxSwift
import Reachability

/// 网络请求管理器
public class MCNetworkManager {
    
    /// 单例
    public static let shared = MCNetworkManager()
    
    /// 缓存管理器
    private let cacheManager = MCCacheManager.shared
    
    /// 网络状态监听器
    private var reachability: Reachability?
    
    /// 网络状态变化观察者
    private let networkStatusSubject = PublishSubject<Bool>()
    
    /// 网络状态变化观察者
    public var networkStatusObservable: Observable<Bool> {
        return networkStatusSubject.asObservable()
    }
    
    /// 待重启的请求队列
    private var pendingRequests: [(TargetType, (Result<Response, MoyaError>) -> Void)] = []
    
    /// 私有初始化方法
    private init() {
        setupReachability()
    }
    
    /// 设置网络状态监听
    private func setupReachability() {
        do {
            reachability = try Reachability()
            
            // 网络状态变化回调
            reachability?.whenReachable = { [weak self] _ in
                self?.networkStatusSubject.onNext(true)
                self?.restartPendingRequests()
            }
            
            reachability?.whenUnreachable = { [weak self] _ in
                self?.networkStatusSubject.onNext(false)
            }
            
            try reachability?.startNotifier()
        } catch {
            print("设置网络状态监听失败: \(error)")
        }
    }
    
    /// 重启待处理的请求
    private func restartPendingRequests() {
        let requests = pendingRequests
        pendingRequests.removeAll()
        
        for (target, completion) in requests {
            request(target, completion: completion)
        }
    }
    
    /// 网络插件配置
    private var plugins: [PluginType] {
        var plugins: [PluginType] = []
        
        // 添加网络日志插件
        plugins.append(MCNetworkLoggerPlugin())
        
        // 添加网络插件（用于添加Token等）
        let networkPlugin = MCNetworkPlugin()
        plugins.append(networkPlugin)
        
        return plugins
    }
    
    /// 发送请求
    /// - Parameters:
    ///   - target: 请求目标
    ///   - completion: 完成回调
    private func request(_ target: TargetType, completion: @escaping (Result<Response, MoyaError>) -> Void) {
        // 检查网络状态
        if reachability?.connection == .unavailable {
            // 保存请求到待重启队列
            pendingRequests.append((target, completion))
            return
        }
        
        // 创建网络提供者
        let provider = MoyaProvider<MultiTarget>(plugins: plugins)
        
        // 发送请求
        provider.request(MultiTarget(target)) { result in
            completion(result)
        }
    }
    
    /// 设置Token获取闭包
    /// - Parameter closure: Token获取闭包
    public func setTokenClosure(_ closure: @escaping () -> String?) {
        // 这里需要重新创建插件，实际项目中可以优化
    }
    
    /// 发送请求（带缓存）
    /// - Parameters:
    ///   - target: 请求目标
    ///   - useCache: 是否使用缓存
    ///   - cacheKey: 缓存键（默认为请求URL）
    ///   - expiry: 缓存过期时间
    /// - Returns: Observable<T>
    public func requestWithCache<T: Codable>(
        _ target: TargetType,
        useCache: Bool = true,
        cacheKey: String? = nil,
        expiry: MCExpiry = .date(Date().addingTimeInterval(30 * 60)) // 默认30分钟
    ) -> Observable<T> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            // 生成缓存键
            let key = cacheKey ?? self.generateCacheKey(from: target)
            
            // 如果使用缓存，先尝试从缓存获取数据
            if useCache, let cachedData: T = self.cacheManager.getCache(forKey: key) {
                observer.onNext(cachedData)
                
                // 如果设置了只使用缓存，则直接完成
                if target is MCCacheOnlyTarget {
                    observer.onCompleted()
                    return Disposables.create()
                }
            }
            
            // 发送网络请求
            self.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        // 解析响应数据
                        let filteredResponse = try response.filterSuccessfulStatusCodes()
                        let decodedData = try JSONDecoder().decode(T.self, from: filteredResponse.data)
                        
                        // 保存到缓存
                        if useCache {
                            self.cacheManager.saveCache(decodedData, forKey: key, expiry: expiry)
                        }
                        
                        observer.onNext(decodedData)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    /// 生成缓存键
    /// - Parameter target: 请求目标
    /// - Returns: 缓存键
    private func generateCacheKey(from target: TargetType) -> String {
        var components = [String]()
        components.append(target.method.rawValue)
        components.append(target.baseURL.absoluteString)
        components.append(target.path)
        
        // 添加参数
        if let parameters = target.task.parameters {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .sortedKeys)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    components.append(jsonString)
                }
            } catch {
                print("参数序列化失败: \(error)")
            }
        }
        
        return components.joined(separator: "_").md5
    }
    
    /// 清除指定请求的缓存
    /// - Parameter target: 请求目标
    public func clearCache(for target: TargetType, cacheKey: String? = nil) {
        let key = cacheKey ?? generateCacheKey(from: target)
        cacheManager.removeCache(forKey: key)
    }
    
    /// 清除所有缓存
    public func clearAllCache() {
        cacheManager.clearAllCache()
    }
    
    deinit {
        reachability?.stopNotifier()
    }
}

// MARK: - 扩展

/// 只使用缓存的目标协议
public protocol MCCacheOnlyTarget: TargetType {}

/// Task扩展，获取参数
extension Task {
    var parameters: [String: Any]? {
        switch self {
        case .requestParameters(let parameters, _):
            return parameters
        case .requestCompositeData(_, let parameters, _):
            return parameters
        case .requestCompositeParameters(let bodyParameters, _, let urlParameters, _):
            var parameters = bodyParameters
            for (key, value) in urlParameters {
                parameters[key] = value
            }
            return parameters
        default:
            return nil
        }
    }
}

// MARK: - String MD5 扩展
extension String {
    /// 计算字符串的MD5值
    var md5: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}

// 需要导入CommonCrypto模块
import CommonCrypto
