//
//  Dictionary+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation

// MARK: - Dictionary 常用扩展
extension Dictionary {
    
    // MARK: - 安全访问
    
    /// 安全获取值
    /// - Parameter key: 键
    /// - Returns: 值（如果存在）
    func safeValue(forKey key: Key) -> Value? {
        return self[key]
    }
    
    /// 合并字典
    /// - Parameter other: 另一个字典
    /// - Returns: 合并后的字典
    func merging(_ other: [Key: Value]) -> [Key: Value] {
        var result = self
        for (key, value) in other {
            result[key] = value
        }
        return result
    }
    
    /// 合并字典（可变版本）
    /// - Parameter other: 另一个字典
    mutating func merge(_ other: [Key: Value]) {
        for (key, value) in other {
            self[key] = value
        }
    }
    
    // MARK: - 转换
    
    /// 转换为JSON字符串
    /// - Returns: JSON字符串
    func toJSONString() -> String? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else {
            return nil
        }
        return String(data: jsonData, encoding: .utf8)
    }
    
    /// 转换为查询字符串
    /// - Returns: 查询字符串
    func toQueryString() -> String {
        return map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
    }
}

// MARK: - Dictionary where Key == String
extension Dictionary where Key == String {
    
    /// 获取字符串值
    /// - Parameter key: 键
    /// - Returns: 字符串值
    func string(forKey key: String) -> String? {
        if let value = self[key] as? String {
            return value
        } else if let value = self[key] {
            return "\(value)"
        }
        return nil
    }
    
    /// 获取整数值
    /// - Parameter key: 键
    /// - Returns: 整数值
    func int(forKey key: String) -> Int? {
        if let value = self[key] as? Int {
            return value
        } else if let value = self[key] as? String {
            return Int(value)
        }
        return nil
    }
    
    /// 获取浮点数值
    /// - Parameter key: 键
    /// - Returns: 浮点数值
    func double(forKey key: String) -> Double? {
        if let value = self[key] as? Double {
            return value
        } else if let value = self[key] as? Float {
            return Double(value)
        } else if let value = self[key] as? String {
            return Double(value)
        }
        return nil
    }
    
    /// 获取布尔值
    /// - Parameter key: 键
    /// - Returns: 布尔值
    func bool(forKey key: String) -> Bool? {
        if let value = self[key] as? Bool {
            return value
        } else if let value = self[key] as? String {
            return value.lowercased() == "true" || value == "1"
        } else if let value = self[key] as? Int {
            return value != 0
        }
        return nil
    }
    
    /// 获取数组值
    /// - Parameter key: 键
    /// - Returns: 数组值
    func array<T>(forKey key: String, as type: T.Type) -> [T]? {
        return self[key] as? [T]
    }
    
    /// 获取字典值
    /// - Parameter key: 键
    /// - Returns: 字典值
    func dictionary(forKey key: String) -> [String: Any]? {
        return self[key] as? [String: Any]
    }
}

