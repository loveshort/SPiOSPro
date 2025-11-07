//
//  MCNetworkManager+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation
import Moya
import RxSwift

// MARK: - MCNetworkManager 扩展方法
extension MCNetworkManager {
    
    // MARK: - 统一响应请求
    
    /// 发送请求（统一响应格式）
    /// - Parameters:
    ///   - target: 请求目标
    ///   - useCache: 是否使用缓存
    ///   - cacheKey: 缓存键
    ///   - expiry: 缓存过期时间
    /// - Returns: Observable<MCResponse<T>>
    public func request<T: Codable>(
        _ target: TargetType,
        useCache: Bool = false,
        cacheKey: String? = nil,
        expiry: MCExpiry = .date(Date().addingTimeInterval(30 * 60))
    ) -> Observable<MCResponse<T>> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            // 生成缓存键
            let key = cacheKey ?? self.generateCacheKey(from: target)
            
            // 如果使用缓存，先尝试从缓存获取数据
            if useCache, let cachedData: MCResponse<T> = self.cacheManager.getCache(forKey: key) {
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
                        // 检查HTTP状态码
                        let filteredResponse = try response.filterSuccessfulStatusCodes()
                        
                        // 解析响应数据
                        let decodedData = try JSONDecoder().decode(MCResponse<T>.self, from: filteredResponse.data)
                        
                        // 检查业务状态码
                        if decodedData.isSuccess {
                            // 保存到缓存
                            if useCache {
                                self.cacheManager.saveCache(decodedData, forKey: key, expiry: expiry)
                            }
                            
                            observer.onNext(decodedData)
                            observer.onCompleted()
                        } else {
                            // 业务错误
                            let error = MCNetworkError.businessError(decodedData.code, decodedData.message)
                            observer.onError(error)
                        }
                    } catch {
                        // 解析错误
                        let networkError = MCNetworkError.decodeError(error)
                        observer.onError(networkError)
                    }
                case .failure(let error):
                    // Moya错误转换
                    let networkError = self.mapMoyaError(error)
                    observer.onError(networkError)
                }
            }
            
            return Disposables.create()
        }
    }
    
    /// 发送请求（直接返回数据，不包装在MCResponse中）
    /// - Parameters:
    ///   - target: 请求目标
    ///   - useCache: 是否使用缓存
    ///   - cacheKey: 缓存键
    ///   - expiry: 缓存过期时间
    /// - Returns: Observable<T>
    public func requestData<T: Codable>(
        _ target: TargetType,
        useCache: Bool = false,
        cacheKey: String? = nil,
        expiry: MCExpiry = .date(Date().addingTimeInterval(30 * 60))
    ) -> Observable<T> {
        return request(target, useCache: useCache, cacheKey: cacheKey, expiry: expiry)
            .map { response -> T in
                guard let data = response.data else {
                    throw MCNetworkError.decodeError(NSError(domain: "数据为空", code: -1, userInfo: nil))
                }
                return data
            }
    }
    
    /// 发送请求（分页数据）
    /// - Parameters:
    ///   - target: 请求目标
    ///   - useCache: 是否使用缓存
    ///   - cacheKey: 缓存键
    ///   - expiry: 缓存过期时间
    /// - Returns: Observable<MCPageResponse<T>>
    public func requestPage<T: Codable>(
        _ target: TargetType,
        useCache: Bool = false,
        cacheKey: String? = nil,
        expiry: MCExpiry = .date(Date().addingTimeInterval(30 * 60))
    ) -> Observable<MCPageResponse<T>> {
        return requestData(target, useCache: useCache, cacheKey: cacheKey, expiry: expiry)
    }
    
    /// 发送请求（空响应）
    /// - Parameters:
    ///   - target: 请求目标
    ///   - useCache: 是否使用缓存
    /// - Returns: Observable<Void>
    public func requestEmpty(
        _ target: TargetType,
        useCache: Bool = false
    ) -> Observable<Void> {
        return request(target, useCache: useCache)
            .map { _ in () }
    }
    
    // MARK: - 错误映射
    
    /// 将Moya错误转换为MCNetworkError
    /// - Parameter error: Moya错误
    /// - Returns: MCNetworkError
    private func mapMoyaError(_ error: MoyaError) -> MCNetworkError {
        switch error {
        case .imageMapping, .jsonMapping, .stringMapping:
            return .decodeError(error)
        case .statusCode(let response):
            return .serverError(response.statusCode, HTTPURLResponse.localizedString(forStatusCode: response.statusCode))
        case .underlying(let nsError, _):
            if let urlError = nsError as? URLError {
                switch urlError.code {
                case .notConnectedToInternet, .networkConnectionLost:
                    return .networkUnavailable
                case .timedOut:
                    return .timeout
                default:
                    return .unknown(nsError)
                }
            }
            return .unknown(nsError)
        default:
            return .unknown(error)
        }
    }
}

// MARK: - 兼容旧版本
extension MCNetworkManager {
    
    /// 兼容旧版本的请求方法（使用MCResponse包装）
    public func requestWithCache<T: Codable>(
        _ target: TargetType,
        useCache: Bool = true,
        cacheKey: String? = nil,
        expiry: MCExpiry = .date(Date().addingTimeInterval(30 * 60))
    ) -> Observable<T> {
        // 如果使用旧版本，尝试直接解析为T类型
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            let key = cacheKey ?? self.generateCacheKey(from: target)
            
            if useCache, let cachedData: T = self.cacheManager.getCache(forKey: key) {
                observer.onNext(cachedData)
                if target is MCCacheOnlyTarget {
                    observer.onCompleted()
                    return Disposables.create()
                }
            }
            
            self.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        let filteredResponse = try response.filterSuccessfulStatusCodes()
                        let decodedData = try JSONDecoder().decode(T.self, from: filteredResponse.data)
                        
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
}

