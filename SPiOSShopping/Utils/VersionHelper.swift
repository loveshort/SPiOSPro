//
//  VersionHelper.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

// MARK: - 版本管理工具类
struct VersionHelper {
    
    // MARK: - 版本比较
    
    /// 比较两个版本号
    /// - Parameters:
    ///   - version1: 版本1
    ///   - version2: 版本2
    /// - Returns: 比较结果（-1: version1 < version2, 0: 相等, 1: version1 > version2）
    static func compare(_ version1: String, _ version2: String) -> Int {
        let v1Components = version1.split(separator: ".").compactMap { Int($0) }
        let v2Components = version2.split(separator: ".").compactMap { Int($0) }
        
        let maxCount = max(v1Components.count, v2Components.count)
        
        for i in 0..<maxCount {
            let v1 = i < v1Components.count ? v1Components[i] : 0
            let v2 = i < v2Components.count ? v2Components[i] : 0
            
            if v1 < v2 {
                return -1
            } else if v1 > v2 {
                return 1
            }
        }
        
        return 0
    }
    
    /// 版本1是否大于版本2
    /// - Parameters:
    ///   - version1: 版本1
    ///   - version2: 版本2
    /// - Returns: 是否大于
    static func isGreaterThan(_ version1: String, _ version2: String) -> Bool {
        return compare(version1, version2) > 0
    }
    
    /// 版本1是否小于版本2
    /// - Parameters:
    ///   - version1: 版本1
    ///   - version2: 版本2
    /// - Returns: 是否小于
    static func isLessThan(_ version1: String, _ version2: String) -> Bool {
        return compare(version1, version2) < 0
    }
    
    /// 版本1是否等于版本2
    /// - Parameters:
    ///   - version1: 版本1
    ///   - version2: 版本2
    /// - Returns: 是否相等
    static func isEqual(_ version1: String, _ version2: String) -> Bool {
        return compare(version1, version2) == 0
    }
    
    // MARK: - iOS版本检查
    
    /// 当前iOS版本是否大于等于指定版本
    /// - Parameter version: 版本号（如：13.0）
    /// - Returns: 是否大于等于
    static func isIOSVersionGreaterOrEqual(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) != .orderedAscending
    }
    
    /// 当前iOS版本是否小于指定版本
    /// - Parameter version: 版本号（如：13.0）
    /// - Returns: 是否小于
    static func isIOSVersionLessThan(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) == .orderedAscending
    }
    
    // MARK: - 应用版本检查
    
    /// 当前应用版本是否大于等于指定版本
    /// - Parameter version: 版本号
    /// - Returns: 是否大于等于
    static func isAppVersionGreaterOrEqual(_ version: String) -> Bool {
        let currentVersion = AppInfo.appVersion
        return compare(currentVersion, version) >= 0
    }
    
    /// 当前应用版本是否小于指定版本
    /// - Parameter version: 版本号
    /// - Returns: 是否小于
    static func isAppVersionLessThan(_ version: String) -> Bool {
        let currentVersion = AppInfo.appVersion
        return compare(currentVersion, version) < 0
    }
}

