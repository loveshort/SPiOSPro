//
//  DeviceInfo.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

// MARK: - 设备信息工具类
struct DeviceInfo {
    
    // MARK: - 屏幕信息
    
    /// 屏幕宽度
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    /// 屏幕高度
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    /// 屏幕尺寸
    static var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
    /// 屏幕缩放比例
    static var screenScale: CGFloat {
        return UIScreen.main.scale
    }
    
    /// 是否为横屏
    static var isLandscape: Bool {
        return UIScreen.main.bounds.width > UIScreen.main.bounds.height
    }
    
    /// 是否为竖屏
    static var isPortrait: Bool {
        return UIScreen.main.bounds.height > UIScreen.main.bounds.width
    }
    
    // MARK: - 设备信息
    
    /// 设备型号
    static var deviceModel: String {
        return UIDevice.current.model
    }
    
    /// 设备名称
    static var deviceName: String {
        return UIDevice.current.name
    }
    
    /// 系统名称
    static var systemName: String {
        return UIDevice.current.systemName
    }
    
    /// 系统版本
    static var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    
    /// 是否为iPhone
    static var isiPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    /// 是否为iPad
    static var isiPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    /// 是否为模拟器
    static var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    // MARK: - 安全区域
    
    /// 获取安全区域（需要传入view）
    /// - Parameter view: 视图
    /// - Returns: 安全区域
    static func safeAreaInsets(for view: UIView) -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets
        }
        return .zero
    }
    
    /// 状态栏高度
    static var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                return windowScene.statusBarManager?.statusBarFrame.height ?? 0
            }
        }
        return UIApplication.shared.statusBarFrame.height
    }
    
    /// 导航栏高度
    static var navigationBarHeight: CGFloat {
        return 44.0
    }
    
    /// 状态栏 + 导航栏高度
    static var topBarHeight: CGFloat {
        return statusBarHeight + navigationBarHeight
    }
    
    /// TabBar高度
    static var tabBarHeight: CGFloat {
        return 49.0 + bottomSafeAreaHeight
    }
    
    /// 底部安全区域高度
    static var bottomSafeAreaHeight: CGFloat {
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.windows.first {
                return window.safeAreaInsets.bottom
            }
        }
        return 0
    }
    
    // MARK: - 设备型号判断
    
    /// 是否为iPhone X系列（带刘海）
    static var isiPhoneXSeries: Bool {
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.windows.first {
                return window.safeAreaInsets.bottom > 0
            }
        }
        return false
    }
    
    /// 是否为小屏设备（iPhone SE等）
    static var isSmallScreen: Bool {
        return screenWidth <= 375 && screenHeight <= 667
    }
    
    /// 是否为大屏设备（iPhone Plus等）
    static var isLargeScreen: Bool {
        return screenWidth >= 414
    }
    
    // MARK: - 版本判断
    
    /// iOS版本是否大于等于指定版本
    /// - Parameter version: 版本号（如：13.0）
    /// - Returns: 是否大于等于
    static func isIOSVersionGreaterOrEqual(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) != .orderedAscending
    }
    
    /// iOS版本是否小于指定版本
    /// - Parameter version: 版本号（如：13.0）
    /// - Returns: 是否小于
    static func isIOSVersionLessThan(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) == .orderedAscending
    }
}

