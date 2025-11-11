//
//  UIButton+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

// MARK: - UIButton 常用扩展
extension UIButton {
    
    // MARK: - 便捷初始化
    
    /// 便捷初始化
    /// - Parameters:
    ///   - title: 标题
    ///   - titleColor: 标题颜色
    ///   - font: 字体
    ///   - image: 图片
    ///   - backgroundColor: 背景颜色
    convenience init(title: String? = nil,
                    titleColor: UIColor? = nil,
                    font: UIFont? = nil,
                    image: UIImage? = nil,
                    backgroundColor: UIColor? = nil) {
        self.init(type: .custom)
        setTitle(title, for: .normal)
        setTitleColor(titleColor ?? .mainColor, for: .normal)
        titleLabel?.font = font ?? UIFont.systemFont(ofSize: 16)
        setImage(image, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
    // MARK: - 样式设置
    
    /// 设置标题
    /// - Parameter title: 标题
    func setTitle(_ title: String?) {
        setTitle(title, for: .normal)
    }
    
    /// 设置标题颜色
    /// - Parameter color: 颜色
    func setTitleColor(_ color: UIColor) {
        setTitleColor(color, for: .normal)
    }
    
    /// 设置字体大小
    /// - Parameter size: 字体大小
    func setFontSize(_ size: CGFloat) {
        titleLabel?.font = titleLabel?.font?.withSize(size) ?? UIFont.systemFont(ofSize: size)
    }
    
    /// 设置图片
    /// - Parameter image: 图片
    func setImage(_ image: UIImage?) {
        setImage(image, for: .normal)
    }
    
    /// 设置背景图片
    /// - Parameter image: 图片
    func setBackgroundImage(_ image: UIImage?) {
        setBackgroundImage(image, for: .normal)
    }
    
    // MARK: - 布局设置
    
    /// 设置图片和文字的位置
    /// - Parameters:
    ///   - imagePosition: 图片位置
    ///   - spacing: 间距
    func setImagePosition(_ imagePosition: ImagePosition, spacing: CGFloat = 0) {
        guard let imageView = imageView, let titleLabel = titleLabel else { return }
        
        let imageSize = imageView.frame.size
        let titleSize = titleLabel.frame.size
        
        var imageEdgeInsets = UIEdgeInsets.zero
        var titleEdgeInsets = UIEdgeInsets.zero
        
        switch imagePosition {
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing / 2, bottom: 0, right: spacing / 2)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing / 2, bottom: 0, right: -spacing / 2)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: titleSize.width + spacing / 2, bottom: 0, right: -titleSize.width - spacing / 2)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width - spacing / 2, bottom: 0, right: imageSize.width + spacing / 2)
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -titleSize.height - spacing / 2, left: 0, bottom: 0, right: -titleSize.width)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -imageSize.height - spacing / 2, right: 0)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -titleSize.height - spacing / 2, right: -titleSize.width)
            titleEdgeInsets = UIEdgeInsets(top: -imageSize.height - spacing / 2, left: -imageSize.width, bottom: 0, right: 0)
        }
        
        self.imageEdgeInsets = imageEdgeInsets
        self.titleEdgeInsets = titleEdgeInsets
    }
    
    /// 图片位置枚举
    enum ImagePosition {
        case left
        case right
        case top
        case bottom
    }
    
    // MARK: - 点击区域扩展
    
    /// 扩大点击区域
    /// - Parameter insets: 内边距
    func enlargeTouchArea(insets: UIEdgeInsets) {
        objc_setAssociatedObject(self, &AssociatedKeys.touchAreaInsets, insets, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    private struct AssociatedKeys {
        static var touchAreaInsets = "touchAreaInsets"
    }
    
    private var touchAreaInsets: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.touchAreaInsets) as? UIEdgeInsets
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.touchAreaInsets, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let insets = touchAreaInsets else {
            return super.point(inside: point, with: event)
        }
        let rect = bounds.inset(by: insets)
        return rect.contains(point)
    }
}

// 需要导入 Objective-C 运行时
import ObjectiveC

