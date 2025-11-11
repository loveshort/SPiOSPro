//
//  UIApplication+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

// MARK: - UIApplication 常用扩展
extension UIApplication {
    
    // MARK: - 应用信息
    
    /// 应用版本号
    var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    
    /// 构建版本号
    var buildVersion: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }
    
    /// Bundle ID
    var bundleId: String {
        return Bundle.main.bundleIdentifier ?? ""
    }
    
    // MARK: - 窗口
    
    /// 获取当前窗口
    var currentWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            return connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .compactMap { $0 as? UIWindowScene }
                .first?.windows
                .first { $0.isKeyWindow }
        } else {
            return windows.first { $0.isKeyWindow }
        }
    }
    
    /// 获取根视图控制器
    var rootViewController: UIViewController? {
        return currentWindow?.rootViewController
    }
    
    // MARK: - 状态栏
    
    /// 状态栏高度
    var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            if let windowScene = connectedScenes.first as? UIWindowScene {
                return windowScene.statusBarManager?.statusBarFrame.height ?? 0
            }
        }
        return statusBarFrame.height
    }
    
    // MARK: - 打开设置
    
    /// 打开应用设置
    func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if canOpenURL(url) {
                open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    // MARK: - 拨打电话
    
    /// 拨打电话
    /// - Parameter phoneNumber: 电话号码
    func callPhone(_ phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)") {
            if canOpenURL(url) {
                open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    // MARK: - 打开URL
    
    /// 打开URL
    /// - Parameter urlString: URL字符串
    func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            if canOpenURL(url) {
                open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

