//
//  UIScrollView+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

// MARK: - UIScrollView 常用扩展
extension UIScrollView {
    
    // MARK: - 滚动到指定位置
    
    /// 滚动到顶部
    /// - Parameter animated: 是否动画
    func scrollToTop(animated: Bool = true) {
        setContentOffset(.zero, animated: animated)
    }
    
    /// 滚动到底部
    /// - Parameter animated: 是否动画
    func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.height + contentInset.bottom)
        setContentOffset(bottomOffset, animated: animated)
    }
    
    /// 滚动到左侧
    /// - Parameter animated: 是否动画
    func scrollToLeft(animated: Bool = true) {
        setContentOffset(CGPoint(x: 0, y: contentOffset.y), animated: animated)
    }
    
    /// 滚动到右侧
    /// - Parameter animated: 是否动画
    func scrollToRight(animated: Bool = true) {
        let rightOffset = CGPoint(x: contentSize.width - bounds.width + contentInset.right, y: contentOffset.y)
        setContentOffset(rightOffset, animated: animated)
    }
    
    // MARK: - 判断位置
    
    /// 是否在顶部
    var isAtTop: Bool {
        return contentOffset.y <= -contentInset.top
    }
    
    /// 是否在底部
    var isAtBottom: Bool {
        return contentOffset.y >= contentSize.height - bounds.height + contentInset.bottom - 1
    }
    
    /// 是否在左侧
    var isAtLeft: Bool {
        return contentOffset.x <= -contentInset.left
    }
    
    /// 是否在右侧
    var isAtRight: Bool {
        return contentOffset.x >= contentSize.width - bounds.width + contentInset.right - 1
    }
    
    // MARK: - 可见区域
    
    /// 可见区域
    var visibleRect: CGRect {
        return CGRect(x: contentOffset.x, y: contentOffset.y, width: bounds.width, height: bounds.height)
    }
}

