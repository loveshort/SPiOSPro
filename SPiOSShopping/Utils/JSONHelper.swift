//
//  JSONHelper.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation

// MARK: - JSON 工具类
struct JSONHelper {
    
    // MARK: - 编码
    
    /// 将对象编码为JSON数据
    /// - Parameter object: 要编码的对象
    /// - Returns: JSON数据
    static func encode<T: Encodable>(_ object: T) -> Data? {
        return try? JSONEncoder().encode(object)
    }
    
    /// 将对象编码为JSON字符串
    /// - Parameter object: 要编码的对象
    /// - Returns: JSON字符串
    static func encodeToString<T: Encodable>(_ object: T) -> String? {
        guard let data = encode(object) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    /// 将字典编码为JSON字符串
    /// - Parameter dictionary: 字典
    /// - Returns: JSON字符串
    static func encodeDictionary(_ dictionary: [String: Any]) -> String? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) else {
            return nil
        }
        return String(data: jsonData, encoding: .utf8)
    }
    
    // MARK: - 解码
    
    /// 将JSON数据解码为对象
    /// - Parameters:
    ///   - type: 对象类型
    ///   - data: JSON数据
    /// - Returns: 解码后的对象
    static func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
        return try? JSONDecoder().decode(type, from: data)
    }
    
    /// 将JSON字符串解码为对象
    /// - Parameters:
    ///   - type: 对象类型
    ///   - string: JSON字符串
    /// - Returns: 解码后的对象
    static func decode<T: Decodable>(_ type: T.Type, from string: String) -> T? {
        guard let data = string.data(using: .utf8) else { return nil }
        return decode(type, from: data)
    }
    
    /// 将JSON字符串解析为字典
    /// - Parameter string: JSON字符串
    /// - Returns: 字典
    static func parseDictionary(from string: String) -> [String: Any]? {
        guard let data = string.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
    
    /// 将JSON字符串解析为数组
    /// - Parameter string: JSON字符串
    /// - Returns: 数组
    static func parseArray(from string: String) -> [Any]? {
        guard let data = string.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [Any]
    }
    
    // MARK: - 验证
    
    /// 验证字符串是否为有效的JSON
    /// - Parameter string: 字符串
    /// - Returns: 是否有效
    static func isValidJSON(_ string: String) -> Bool {
        guard let data = string.data(using: .utf8) else { return false }
        do {
            _ = try JSONSerialization.jsonObject(with: data, options: [])
            return true
        } catch {
            return false
        }
    }
    
    // MARK: - 格式化
    
    /// 格式化JSON字符串（美化）
    /// - Parameter string: JSON字符串
    /// - Returns: 格式化后的字符串
    static func prettyPrint(_ string: String) -> String? {
        guard let data = string.data(using: .utf8),
              let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
              let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
            return nil
        }
        return String(data: prettyData, encoding: .utf8)
    }
}

// MARK: - Codable 扩展
extension Encodable {
    
    /// 转换为JSON字符串
    /// - Returns: JSON字符串
    func toJSONString() -> String? {
        return JSONHelper.encodeToString(self)
    }
    
    /// 转换为字典
    /// - Returns: 字典
    func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
}

extension Decodable {
    
    /// 从字典创建对象
    /// - Parameter dictionary: 字典
    /// - Returns: 对象
    static func fromDictionary(_ dictionary: [String: Any]) -> Self? {
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else {
            return nil
        }
        return try? JSONDecoder().decode(Self.self, from: data)
    }
    
    /// 从JSON字符串创建对象
    /// - Parameter string: JSON字符串
    /// - Returns: 对象
    static func fromJSONString(_ string: String) -> Self? {
        return JSONHelper.decode(Self.self, from: string)
    }
}

