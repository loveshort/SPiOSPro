//
//  SnapKitWrapper.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit
import SnapKit

// MARK: - SnapKit 便捷扩展
extension UIView {
    
    /// 快速设置约束（填充父视图）
    /// - Parameter insets: 内边距
    func fillSuperview(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else { return }
        snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(insets)
        }
    }
    
    /// 快速设置约束（居中）
    /// - Parameter size: 尺寸
    func centerInSuperview(size: CGSize? = nil) {
        guard let superview = superview else { return }
        snp.makeConstraints { make in
            make.center.equalToSuperview()
            if let size = size {
                make.size.equalTo(size)
            }
        }
    }
    
    /// 快速设置约束（顶部对齐）
    /// - Parameters:
    ///   - top: 顶部距离
    ///   - left: 左边距离
    ///   - right: 右边距离
    ///   - height: 高度
    func alignTop(top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, height: CGFloat? = nil) {
        guard let superview = superview else { return }
        snp.makeConstraints { make in
            make.top.equalToSuperview().offset(top)
            make.left.equalToSuperview().offset(left)
            make.right.equalToSuperview().offset(-right)
            if let height = height {
                make.height.equalTo(height)
            }
        }
    }
    
    /// 快速设置约束（底部对齐）
    /// - Parameters:
    ///   - bottom: 底部距离
    ///   - left: 左边距离
    ///   - right: 右边距离
    ///   - height: 高度
    func alignBottom(bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, height: CGFloat? = nil) {
        guard let superview = superview else { return }
        snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-bottom)
            make.left.equalToSuperview().offset(left)
            make.right.equalToSuperview().offset(-right)
            if let height = height {
                make.height.equalTo(height)
            }
        }
    }
    
    /// 快速设置约束（固定尺寸）
    /// - Parameter size: 尺寸
    func setSize(_ size: CGSize) {
        snp.makeConstraints { make in
            make.size.equalTo(size)
        }
    }
    
    /// 快速设置约束（固定宽高）
    /// - Parameters:
    ///   - width: 宽度
    ///   - height: 高度
    func setSize(width: CGFloat, height: CGFloat) {
        snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
}

// MARK: - 约束更新扩展
extension ConstraintMaker {
    
    /// 设置安全区域约束
    /// - Parameter view: 参考视图
    /// - Returns: 约束
    func safeAreaTop(_ view: UIView) -> ConstraintMakerEditable {
        if #available(iOS 11.0, *) {
            return top.equalTo(view.safeAreaLayoutGuide.snp.top)
        } else {
            return top.equalTo(view.snp.top)
        }
    }
    
    /// 设置安全区域约束
    /// - Parameter view: 参考视图
    /// - Returns: 约束
    func safeAreaBottom(_ view: UIView) -> ConstraintMakerEditable {
        if #available(iOS 11.0, *) {
            return bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        } else {
            return bottom.equalTo(view.snp.bottom)
        }
    }
}

