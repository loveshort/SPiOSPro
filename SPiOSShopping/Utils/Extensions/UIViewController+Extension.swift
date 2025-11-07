//
//  UIViewController+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

// MARK: - UIViewController 常用扩展
extension UIViewController {
    
    // MARK: - 提示框
    
    /// 显示提示框
    /// - Parameters:
    ///   - message: 提示信息
    ///   - title: 标题（可选）
    ///   - completion: 完成回调
    func showAlert(message: String, title: String? = nil, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
    
    /// 显示确认框
    /// - Parameters:
    ///   - message: 提示信息
    ///   - title: 标题（可选）
    ///   - confirmTitle: 确认按钮标题
    ///   - cancelTitle: 取消按钮标题
    ///   - confirmHandler: 确认回调
    ///   - cancelHandler: 取消回调
    func showConfirm(message: String,
                    title: String? = nil,
                    confirmTitle: String = "确定",
                    cancelTitle: String = "取消",
                    confirmHandler: (() -> Void)? = nil,
                    cancelHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel) { _ in
            cancelHandler?()
        })
        
        alert.addAction(UIAlertAction(title: confirmTitle, style: .default) { _ in
            confirmHandler?()
        })
        
        present(alert, animated: true)
    }
    
    /// 显示输入框
    /// - Parameters:
    ///   - message: 提示信息
    ///   - title: 标题（可选）
    ///   - placeholder: 占位符
    ///   - confirmTitle: 确认按钮标题
    ///   - cancelTitle: 取消按钮标题
    ///   - confirmHandler: 确认回调（返回输入的文本）
    ///   - cancelHandler: 取消回调
    func showInput(message: String? = nil,
                  title: String? = nil,
                  placeholder: String = "请输入",
                  confirmTitle: String = "确定",
                  cancelTitle: String = "取消",
                  confirmHandler: ((String?) -> Void)? = nil,
                  cancelHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = placeholder
        }
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel) { _ in
            cancelHandler?()
        })
        
        alert.addAction(UIAlertAction(title: confirmTitle, style: .default) { _ in
            let text = alert.textFields?.first?.text
            confirmHandler?(text)
        })
        
        present(alert, animated: true)
    }
    
    // MARK: - Toast提示
    
    /// 显示Toast提示
    /// - Parameters:
    ///   - message: 提示信息
    ///   - duration: 显示时长
    func showToast(message: String, duration: TimeInterval = 2.0) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.text = message
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 8
        toastLabel.layer.masksToBounds = true
        
        let maxWidth = view.bounds.width - 80
        let size = message.size(with: toastLabel.font, maxWidth: maxWidth)
        toastLabel.frame = CGRect(x: 0, y: 0, width: size.width + 30, height: size.height + 20)
        toastLabel.center = view.center
        
        view.addSubview(toastLabel)
        
        toastLabel.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            toastLabel.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: duration, options: [], animations: {
                toastLabel.alpha = 0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: - 导航栏设置
    
    /// 设置导航栏标题
    /// - Parameter title: 标题
    func setNavigationTitle(_ title: String) {
        navigationItem.title = title
    }
    
    /// 设置导航栏标题颜色
    /// - Parameter color: 颜色
    func setNavigationTitleColor(_ color: UIColor) {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: color]
    }
    
    /// 设置导航栏背景色
    /// - Parameter color: 颜色
    func setNavigationBarBackgroundColor(_ color: UIColor) {
        navigationController?.navigationBar.barTintColor = color
    }
    
    /// 隐藏导航栏
    /// - Parameter animated: 是否动画
    func hideNavigationBar(animated: Bool = true) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    /// 显示导航栏
    /// - Parameter animated: 是否动画
    func showNavigationBar(animated: Bool = true) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - 返回按钮
    
    /// 设置返回按钮
    /// - Parameters:
    ///   - title: 按钮标题（nil则使用默认）
    ///   - image: 按钮图片（可选）
    ///   - action: 点击事件（可选，nil则使用默认返回）
    func setBackButton(title: String? = nil, image: UIImage? = nil, action: Selector? = nil) {
        if let image = image {
            let backButton = UIBarButtonItem(image: image, style: .plain, target: self, action: action ?? #selector(backButtonTapped))
            navigationItem.leftBarButtonItem = backButton
        } else if let title = title {
            let backButton = UIBarButtonItem(title: title, style: .plain, target: self, action: action ?? #selector(backButtonTapped))
            navigationItem.leftBarButtonItem = backButton
        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 键盘处理
    
    /// 添加点击空白处收起键盘
    func addTapToDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - 安全区域
    
    /// 获取安全区域顶部高度
    var safeAreaTop: CGFloat {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets.top
        }
        return topLayoutGuide.length
    }
    
    /// 获取安全区域底部高度
    var safeAreaBottom: CGFloat {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets.bottom
        }
        return bottomLayoutGuide.length
    }
}

