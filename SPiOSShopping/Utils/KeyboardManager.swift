//
//  KeyboardManager.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

// MARK: - 键盘管理工具类
class KeyboardManager {
    
    /// 单例
    static let shared = KeyboardManager()
    
    /// 键盘高度变化回调
    var onKeyboardHeightChanged: ((CGFloat, TimeInterval) -> Void)?
    
    /// 当前键盘高度
    private(set) var keyboardHeight: CGFloat = 0
    
    /// 键盘动画时长
    private(set) var keyboardAnimationDuration: TimeInterval = 0.25
    
    private init() {
        setupNotifications()
    }
    
    deinit {
        removeNotifications()
    }
    
    // MARK: - 通知设置
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidShow(_:)),
            name: UIResponder.keyboardDidShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidHide(_:)),
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
    }
    
    private func removeNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - 键盘事件处理
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        
        keyboardHeight = keyboardFrame.height
        keyboardAnimationDuration = duration
        
        onKeyboardHeightChanged?(keyboardHeight, duration)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        
        keyboardHeight = 0
        keyboardAnimationDuration = duration
        
        onKeyboardHeightChanged?(keyboardHeight, duration)
    }
    
    @objc private func keyboardDidShow(_ notification: Notification) {
        // 键盘已显示
    }
    
    @objc private func keyboardDidHide(_ notification: Notification) {
        // 键盘已隐藏
    }
    
    // MARK: - 工具方法
    
    /// 收起键盘
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    /// 判断键盘是否显示
    var isKeyboardVisible: Bool {
        return keyboardHeight > 0
    }
}

// MARK: - UIViewController 键盘扩展
extension UIViewController {
    
    /// 添加键盘监听
    /// - Parameter handler: 键盘高度变化回调
    func addKeyboardObserver(handler: @escaping (CGFloat, TimeInterval) -> Void) {
        KeyboardManager.shared.onKeyboardHeightChanged = { [weak self] height, duration in
            guard let self = self else { return }
            handler(height, duration)
        }
    }
    
    /// 移除键盘监听
    func removeKeyboardObserver() {
        KeyboardManager.shared.onKeyboardHeightChanged = nil
    }
    
    /// 调整视图位置以适应键盘
    /// - Parameters:
    ///   - view: 需要调整的视图
    ///   - offset: 额外偏移量
    func adjustViewForKeyboard(_ view: UIView, offset: CGFloat = 0) {
        addKeyboardObserver { [weak self] height, duration in
            guard let self = self else { return }
            UIView.animate(withDuration: duration) {
                if height > 0 {
                    view.transform = CGAffineTransform(translationX: 0, y: -height - offset)
                } else {
                    view.transform = .identity
                }
            }
        }
    }
}

