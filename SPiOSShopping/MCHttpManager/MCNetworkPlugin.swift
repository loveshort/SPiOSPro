//
//  MCNetworkPlugin.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation
import Moya

// MARK: - 网络请求插件
/// 网络请求插件（用于添加Token等）
public struct MCNetworkPlugin: PluginType {
    
    /// Token获取闭包
    public var tokenClosure: (() -> String?)?
    
    /// 请求前处理
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        
        // 添加Token
        if let token = tokenClosure?() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        // 添加其他通用Header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("iOS", forHTTPHeaderField: "Platform")
        request.setValue(UIDevice.current.systemVersion, forHTTPHeaderField: "OS-Version")
        request.setValue(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "", forHTTPHeaderField: "App-Version")
        
        return request
    }
    
    /// 请求完成处理
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            // 可以在这里处理成功响应，如打印日志
            if let url = response.response?.url {
                PrintHelper.debug("请求成功: \(url.absoluteString)")
            }
        case .failure(let error):
            // 可以在这里处理错误，如打印日志
            PrintHelper.error("请求失败: \(error.localizedDescription)")
        }
    }
}

// MARK: - 网络日志插件
/// 网络日志插件
public struct MCNetworkLoggerPlugin: PluginType {
    
    public init() {}
    
    public func willSend(_ request: RequestType, target: TargetType) {
        #if DEBUG
        if let urlRequest = request.request {
            PrintHelper.debug("""
            ========== 请求开始 ==========
            URL: \(urlRequest.url?.absoluteString ?? "")
            Method: \(urlRequest.httpMethod ?? "")
            Headers: \(urlRequest.allHTTPHeaderFields ?? [:])
            Body: \(String(data: urlRequest.httpBody ?? Data(), encoding: .utf8) ?? "")
            ==============================
            """)
        }
        #endif
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        #if DEBUG
        switch result {
        case .success(let response):
            PrintHelper.debug("""
            ========== 响应成功 ==========
            URL: \(response.response?.url?.absoluteString ?? "")
            Status: \(response.statusCode)
            Data: \(String(data: response.data, encoding: .utf8) ?? "")
            ==============================
            """)
        case .failure(let error):
            PrintHelper.error("""
            ========== 响应失败 ==========
            Error: \(error.localizedDescription)
            ==============================
            """)
        }
        #endif
    }
}

