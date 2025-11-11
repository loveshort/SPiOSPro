//
//  KingfisherWrapper.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit
import Kingfisher

// MARK: - Kingfisher 图片加载封装
extension UIImageView {
    
    /// 设置网络图片
    /// - Parameters:
    ///   - urlString: 图片URL字符串
    ///   - placeholder: 占位图
    ///   - completion: 完成回调
    func setImage(urlString: String?, placeholder: UIImage? = nil, completion: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = placeholder
            return
        }
        
        kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(0.3))], completionHandler: { result in
            completion?(result)
        })
    }
    
    /// 设置网络图片（带圆角）
    /// - Parameters:
    ///   - urlString: 图片URL字符串
    ///   - placeholder: 占位图
    ///   - cornerRadius: 圆角半径
    func setImage(urlString: String?, placeholder: UIImage? = nil, cornerRadius: CGFloat) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = placeholder
            return
        }
        
        let processor = RoundCornerImageProcessor(cornerRadius: cornerRadius)
        kf.setImage(with: url, placeholder: placeholder, options: [.processor(processor), .transition(.fade(0.3))])
    }
    
    /// 设置网络图片（圆形）
    /// - Parameters:
    ///   - urlString: 图片URL字符串
    ///   - placeholder: 占位图
    func setRoundImage(urlString: String?, placeholder: UIImage? = nil) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = placeholder
            return
        }
        
        let processor = RoundCornerImageProcessor(cornerRadius: bounds.width / 2)
        kf.setImage(with: url, placeholder: placeholder, options: [.processor(processor), .transition(.fade(0.3))])
    }
    
    /// 取消图片加载
    func cancelImageLoad() {
        kf.cancelDownloadTask()
    }
}

// MARK: - UIButton 图片加载扩展
extension UIButton {
    
    /// 设置网络图片（背景图）
    /// - Parameters:
    ///   - urlString: 图片URL字符串
    ///   - placeholder: 占位图
    ///   - state: 按钮状态
    func setBackgroundImage(urlString: String?, placeholder: UIImage? = nil, for state: UIControl.State = .normal) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            setBackgroundImage(placeholder, for: state)
            return
        }
        
        kf.setBackgroundImage(with: url, for: state, placeholder: placeholder, options: [.transition(.fade(0.3))])
    }
    
    /// 设置网络图片
    /// - Parameters:
    ///   - urlString: 图片URL字符串
    ///   - placeholder: 占位图
    ///   - state: 按钮状态
    func setImage(urlString: String?, placeholder: UIImage? = nil, for state: UIControl.State = .normal) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            setImage(placeholder, for: state)
            return
        }
        
        kf.setImage(with: url, for: state, placeholder: placeholder, options: [.transition(.fade(0.3))])
    }
}

// MARK: - Kingfisher 工具类
struct MCImageLoader {
    
    /// 预加载图片
    /// - Parameter urlStrings: 图片URL数组
    static func prefetchImages(_ urlStrings: [String]) {
        let urls = urlStrings.compactMap { URL(string: $0) }
        ImagePrefetcher(urls: urls).start()
    }
    
    /// 清除内存缓存
    static func clearMemoryCache() {
        ImageCache.default.clearMemoryCache()
    }
    
    /// 清除磁盘缓存
    static func clearDiskCache(completion: (() -> Void)? = nil) {
        ImageCache.default.clearDiskCache(completion: completion)
    }
    
    /// 获取缓存大小
    static func getCacheSize(completion: @escaping (UInt) -> Void) {
        ImageCache.default.calculateDiskStorageSize { result in
            switch result {
            case .success(let size):
                completion(size)
            case .failure:
                completion(0)
            }
        }
    }
}

