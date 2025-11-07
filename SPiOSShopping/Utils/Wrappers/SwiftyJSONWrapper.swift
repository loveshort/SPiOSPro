//
//  SwiftyJSONWrapper.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation
import SwiftyJSON

// MARK: - SwiftyJSON 便捷扩展
extension JSON {
    
    /// 安全获取字符串
    /// - Parameter defaultValue: 默认值
    /// - Returns: 字符串值
    func stringValue(_ defaultValue: String = "") -> String {
        return string ?? defaultValue
    }
    
    /// 安全获取整数
    /// - Parameter defaultValue: 默认值
    /// - Returns: 整数值
    func intValue(_ defaultValue: Int = 0) -> Int {
        return int ?? defaultValue
    }
    
    /// 安全获取浮点数
    /// - Parameter defaultValue: 默认值
    /// - Returns: 浮点数值
    func doubleValue(_ defaultValue: Double = 0.0) -> Double {
        return double ?? defaultValue
    }
    
    /// 安全获取布尔值
    /// - Parameter defaultValue: 默认值
    /// - Returns: 布尔值
    func boolValue(_ defaultValue: Bool = false) -> Bool {
        return bool ?? defaultValue
    }
    
    /// 安全获取数组
    /// - Returns: 数组
    func arrayValue() -> [JSON] {
        return array ?? []
    }
    
    /// 安全获取字典
    /// - Returns: 字典
    func dictionaryValue() -> [String: JSON] {
        return dictionary ?? [:]
    }
}

// MARK: - SwiftyJSON 工具类
struct MCJSONHelper {
    
    /// 从字符串创建JSON
    /// - Parameter string: JSON字符串
    /// - Returns: JSON对象
    static func parse(_ string: String) -> JSON? {
        guard let data = string.data(using: .utf8) else { return nil }
        return try? JSON(data: data)
    }
    
    /// 从Data创建JSON
    /// - Parameter data: 数据
    /// - Returns: JSON对象
    static func parse(_ data: Data) -> JSON? {
        return try? JSON(data: data)
    }
    
    /// 从字典创建JSON
    /// - Parameter dictionary: 字典
    /// - Returns: JSON对象
    static func parse(_ dictionary: [String: Any]) -> JSON {
        return JSON(dictionary)
    }
    
    /// 从数组创建JSON
    /// - Parameter array: 数组
    /// - Returns: JSON对象
    static func parse(_ array: [Any]) -> JSON {
        return JSON(array)
    }
    
    /// JSON转字符串
    /// - Parameter json: JSON对象
    /// - Returns: JSON字符串
    static func stringify(_ json: JSON) -> String? {
        return json.rawString()
    }
    
    /// JSON转字典
    /// - Parameter json: JSON对象
    /// - Returns: 字典
    static func toDictionary(_ json: JSON) -> [String: Any]? {
        return json.dictionaryObject
    }
    
    /// JSON转数组
    /// - Parameter json: JSON对象
    /// - Returns: 数组
    static func toArray(_ json: JSON) -> [Any]? {
        return json.arrayObject
    }
}

// MARK: - Codable 转 JSON
extension Encodable {
    
    /// 转换为JSON
    /// - Returns: JSON对象
    func toJSON() -> JSON? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return try? JSON(data: data)
    }
}

// MARK: - JSON 转 Codable
extension JSON {
    
    /// 转换为Codable对象
    /// - Parameter type: 对象类型
    /// - Returns: 对象
    func toObject<T: Decodable>(_ type: T.Type) -> T? {
        guard let data = try? rawData() else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }
}

