//
//  NotificationCenter+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation

// MARK: - NotificationCenter 扩展
extension NotificationCenter {
    
    /// 单例
    static var `default`: NotificationCenter {
        return NotificationCenter.default
    }
    
    // MARK: - 便捷方法
    
    /// 发送通知
    /// - Parameters:
    ///   - name: 通知名称
    ///   - object: 发送对象
    ///   - userInfo: 用户信息
    func post(name: Notification.Name, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        post(name: name, object: object, userInfo: userInfo)
    }
    
    /// 添加观察者（自动移除）
    /// - Parameters:
    ///   - observer: 观察者
    ///   - selector: 选择器
    ///   - name: 通知名称
    ///   - object: 对象
    /// - Returns: 观察者令牌（用于移除）
    @discardableResult
    func addObserver(_ observer: Any, selector: Selector, name: Notification.Name, object: Any? = nil) -> NSObjectProtocol {
        return addObserver(observer, selector: selector, name: name, object: object)
    }
    
    /// 使用闭包添加观察者
    /// - Parameters:
    ///   - name: 通知名称
    ///   - object: 对象
    ///   - queue: 执行队列
    ///   - block: 回调闭包
    /// - Returns: 观察者令牌
    func observe(name: Notification.Name, object: Any? = nil, queue: OperationQueue? = nil, using block: @escaping (Notification) -> Void) -> NSObjectProtocol {
        return addObserver(forName: name, object: object, queue: queue, using: block)
    }
}

// MARK: - 常用通知名称
extension Notification.Name {
    
    /// 用户登录
    static let userDidLogin = Notification.Name("userDidLogin")
    
    /// 用户登出
    static let userDidLogout = Notification.Name("userDidLogout")
    
    /// 用户信息更新
    static let userInfoDidUpdate = Notification.Name("userInfoDidUpdate")
    
    /// 网络状态变化
    static let networkStatusDidChange = Notification.Name("networkStatusDidChange")
    
    /// 应用进入前台
    static let appDidEnterForeground = Notification.Name("appDidEnterForeground")
    
    /// 应用进入后台
    static let appDidEnterBackground = Notification.Name("appDidEnterBackground")
}

