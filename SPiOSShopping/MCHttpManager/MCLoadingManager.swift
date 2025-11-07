//
//  MCLoadingManager.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit
import RxSwift

// MARK: - 加载状态管理器
public class MCLoadingManager {
    
    /// 单例
    public static let shared = MCLoadingManager()
    
    /// 当前显示的加载视图
    private var loadingView: UIView?
    
    private init() {}
    
    // MARK: - 显示加载
    
    /// 显示加载视图
    /// - Parameters:
    ///   - message: 加载提示文字
    ///   - inView: 显示在哪个视图上（nil则显示在window上）
    public func showLoading(message: String = "加载中...", inView: UIView? = nil) {
        hideLoading()
        
        let containerView = inView ?? UIApplication.shared.currentWindow
        
        let loadingView = createLoadingView(message: message)
        self.loadingView = loadingView
        
        containerView?.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.fadeIn()
    }
    
    /// 隐藏加载视图
    public func hideLoading() {
        loadingView?.fadeOut { [weak self] in
            self?.loadingView?.removeFromSuperview()
            self?.loadingView = nil
        }
    }
    
    // MARK: - 创建加载视图
    
    private func createLoadingView(message: String) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.setCornerRadius(10)
        contentView.setShadow(color: .black, opacity: 0.2, radius: 8)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .mainColor
        activityIndicator.startAnimating()
        
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textColor = .textPrimaryColor
        messageLabel.textAlignment = .center
        
        contentView.addSubview(activityIndicator)
        contentView.addSubview(messageLabel)
        containerView.addSubview(contentView)
        
        activityIndicator.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(activityIndicator.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        contentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(120)
        }
        
        return containerView
    }
}

// MARK: - Observable 扩展（自动显示/隐藏加载）
extension ObservableType {
    
    /// 自动显示/隐藏加载视图
    /// - Parameters:
    ///   - message: 加载提示文字
    ///   - inView: 显示在哪个视图上
    /// - Returns: Observable
    public func showLoading(message: String = "加载中...", inView: UIView? = nil) -> Observable<Element> {
        return self.do(
            onSubscribe: {
                MCLoadingManager.shared.showLoading(message: message, inView: inView)
            },
            onDispose: {
                MCLoadingManager.shared.hideLoading()
            }
        )
    }
}

// 需要导入 SnapKit
import SnapKit

