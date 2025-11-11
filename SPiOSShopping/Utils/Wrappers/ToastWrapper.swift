//
//  ToastWrapper.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit
import Toast

// MARK: - Toast-Swift 封装
extension UIView {
    
    /// 显示Toast提示（使用Toast-Swift库）
    /// - Parameters:
    ///   - message: 提示信息
    ///   - duration: 显示时长
    ///   - position: 显示位置
    ///   - style: 样式配置
    func showToast(
        message: String,
        duration: TimeInterval = 2.0,
        position: ToastPosition = .bottom,
        style: ToastStyle? = nil
    ) {
        var toastStyle = style ?? ToastStyle()
        toastStyle.messageFont = UIFont.systemFont(ofSize: 14)
        toastStyle.messageColor = .white
        toastStyle.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastStyle.cornerRadius = 8
        toastStyle.horizontalPadding = 16
        toastStyle.verticalPadding = 12
        
        self.makeToast(message, duration: duration, position: position, style: toastStyle)
    }
    
    /// 显示成功Toast
    /// - Parameters:
    ///   - message: 提示信息
    ///   - duration: 显示时长
    func showSuccessToast(message: String, duration: TimeInterval = 2.0) {
        var style = ToastStyle()
        style.backgroundColor = UIColor.systemGreen
        style.messageColor = .white
        style.messageFont = UIFont.systemFont(ofSize: 14)
        style.cornerRadius = 8
        
        self.makeToast(message, duration: duration, position: .center, style: style)
    }
    
    /// 显示错误Toast
    /// - Parameters:
    ///   - message: 提示信息
    ///   - duration: 显示时长
    func showErrorToast(message: String, duration: TimeInterval = 2.0) {
        var style = ToastStyle()
        style.backgroundColor = UIColor.systemRed
        style.messageColor = .white
        style.messageFont = UIFont.systemFont(ofSize: 14)
        style.cornerRadius = 8
        
        self.makeToast(message, duration: duration, position: .center, style: style)
    }
    
    /// 显示警告Toast
    /// - Parameters:
    ///   - message: 提示信息
    ///   - duration: 显示时长
    func showWarningToast(message: String, duration: TimeInterval = 2.0) {
        var style = ToastStyle()
        style.backgroundColor = UIColor.systemOrange
        style.messageColor = .white
        style.messageFont = UIFont.systemFont(ofSize: 14)
        style.cornerRadius = 8
        
        self.makeToast(message, duration: duration, position: .center, style: style)
    }
    
    /// 显示带图片的Toast
    /// - Parameters:
    ///   - message: 提示信息
    ///   - image: 图片
    ///   - duration: 显示时长
    func showToastWithImage(message: String, image: UIImage?, duration: TimeInterval = 2.0) {
        self.makeToast(message, duration: duration, position: .center, image: image)
    }
    
    /// 隐藏所有Toast
    func hideAllToasts() {
        self.hideToast(includeActivity: false, clearQueue: true)
    }
}

// MARK: - UIViewController Toast扩展
extension UIViewController {
    
    /// 显示Toast提示（使用Toast-Swift库）
    /// - Parameters:
    ///   - message: 提示信息
    ///   - duration: 显示时长
    ///   - position: 显示位置
    func showToast(
        message: String,
        duration: TimeInterval = 2.0,
        position: ToastPosition = .bottom
    ) {
        view.showToast(message: message, duration: duration, position: position)
    }
    
    /// 显示成功Toast
    /// - Parameters:
    ///   - message: 提示信息
    ///   - duration: 显示时长
    func showSuccessToast(message: String, duration: TimeInterval = 2.0) {
        view.showSuccessToast(message: message, duration: duration)
    }
    
    /// 显示错误Toast
    /// - Parameters:
    ///   - message: 提示信息
    ///   - duration: 显示时长
    func showErrorToast(message: String, duration: TimeInterval = 2.0) {
        view.showErrorToast(message: message, duration: duration)
    }
    
    /// 显示警告Toast
    /// - Parameters:
    ///   - message: 提示信息
    ///   - duration: 显示时长
    func showWarningToast(message: String, duration: TimeInterval = 2.0) {
        view.showWarningToast(message: message, duration: duration)
    }
}

// MARK: - Toast 工具类
struct MCToast {
    
    /// 显示Toast（全局方法）
    /// - Parameters:
    ///   - message: 提示信息
    ///   - view: 显示在哪个视图上
    ///   - duration: 显示时长
    ///   - position: 显示位置
    static func show(
        message: String,
        in view: UIView? = nil,
        duration: TimeInterval = 2.0,
        position: ToastPosition = .bottom
    ) {
        let targetView = view ?? UIApplication.shared.currentWindow
        targetView?.showToast(message: message, duration: duration, position: position)
    }
    
    /// 显示成功Toast
    static func showSuccess(
        message: String,
        in view: UIView? = nil,
        duration: TimeInterval = 2.0
    ) {
        let targetView = view ?? UIApplication.shared.currentWindow
        targetView?.showSuccessToast(message: message, duration: duration)
    }
    
    /// 显示错误Toast
    static func showError(
        message: String,
        in view: UIView? = nil,
        duration: TimeInterval = 2.0
    ) {
        let targetView = view ?? UIApplication.shared.currentWindow
        targetView?.showErrorToast(message: message, duration: duration)
    }
    
    /// 显示警告Toast
    static func showWarning(
        message: String,
        in view: UIView? = nil,
        duration: TimeInterval = 2.0
    ) {
        let targetView = view ?? UIApplication.shared.currentWindow
        targetView?.showWarningToast(message: message, duration: duration)
    }
}

