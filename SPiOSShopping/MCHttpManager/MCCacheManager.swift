//
//  MCCacheManager.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation
import CommonCrypto

/// 缓存过期策略
public enum MCExpiry {
    /// 永不过期
    case never
    /// 指定日期过期
    case date(Date)
    /// 指定时间间隔后过期
    case seconds(TimeInterval)
    
    /// 获取过期日期
    var date: Date {
        switch self {
        case .never:
            return Date.distantFuture
        case .date(let date):
            return date
        case .seconds(let seconds):
            return Date().addingTimeInterval(seconds)
        }
    }
    
    /// 是否已过期
    var isExpired: Bool {
        return date.timeIntervalSinceNow < 0
    }
}

/// 缓存管理器
public class MCCacheManager {
    
    /// 单例
    public static let shared = MCCacheManager()
    
    /// 缓存目录
    private let cacheDirectory: URL
    
    /// 内存缓存
    private var memoryCache: [String: CacheObject] = [:]
    
    /// 缓存对象
    private class CacheObject {
        let data: Data
        let expiry: MCExpiry
        let createdAt: Date
        
        init(data: Data, expiry: MCExpiry) {
            self.data = data
            self.expiry = expiry
            self.createdAt = Date()
        }
        
        var isExpired: Bool {
            return expiry.isExpired
        }
    }
    
    /// 私有初始化方法
    private init() {
        // 获取缓存目录
        let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        cacheDirectory = cachesDirectory.appendingPathComponent("MCHttpCache")
        
        // 创建缓存目录
        if !FileManager.default.fileExists(atPath: cacheDirectory.path) {
            do {
                try FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("创建缓存目录失败: \(error)")
            }
        }
        
        // 清理过期缓存
        cleanExpiredCache()
    }
    
    /// 保存缓存
    /// - Parameters:
    ///   - object: 要缓存的对象
    ///   - key: 缓存键
    ///   - expiry: 过期时间
    public func saveCache<T: Codable>(_ object: T, forKey key: String, expiry: MCExpiry = .never) {
        do {
            // 编码对象
            let data = try JSONEncoder().encode(object)
            
            // 保存到内存缓存
            let cacheObject = CacheObject(data: data, expiry: expiry)
            memoryCache[key] = cacheObject
            
            // 保存到磁盘缓存
            let fileURL = cacheFileURL(for: key)
            try data.write(to: fileURL)
            
            // 保存元数据
            let metadata: [String: Any] = [
                "expiry": expiry.date.timeIntervalSince1970,
                "createdAt": Date().timeIntervalSince1970
            ]
            let metadataURL = metadataFileURL(for: key)
            let metadataData = try JSONSerialization.data(withJSONObject: metadata)
            try metadataData.write(to: metadataURL)
        } catch {
            print("保存缓存失败: \(error)")
        }
    }
    
    /// 获取缓存
    /// - Parameters:
    ///   - key: 缓存键
    /// - Returns: 缓存对象
    public func getCache<T: Codable>(forKey key: String) -> T? {
        // 检查是否过期
        if isCacheExpired(forKey: key) {
            removeCache(forKey: key)
            return nil
        }
        
        // 先从内存缓存获取
        if let cacheObject = memoryCache[key] {
            do {
                return try JSONDecoder().decode(T.self, from: cacheObject.data)
            } catch {
                print("解码缓存对象失败: \(error)")
            }
        }
        
        // 从磁盘缓存获取
        let fileURL = cacheFileURL(for: key)
        do {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                let data = try Data(contentsOf: fileURL)
                let object = try JSONDecoder().decode(T.self, from: data)
                
                // 加载到内存缓存
                if let expiry = cacheExpiry(forKey: key) {
                    let cacheObject = CacheObject(data: data, expiry: expiry)
                    memoryCache[key] = cacheObject
                }
                
                return object
            }
        } catch {
            print("加载缓存失败: \(error)")
        }
        
        return nil
    }
    
    /// 移除缓存
    /// - Parameter key: 缓存键
    public func removeCache(forKey key: String) {
        // 从内存缓存移除
        memoryCache.removeValue(forKey: key)
        
        // 从磁盘缓存移除
        let fileURL = cacheFileURL(for: key)
        let metadataURL = metadataFileURL(for: key)
        
        do {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                try FileManager.default.removeItem(at: fileURL)
            }
            if FileManager.default.fileExists(atPath: metadataURL.path) {
                try FileManager.default.removeItem(at: metadataURL)
            }
        } catch {
            print("移除缓存失败: \(error)")
        }
    }
    
    /// 清除所有缓存
    public func clearAllCache() {
        // 清除内存缓存
        memoryCache.removeAll()
        
        // 清除磁盘缓存
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil)
            for fileURL in fileURLs {
                try FileManager.default.removeItem(at: fileURL)
            }
        } catch {
            print("清除所有缓存失败: \(error)")
        }
    }
    
    /// 清理过期缓存
    public func cleanExpiredCache() {
        // 清理内存中的过期缓存
        for (key, cacheObject) in memoryCache {
            if cacheObject.isExpired {
                memoryCache.removeValue(forKey: key)
            }
        }
        
        // 清理磁盘中的过期缓存
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil)
            for fileURL in fileURLs {
                if fileURL.pathExtension == "metadata" {
                    let key = fileURL.deletingPathExtension().lastPathComponent
                    if isCacheExpired(forKey: key) {
                        removeCache(forKey: key)
                    }
                }
            }
        } catch {
            print("清理过期缓存失败: \(error)")
        }
    }
    
    /// 检查缓存是否过期
    /// - Parameter key: 缓存键
    /// - Returns: 是否过期
    public func isCacheExpired(forKey key: String) -> Bool {
        // 检查内存中的过期时间
        if let cacheObject = memoryCache[key] {
            return cacheObject.isExpired
        }
        
        // 检查磁盘中的过期时间
        if let expiry = cacheExpiry(forKey: key) {
            return expiry.isExpired
        }
        
        return true // 如果无法确定是否过期，则认为已过期
    }
    
    /// 检查缓存是否存在
    /// - Parameter key: 缓存键
    /// - Returns: 是否存在
    public func cacheExists(forKey key: String) -> Bool {
        // 检查内存缓存
        if memoryCache[key] != nil {
            return true
        }
        
        // 检查磁盘缓存
        let fileURL = cacheFileURL(for: key)
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
    
    /// 获取缓存过期时间
    /// - Parameter key: 缓存键
    /// - Returns: 过期时间
    public func cacheExpiry(forKey key: String) -> MCExpiry? {
        // 从元数据获取过期时间
        let metadataURL = metadataFileURL(for: key)
        do {
            if FileManager.default.fileExists(atPath: metadataURL.path) {
                let data = try Data(contentsOf: metadataURL)
                if let metadata = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let expiryTimestamp = metadata["expiry"] as? TimeInterval {
                    return .date(Date(timeIntervalSince1970: expiryTimestamp))
                }
            }
        } catch {
            print("获取缓存过期时间失败: \(error)")
        }
        
        return nil
    }
    
    /// 获取缓存文件URL
    /// - Parameter key: 缓存键
    /// - Returns: 文件URL
    private func cacheFileURL(for key: String) -> URL {
        return cacheDirectory.appendingPathComponent(key.md5)
    }
    
    /// 获取缓存元数据文件URL
    /// - Parameter key: 缓存键
    /// - Returns: 元数据文件URL
    private func metadataFileURL(for key: String) -> URL {
        return cacheDirectory.appendingPathComponent("\(key.md5).metadata")
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