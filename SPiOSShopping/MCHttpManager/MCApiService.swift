//
//  MCApiService.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation
import Moya

/// API服务枚举
public enum MCApiService {
    // 用户相关
    case login(username: String, password: String)
    case register(username: String, password: String, email: String)
    case userInfo(userId: Int)
    
    // 商品相关
    case productList(page: Int, pageSize: Int, categoryId: Int?)
    case productDetail(productId: Int)
    case searchProducts(keyword: String, page: Int, pageSize: Int)
    
    // 购物车相关
    case cartList
    case addToCart(productId: Int, count: Int)
    case updateCart(cartItemId: Int, count: Int)
    case removeFromCart(cartItemId: Int)
    
    // 订单相关
    case createOrder(cartItemIds: [Int], addressId: Int)
    case orderList(status: Int?, page: Int, pageSize: Int)
    case orderDetail(orderId: Int)
    
    // 其他
    case banners
    case categories
}

/// 缓存专用API服务枚举
public enum MCCacheApiService: MCCacheOnlyTarget {
    case banners
    case categories
    case productList(page: Int, pageSize: Int, categoryId: Int?)
}

// MARK: - TargetType 实现
extension MCApiService: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.example.com")!
    }
    
    public var path: String {
        switch self {
        // 用户相关
        case .login:
            return "/user/login"
        case .register:
            return "/user/register"
        case .userInfo(let userId):
            return "/user/\(userId)"
            
        // 商品相关
        case .productList:
            return "/products"
        case .productDetail(let productId):
            return "/products/\(productId)"
        case .searchProducts:
            return "/products/search"
            
        // 购物车相关
        case .cartList:
            return "/cart"
        case .addToCart:
            return "/cart/add"
        case .updateCart:
            return "/cart/update"
        case .removeFromCart:
            return "/cart/remove"
            
        // 订单相关
        case .createOrder:
            return "/orders/create"
        case .orderList:
            return "/orders"
        case .orderDetail(let orderId):
            return "/orders/\(orderId)"
            
        // 其他
        case .banners:
            return "/banners"
        case .categories:
            return "/categories"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login, .register, .addToCart, .updateCart, .createOrder:
            return .post
        case .removeFromCart:
            return .delete
        default:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        // 用户相关
        case .login(let username, let password):
            return .requestParameters(parameters: ["username": username, "password": password], encoding: JSONEncoding.default)
        case .register(let username, let password, let email):
            return .requestParameters(parameters: ["username": username, "password": password, "email": email], encoding: JSONEncoding.default)
        case .userInfo:
            return .requestPlain
            
        // 商品相关
        case .productList(let page, let pageSize, let categoryId):
            var params: [String: Any] = ["page": page, "pageSize": pageSize]
            if let categoryId = categoryId {
                params["categoryId"] = categoryId
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .productDetail:
            return .requestPlain
        case .searchProducts(let keyword, let page, let pageSize):
            return .requestParameters(parameters: ["keyword": keyword, "page": page, "pageSize": pageSize], encoding: URLEncoding.queryString)
            
        // 购物车相关
        case .cartList:
            return .requestPlain
        case .addToCart(let productId, let count):
            return .requestParameters(parameters: ["productId": productId, "count": count], encoding: JSONEncoding.default)
        case .updateCart(let cartItemId, let count):
            return .requestParameters(parameters: ["cartItemId": cartItemId, "count": count], encoding: JSONEncoding.default)
        case .removeFromCart(let cartItemId):
            return .requestParameters(parameters: ["cartItemId": cartItemId], encoding: URLEncoding.queryString)
            
        // 订单相关
        case .createOrder(let cartItemIds, let addressId):
            return .requestParameters(parameters: ["cartItemIds": cartItemIds, "addressId": addressId], encoding: JSONEncoding.default)
        case .orderList(let status, let page, let pageSize):
            var params: [String: Any] = ["page": page, "pageSize": pageSize]
            if let status = status {
                params["status"] = status
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .orderDetail:
            return .requestPlain
            
        // 其他
        case .banners, .categories:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var sampleData: Data {
        return Data()
    }
}

// MARK: - 缓存专用API实现
extension MCCacheApiService: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.example.com")!
    }
    
    public var path: String {
        switch self {
        case .banners:
            return "/banners"
        case .categories:
            return "/categories"
        case .productList:
            return "/products"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        switch self {
        case .productList(let page, let pageSize, let categoryId):
            var params: [String: Any] = ["page": page, "pageSize": pageSize]
            if let categoryId = categoryId {
                params["categoryId"] = categoryId
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var sampleData: Data {
        return Data()
    }
}