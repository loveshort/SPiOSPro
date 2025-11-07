//
//  EmptyDataSetWrapper.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit
import EmptyDataSet_Swift

// MARK: - EmptyDataSet 配置协议
protocol MCEmptyDataSetConfig {
    var emptyTitle: String? { get }
    var emptyDescription: String? { get }
    var emptyImage: UIImage? { get }
    var emptyButtonTitle: String? { get }
    var emptyButtonAction: (() -> Void)? { get }
}

// MARK: - UIScrollView 空数据视图扩展
extension UIScrollView {
    
    /// 设置空数据视图
    /// - Parameters:
    ///   - title: 标题
    ///   - description: 描述
    ///   - image: 图片
    ///   - buttonTitle: 按钮标题
    ///   - buttonAction: 按钮点击事件
    func setEmptyDataSet(
        title: String? = nil,
        description: String? = nil,
        image: UIImage? = nil,
        buttonTitle: String? = nil,
        buttonAction: (() -> Void)? = nil
    ) {
        emptyDataSetSource = self
        emptyDataSetDelegate = self
        
        // 存储配置
        objc_setAssociatedObject(self, &AssociatedKeys.emptyTitle, title, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.emptyDescription, description, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.emptyImage, image, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.emptyButtonTitle, buttonTitle, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &AssociatedKeys.emptyButtonAction, buttonAction, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    /// 移除空数据视图
    func removeEmptyDataSet() {
        emptyDataSetSource = nil
        emptyDataSetDelegate = nil
    }
    
    private struct AssociatedKeys {
        static var emptyTitle = "emptyTitle"
        static var emptyDescription = "emptyDescription"
        static var emptyImage = "emptyImage"
        static var emptyButtonTitle = "emptyButtonTitle"
        static var emptyButtonAction = "emptyButtonAction"
    }
    
    private var emptyTitle: String? {
        return objc_getAssociatedObject(self, &AssociatedKeys.emptyTitle) as? String
    }
    
    private var emptyDescription: String? {
        return objc_getAssociatedObject(self, &AssociatedKeys.emptyDescription) as? String
    }
    
    private var emptyImage: UIImage? {
        return objc_getAssociatedObject(self, &AssociatedKeys.emptyImage) as? UIImage
    }
    
    private var emptyButtonTitle: String? {
        return objc_getAssociatedObject(self, &AssociatedKeys.emptyButtonTitle) as? String
    }
    
    private var emptyButtonAction: (() -> Void)? {
        return objc_getAssociatedObject(self, &AssociatedKeys.emptyButtonAction) as? (() -> Void)
    }
}

// MARK: - EmptyDataSetSource
extension UIScrollView: EmptyDataSetSource {
    
    public func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        guard let title = emptyTitle else { return nil }
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.textPrimaryColor
        ]
        return NSAttributedString(string: title, attributes: attributes)
    }
    
    public func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        guard let description = emptyDescription else { return nil }
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.textSecondaryColor
        ]
        return NSAttributedString(string: description, attributes: attributes)
    }
    
    public func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return emptyImage ?? UIImage(systemName: "tray")
    }
    
    public func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        guard let buttonTitle = emptyButtonTitle else { return nil }
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15),
            .foregroundColor: state == .normal ? UIColor.mainColor : UIColor.mainColor.withAlphaComponent(0.7)
        ]
        return NSAttributedString(string: buttonTitle, attributes: attributes)
    }
}

// MARK: - EmptyDataSetDelegate
extension UIScrollView: EmptyDataSetDelegate {
    
    public func emptyDataSet(_ scrollView: UIScrollView, didTapButton button: UIButton) {
        emptyButtonAction?()
    }
    
    public func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return true
    }
}

// 需要导入 Objective-C 运行时
import ObjectiveC

