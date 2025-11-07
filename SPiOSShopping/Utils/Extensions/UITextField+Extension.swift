//
//  UITextField+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

// MARK: - UITextField 常用扩展
extension UITextField {
    
    // MARK: - 便捷初始化
    
    /// 便捷初始化
    /// - Parameters:
    ///   - placeholder: 占位符
    ///   - font: 字体
    ///   - color: 文字颜色
    ///   - alignment: 对齐方式
    convenience init(placeholder: String? = nil,
                    font: UIFont? = nil,
                    color: UIColor? = nil,
                    alignment: NSTextAlignment = .left) {
        self.init()
        self.placeholder = placeholder
        self.font = font ?? UIFont.systemFont(ofSize: 14)
        self.textColor = color ?? .textPrimaryColor
        self.textAlignment = alignment
    }
    
    // MARK: - 占位符设置
    
    /// 设置占位符颜色
    /// - Parameter color: 颜色
    func setPlaceholderColor(_ color: UIColor) {
        guard let placeholder = placeholder else { return }
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: color]
        )
    }
    
    /// 设置占位符字体
    /// - Parameter font: 字体
    func setPlaceholderFont(_ font: UIFont) {
        guard let placeholder = placeholder else { return }
        let color = attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .textTertiaryColor
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: color, .font: font]
        )
    }
    
    // MARK: - 左侧视图设置
    
    /// 设置左侧图标
    /// - Parameters:
    ///   - image: 图片
    ///   - size: 图标大小
    ///   - padding: 内边距
    func setLeftIcon(_ image: UIImage?, size: CGSize = CGSize(width: 20, height: 20), padding: CGFloat = 10) {
        guard let image = image else {
            leftView = nil
            leftViewMode = .never
            return
        }
        
        let iconView = UIImageView(image: image)
        iconView.contentMode = .scaleAspectFit
        iconView.frame = CGRect(x: padding, y: 0, width: size.width, height: size.height)
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: size.width + padding * 2, height: size.height))
        containerView.addSubview(iconView)
        
        leftView = containerView
        leftViewMode = .always
    }
    
    /// 设置左侧文字
    /// - Parameters:
    ///   - text: 文字
    ///   - color: 颜色
    ///   - font: 字体
    ///   - padding: 内边距
    func setLeftText(_ text: String, color: UIColor = .textSecondaryColor, font: UIFont = UIFont.systemFont(ofSize: 14), padding: CGFloat = 10) {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = font
        label.sizeToFit()
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: label.frame.width + padding * 2, height: label.frame.height))
        label.center = containerView.center
        containerView.addSubview(label)
        
        leftView = containerView
        leftViewMode = .always
    }
    
    // MARK: - 右侧视图设置
    
    /// 设置右侧图标
    /// - Parameters:
    ///   - image: 图片
    ///   - size: 图标大小
    ///   - padding: 内边距
    ///   - action: 点击事件
    func setRightIcon(_ image: UIImage?, size: CGSize = CGSize(width: 20, height: 20), padding: CGFloat = 10, action: (() -> Void)? = nil) {
        guard let image = image else {
            rightView = nil
            rightViewMode = .never
            return
        }
        
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: size.width + padding * 2, height: size.height)
        if let action = action {
            button.addAction { _ in action() }
        }
        
        rightView = button
        rightViewMode = .always
    }
    
    // MARK: - 限制输入
    
    /// 限制最大长度
    /// - Parameter length: 最大长度
    func limitLength(_ length: Int) {
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        objc_setAssociatedObject(self, &AssociatedKeys.maxLength, length, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    @objc private func textFieldDidChange() {
        guard let maxLength = objc_getAssociatedObject(self, &AssociatedKeys.maxLength) as? Int,
              let text = self.text,
              text.count > maxLength else {
            return
        }
        let index = text.index(text.startIndex, offsetBy: maxLength)
        self.text = String(text[..<index])
    }
    
    private struct AssociatedKeys {
        static var maxLength = "maxLength"
    }
}

// MARK: - UIButton 点击事件扩展
extension UIButton {
    
    /// 添加点击事件（闭包方式）
    /// - Parameter action: 点击回调
    func addAction(_ action: @escaping (UIButton) -> Void) {
        let target = ButtonTarget(action: action)
        objc_setAssociatedObject(self, &AssociatedKeys.buttonTarget, target, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        addTarget(target, action: #selector(ButtonTarget.invoke(_:)), for: .touchUpInside)
    }
    
    private struct AssociatedKeys {
        static var buttonTarget = "buttonTarget"
    }
    
    private class ButtonTarget {
        let action: (UIButton) -> Void
        
        init(action: @escaping (UIButton) -> Void) {
            self.action = action
        }
        
        @objc func invoke(_ sender: UIButton) {
            action(sender)
        }
    }
}

// 需要导入 Objective-C 运行时
import ObjectiveC

