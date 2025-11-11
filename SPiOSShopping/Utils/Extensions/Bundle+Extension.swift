//
//  Bundle+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation

// MARK: - Bundle 常用扩展
extension Bundle {
    
    /// 应用名称
    var appName: String {
        return infoDictionary?["CFBundleDisplayName"] as? String ??
               infoDictionary?["CFBundleName"] as? String ??
               "未知应用"
    }
    
    /// 应用版本号
    var appVersion: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    
    /// 构建版本号
    var buildVersion: String {
        return infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }
    
    /// Bundle ID
    var bundleId: String {
        return bundleIdentifier ?? "未知"
    }
    
    /// 应用图标名称
    var appIconName: String? {
        if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
           let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
           let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String] {
            return iconFiles.last
        }
        return nil
    }
    
    /// 读取文件内容
    /// - Parameters:
    ///   - name: 文件名
    ///   - type: 文件类型
    /// - Returns: 文件内容字符串
    func readFile(name: String, type: String) -> String? {
        guard let path = path(forResource: name, ofType: type),
              let content = try? String(contentsOfFile: path, encoding: .utf8) else {
            return nil
        }
        return content
    }
    
    /// 读取JSON文件
    /// - Parameter name: 文件名（不含扩展名）
    /// - Returns: JSON对象
    func readJSON(name: String) -> [String: Any]? {
        guard let path = path(forResource: name, ofType: "json"),
              let data = try? Data(contentsOfFile: path),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }
        return json
    }
}

