//
//  RouterWrapper.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit
import JLSwiftRouter

// MARK: - 路由封装
struct MCRouter {
    
    /// 单例
    static let shared = MCRouter()
    
    private init() {}
    
    // MARK: - 路由注册
    
    /// 注册路由
    /// - Parameters:
    ///   - path: 路由路径
    ///   - handler: 处理闭包
    func register(path: String, handler: @escaping ([String: Any]?) -> UIViewController?) {
        Router.shared.register(path: path) { params in
            return handler(params)
        }
    }
    
    // MARK: - 路由跳转
    
    /// 跳转到指定路径
    /// - Parameters:
    ///   - path: 路由路径
    ///   - params: 参数
    ///   - from: 来源视图控制器
    ///   - animated: 是否动画
    ///   - completion: 完成回调
    func push(
        path: String,
        params: [String: Any]? = nil,
        from: UIViewController? = nil,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        guard let viewController = Router.shared.viewController(for: path, params: params) else {
            PrintHelper.error("路由跳转失败: 未找到路径 \(path)")
            return
        }
        
        let fromVC = from ?? UIApplication.shared.rootViewController?.topViewController()
        fromVC?.navigationController?.pushViewController(viewController, animated: animated)
        completion?()
    }
    
    /// 模态弹出
    /// - Parameters:
    ///   - path: 路由路径
    ///   - params: 参数
    ///   - from: 来源视图控制器
    ///   - animated: 是否动画
    ///   - completion: 完成回调
    func present(
        path: String,
        params: [String: Any]? = nil,
        from: UIViewController? = nil,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        guard let viewController = Router.shared.viewController(for: path, params: params) else {
            PrintHelper.error("路由跳转失败: 未找到路径 \(path)")
            return
        }
        
        let fromVC = from ?? UIApplication.shared.rootViewController?.topViewController()
        fromVC?.present(viewController, animated: animated, completion: completion)
    }
    
    /// 获取视图控制器（不跳转）
    /// - Parameters:
    ///   - path: 路由路径
    ///   - params: 参数
    /// - Returns: 视图控制器
    func viewController(path: String, params: [String: Any]? = nil) -> UIViewController? {
        return Router.shared.viewController(for: path, params: params)
    }
}

// MARK: - UIViewController 路由扩展
extension UIViewController {
    
    /// 路由跳转（Push）
    /// - Parameters:
    ///   - path: 路由路径
    ///   - params: 参数
    ///   - animated: 是否动画
    func push(path: String, params: [String: Any]? = nil, animated: Bool = true) {
        MCRouter.shared.push(path: path, params: params, from: self, animated: animated)
    }
    
    /// 路由跳转（Present）
    /// - Parameters:
    ///   - path: 路由路径
    ///   - params: 参数
    ///   - animated: 是否动画
    ///   - completion: 完成回调
    func present(path: String, params: [String: Any]? = nil, animated: Bool = true, completion: (() -> Void)? = nil) {
        MCRouter.shared.present(path: path, params: params, from: self, animated: animated, completion: completion)
    }
}

// MARK: - UIViewController 扩展（获取顶层视图控制器）
extension UIViewController {
    
    /// 获取顶层视图控制器
    /// - Returns: 顶层视图控制器
    func topViewController() -> UIViewController? {
        if let presented = presentedViewController {
            return presented.topViewController()
        }
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topViewController()
        }
        
        if let tabBar = self as? UITabBarController {
            return tabBar.selectedViewController?.topViewController()
        }
        
        return self
    }
}

