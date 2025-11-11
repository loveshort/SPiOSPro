//
//  AppInfo.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

// MARK: - 应用信息工具类
struct AppInfo {
    
    // MARK: - Bundle信息
    
    /// 应用名称
    static var appName: String {
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ??
               Bundle.main.infoDictionary?["CFBundleName"] as? String ??
               "未知应用"
    }
    
    /// 应用版本号
    static var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    
    /// 构建版本号
    static var buildVersion: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }
    
    /// 完整版本号（版本号+构建号）
    static var fullVersion: String {
        return "\(appVersion) (\(buildVersion))"
    }
    
    /// Bundle ID
    static var bundleId: String {
        return Bundle.main.bundleIdentifier ?? "未知"
    }
    
    // MARK: - 应用信息
    
    /// 是否为首次启动
    static var isFirstLaunch: Bool {
        let key = "HasLaunchedBefore"
        let hasLaunched = UserDefaults.standard.bool(forKey: key)
        if !hasLaunched {
            UserDefaults.standard.set(true, forKey: key)
        }
        return !hasLaunched
    }
    
    /// 启动次数
    static var launchCount: Int {
        let key = "LaunchCount"
        let count = UserDefaults.standard.integer(forKey: key)
        UserDefaults.standard.set(count + 1, forKey: key)
        return count + 1
    }
    
    /// 上次启动时间
    static var lastLaunchTime: Date? {
        get {
            return UserDefaults.standard.getDate(forKey: "LastLaunchTime")
        }
        set {
            UserDefaults.standard.setDate(newValue, forKey: "LastLaunchTime")
        }
    }
    
    // MARK: - 版本比较
    
    /// 比较版本号
    /// - Parameters:
    ///   - version1: 版本1
    ///   - version2: 版本2
    /// - Returns: 比较结果（-1: version1 < version2, 0: 相等, 1: version1 > version2）
    static func compareVersion(_ version1: String, _ version2: String) -> Int {
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
    
    /// 当前版本是否大于指定版本
    /// - Parameter version: 指定版本
    /// - Returns: 是否大于
    static func isVersionGreaterThan(_ version: String) -> Bool {
        return compareVersion(appVersion, version) > 0
    }
    
    /// 当前版本是否小于指定版本
    /// - Parameter version: 指定版本
    /// - Returns: 是否小于
    static func isVersionLessThan(_ version: String) -> Bool {
        return compareVersion(appVersion, version) < 0
    }
    
    // MARK: - 应用状态
    
    /// 应用是否在前台
    static var isActive: Bool {
        return UIApplication.shared.applicationState == .active
    }
    
    /// 应用是否在后台
    static var isInBackground: Bool {
        return UIApplication.shared.applicationState == .background
    }
    
    // MARK: - 应用路径
    
    /// 应用沙盒路径
    static var appSandboxPath: String {
        return NSHomeDirectory()
    }
    
    /// 文档目录路径
    static var documentsPath: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
    }
    
    /// 缓存目录路径
    static var cachesPath: String {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first ?? ""
    }
    
    // MARK: - 其他信息
    
    /// 应用图标
    static var appIcon: UIImage? {
        guard let icons = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String: Any],
              let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
              let lastIcon = iconFiles.last else {
            return nil
        }
        return UIImage(named: lastIcon)
    }
}

