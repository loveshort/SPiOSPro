//
//  MCResponse.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation

// MARK: - 统一响应模型
/// 统一响应模型
public struct MCResponse<T: Codable>: Codable {
    /// 状态码
    public let code: Int
    /// 消息
    public let message: String
    /// 数据
    public let data: T?
    /// 是否成功
    public var isSuccess: Bool {
        return code == 200 || code == 0
    }
    
    public init(code: Int, message: String, data: T?) {
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - 分页响应模型
/// 分页响应模型
public struct MCPageResponse<T: Codable>: Codable {
    /// 列表数据
    public let list: [T]
    /// 总数
    public let total: Int
    /// 当前页
    public let page: Int
    /// 每页数量
    public let pageSize: Int
    /// 总页数
    public var totalPages: Int {
        return (total + pageSize - 1) / pageSize
    }
    /// 是否有下一页
    public var hasNextPage: Bool {
        return page < totalPages
    }
    
    public init(list: [T], total: Int, page: Int, pageSize: Int) {
        self.list = list
        self.total = total
        self.page = page
        self.pageSize = pageSize
    }
}

// MARK: - 空响应模型
/// 空响应模型（用于不需要返回数据的接口）
public struct MCEmptyResponse: Codable {
    public init() {}
}

// MARK: - 网络错误
/// 网络错误枚举
public enum MCNetworkError: Error, LocalizedError {
    /// 网络不可用
    case networkUnavailable
    /// 请求超时
    case timeout
    /// 服务器错误
    case serverError(Int, String)
    /// 数据解析失败
    case decodeError(Error)
    /// 未知错误
    case unknown(Error)
    /// 业务错误（自定义错误码和消息）
    case businessError(Int, String)
    
    public var errorDescription: String? {
        switch self {
        case .networkUnavailable:
            return "网络不可用，请检查网络连接"
        case .timeout:
            return "请求超时，请稍后重试"
        case .serverError(let code, let message):
            return "服务器错误(\(code)): \(message)"
        case .decodeError(let error):
            return "数据解析失败: \(error.localizedDescription)"
        case .unknown(let error):
            return "未知错误: \(error.localizedDescription)"
        case .businessError(_, let message):
            return message
        }
    }
    
    public var code: Int {
        switch self {
        case .networkUnavailable:
            return -1001
        case .timeout:
            return -1002
        case .serverError(let code, _):
            return code
        case .decodeError:
            return -1003
        case .unknown:
            return -1004
        case .businessError(let code, _):
            return code
        }
    }
}

