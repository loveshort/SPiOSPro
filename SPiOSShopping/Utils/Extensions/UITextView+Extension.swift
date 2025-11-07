//
//  UITextView+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

// MARK: - UITextView 常用扩展
extension UITextView {
    
    // MARK: - 占位符
    
    private struct AssociatedKeys {
        static var placeholderLabel = "placeholderLabel"
    }
    
    private var placeholderLabel: UILabel? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.placeholderLabel) as? UILabel
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.placeholderLabel, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 设置占位符
    /// - Parameters:
    ///   - text: 占位符文本
    ///   - color: 占位符颜色
    func setPlaceholder(_ text: String, color: UIColor = .textTertiaryColor) {
        if placeholderLabel == nil {
            let label = UILabel()
            label.font = font ?? UIFont.systemFont(ofSize: 14)
            label.textColor = color
            label.numberOfLines = 0
            addSubview(label)
            placeholderLabel = label
            
            // 监听文本变化
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(textDidChange),
                name: UITextView.textDidChangeNotification,
                object: self
            )
        }
        
        placeholderLabel?.text = text
        placeholderLabel?.textColor = color
        updatePlaceholderVisibility()
    }
    
    @objc private func textDidChange() {
        updatePlaceholderVisibility()
    }
    
    private func updatePlaceholderVisibility() {
        placeholderLabel?.isHidden = !text.isEmpty
    }
    
    // MARK: - 限制输入
    
    /// 限制最大长度
    /// - Parameter length: 最大长度
    func limitLength(_ length: Int) {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textViewDidChange),
            name: UITextView.textDidChangeNotification,
            object: self
        )
        objc_setAssociatedObject(self, &AssociatedKeys.maxLength, length, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    @objc private func textViewDidChange() {
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
    
    // MARK: - 计算尺寸
    
    /// 计算所需高度
    /// - Parameter width: 宽度
    /// - Returns: 所需高度
    func heightThatFits(width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        return sizeThatFits(size).height
    }
}

// 需要导入 Objective-C 运行时
import ObjectiveC

