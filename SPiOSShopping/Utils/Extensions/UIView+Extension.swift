//
//  UIView+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit
import SnapKit

// MARK: - UIView 常用扩展
extension UIView {
    
    // MARK: - 圆角设置
    
    /// 设置圆角
    /// - Parameter radius: 圆角半径
    func setCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    /// 设置指定角的圆角
    /// - Parameters:
    ///   - corners: 需要设置的角
    ///   - radius: 圆角半径
    func setCornerRadius(_ radius: CGFloat, corners: UIRectCorner) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    /// 设置圆形
    func setRound() {
        setCornerRadius(min(bounds.width, bounds.height) / 2)
    }
    
    // MARK: - 边框设置
    
    /// 设置边框
    /// - Parameters:
    ///   - width: 边框宽度
    ///   - color: 边框颜色
    func setBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    // MARK: - 阴影设置
    
    /// 设置阴影
    /// - Parameters:
    ///   - color: 阴影颜色
    ///   - opacity: 阴影透明度
    ///   - offset: 阴影偏移
    ///   - radius: 阴影半径
    func setShadow(color: UIColor = .black,
                   opacity: Float = 0.1,
                   offset: CGSize = CGSize(width: 0, height: 2),
                   radius: CGFloat = 4) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
    }
    
    // MARK: - 渐变色
    
    /// 添加渐变色
    /// - Parameters:
    ///   - colors: 颜色数组
    ///   - startPoint: 起始点
    ///   - endPoint: 结束点
    func addGradientLayer(colors: [UIColor],
                         startPoint: CGPoint = CGPoint(x: 0, y: 0),
                         endPoint: CGPoint = CGPoint(x: 1, y: 0)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: - 动画
    
    /// 淡入动画
    /// - Parameters:
    ///   - duration: 动画时长
    ///   - completion: 完成回调
    func fadeIn(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        self.alpha = 0
        self.isHidden = false
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }) { _ in
            completion?()
        }
    }
    
    /// 淡出动画
    /// - Parameters:
    ///   - duration: 动画时长
    ///   - completion: 完成回调
    func fadeOut(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }) { _ in
            self.isHidden = true
            completion?()
        }
    }
    
    /// 缩放动画
    /// - Parameters:
    ///   - scale: 缩放比例
    ///   - duration: 动画时长
    ///   - completion: 完成回调
    func scaleAnimation(scale: CGFloat = 0.95, duration: TimeInterval = 0.2, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }) { _ in
            UIView.animate(withDuration: duration) {
                self.transform = .identity
            } completion: { _ in
                completion?()
            }
        }
    }
    
    // MARK: - 截图
    
    /// 截图
    /// - Returns: 截图图片
    func snapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    // MARK: - 移除所有子视图
    
    /// 移除所有子视图
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    // MARK: - 查找父视图控制器
    
    /// 查找父视图控制器
    /// - Returns: 父视图控制器
    func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            responder = responder?.next
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    // MARK: - 添加点击手势
    
    /// 添加点击手势
    /// - Parameters:
    ///   - target: 目标对象
    ///   - action: 响应方法
    func addTapGesture(target: Any?, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = 1
        isUserInteractionEnabled = true
        addGestureRecognizer(tap)
    }
}

