//
//  ShareHelper.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

// MARK: - 分享工具类
struct ShareHelper {
    
    /// 分享文本
    /// - Parameters:
    ///   - text: 要分享的文本
    ///   - viewController: 视图控制器
    ///   - sourceView: 来源视图（iPad需要）
    ///   - completion: 完成回调
    static func shareText(
        _ text: String,
        from viewController: UIViewController,
        sourceView: UIView? = nil,
        completion: ((Bool) -> Void)? = nil
    ) {
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        
        // iPad支持
        if let popover = activityVC.popoverPresentationController {
            popover.sourceView = sourceView ?? viewController.view
            popover.sourceRect = sourceView?.bounds ?? viewController.view.bounds
        }
        
        viewController.present(activityVC, animated: true, completion: nil)
    }
    
    /// 分享图片
    /// - Parameters:
    ///   - image: 要分享的图片
    ///   - viewController: 视图控制器
    ///   - sourceView: 来源视图（iPad需要）
    ///   - completion: 完成回调
    static func shareImage(
        _ image: UIImage,
        from viewController: UIViewController,
        sourceView: UIView? = nil,
        completion: ((Bool) -> Void)? = nil
    ) {
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        // iPad支持
        if let popover = activityVC.popoverPresentationController {
            popover.sourceView = sourceView ?? viewController.view
            popover.sourceRect = sourceView?.bounds ?? viewController.view.bounds
        }
        
        viewController.present(activityVC, animated: true, completion: nil)
    }
    
    /// 分享URL
    /// - Parameters:
    ///   - url: 要分享的URL
    ///   - viewController: 视图控制器
    ///   - sourceView: 来源视图（iPad需要）
    ///   - completion: 完成回调
    static func shareURL(
        _ url: URL,
        from viewController: UIViewController,
        sourceView: UIView? = nil,
        completion: ((Bool) -> Void)? = nil
    ) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        // iPad支持
        if let popover = activityVC.popoverPresentationController {
            popover.sourceView = sourceView ?? viewController.view
            popover.sourceRect = sourceView?.bounds ?? viewController.view.bounds
        }
        
        viewController.present(activityVC, animated: true, completion: nil)
    }
    
    /// 分享多个项目
    /// - Parameters:
    ///   - items: 要分享的项目数组
    ///   - viewController: 视图控制器
    ///   - sourceView: 来源视图（iPad需要）
    ///   - completion: 完成回调
    static func shareItems(
        _ items: [Any],
        from viewController: UIViewController,
        sourceView: UIView? = nil,
        completion: ((Bool) -> Void)? = nil
    ) {
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        // iPad支持
        if let popover = activityVC.popoverPresentationController {
            popover.sourceView = sourceView ?? viewController.view
            popover.sourceRect = sourceView?.bounds ?? viewController.view.bounds
        }
        
        viewController.present(activityVC, animated: true, completion: nil)
    }
}

// MARK: - UIViewController 分享扩展
extension UIViewController {
    
    /// 分享文本
    /// - Parameters:
    ///   - text: 要分享的文本
    ///   - sourceView: 来源视图（iPad需要）
    func shareText(_ text: String, sourceView: UIView? = nil) {
        ShareHelper.shareText(text, from: self, sourceView: sourceView)
    }
    
    /// 分享图片
    /// - Parameters:
    ///   - image: 要分享的图片
    ///   - sourceView: 来源视图（iPad需要）
    func shareImage(_ image: UIImage, sourceView: UIView? = nil) {
        ShareHelper.shareImage(image, from: self, sourceView: sourceView)
    }
    
    /// 分享URL
    /// - Parameters:
    ///   - url: 要分享的URL
    ///   - sourceView: 来源视图（iPad需要）
    func shareURL(_ url: URL, sourceView: UIView? = nil) {
        ShareHelper.shareURL(url, from: self, sourceView: sourceView)
    }
}

