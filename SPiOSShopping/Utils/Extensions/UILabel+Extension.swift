//
//  UILabel+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

// MARK: - UILabel 常用扩展
extension UILabel {
    
    // MARK: - 便捷初始化
    
    /// 便捷初始化
    /// - Parameters:
    ///   - text: 文本
    ///   - font: 字体
    ///   - color: 颜色
    ///   - alignment: 对齐方式
    convenience init(text: String? = nil,
                    font: UIFont? = nil,
                    color: UIColor? = nil,
                    alignment: NSTextAlignment = .left) {
        self.init()
        self.text = text
        self.font = font ?? UIFont.systemFont(ofSize: 14)
        self.textColor = color ?? .textPrimaryColor
        self.textAlignment = alignment
    }
    
    // MARK: - 文本设置
    
    /// 设置文本（可选，nil时不设置）
    /// - Parameter text: 文本
    func setText(_ text: String?) {
        self.text = text
    }
    
    /// 设置富文本
    /// - Parameter attributedText: 富文本
    func setAttributedText(_ attributedText: NSAttributedString?) {
        self.attributedText = attributedText
    }
    
    // MARK: - 样式设置
    
    /// 设置字体大小
    /// - Parameter size: 字体大小
    func setFontSize(_ size: CGFloat) {
        font = font?.withSize(size) ?? UIFont.systemFont(ofSize: size)
    }
    
    /// 设置粗体
    /// - Parameter size: 字体大小
    func setBoldFont(size: CGFloat) {
        font = UIFont.boldSystemFont(ofSize: size)
    }
    
    /// 设置文本颜色
    /// - Parameter color: 颜色
    func setTextColor(_ color: UIColor) {
        self.textColor = color
    }
    
    // MARK: - 行数设置
    
    /// 设置最大行数（0表示不限制）
    /// - Parameter lines: 行数
    func setMaxLines(_ lines: Int) {
        numberOfLines = lines
        if lines == 0 {
            lineBreakMode = .byWordWrapping
        } else if lines == 1 {
            lineBreakMode = .byTruncatingTail
        }
    }
    
    // MARK: - 行间距设置
    
    /// 设置行间距
    /// - Parameter spacing: 行间距
    func setLineSpacing(_ spacing: CGFloat) {
        guard let text = self.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text.count))
        self.attributedText = attributedString
    }
    
    // MARK: - 计算尺寸
    
    /// 计算所需尺寸
    /// - Parameter maxWidth: 最大宽度
    /// - Returns: 所需尺寸
    func sizeThatFits(maxWidth: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        let size = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        return sizeThatFits(size)
    }
    
    /// 计算所需高度
    /// - Parameter width: 宽度
    /// - Returns: 所需高度
    func heightThatFits(width: CGFloat) -> CGFloat {
        return sizeThatFits(maxWidth: width).height
    }
}

