//
//  UserDefaults+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation

// MARK: - UserDefaults 扩展
extension UserDefaults {
    
    /// 单例
    static var standard: UserDefaults {
        return UserDefaults.standard
    }
    
    // MARK: - 通用存储方法
    
    /// 存储Codable对象
    /// - Parameters:
    ///   - object: 要存储的对象
    ///   - key: 键
    func set<T: Codable>(_ object: T, forKey key: String) {
        if let encoded = try? JSONEncoder().encode(object) {
            set(encoded, forKey: key)
        }
    }
    
    /// 获取Codable对象
    /// - Parameters:
    ///   - type: 对象类型
    ///   - key: 键
    /// - Returns: 对象
    func get<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }
    
    // MARK: - 便捷方法
    
    /// 存储字符串
    /// - Parameters:
    ///   - value: 值
    ///   - key: 键
    func setString(_ value: String?, forKey key: String) {
        set(value, forKey: key)
    }
    
    /// 获取字符串
    /// - Parameter key: 键
    /// - Returns: 字符串值
    func getString(forKey key: String) -> String? {
        return string(forKey: key)
    }
    
    /// 存储整数
    /// - Parameters:
    ///   - value: 值
    ///   - key: 键
    func setInt(_ value: Int, forKey key: String) {
        set(value, forKey: key)
    }
    
    /// 获取整数
    /// - Parameter key: 键
    /// - Returns: 整数值
    func getInt(forKey key: String) -> Int {
        return integer(forKey: key)
    }
    
    /// 存储布尔值
    /// - Parameters:
    ///   - value: 值
    ///   - key: 键
    func setBool(_ value: Bool, forKey key: String) {
        set(value, forKey: key)
    }
    
    /// 获取布尔值
    /// - Parameter key: 键
    /// - Returns: 布尔值
    func getBool(forKey key: String) -> Bool {
        return bool(forKey: key)
    }
    
    /// 存储浮点数
    /// - Parameters:
    ///   - value: 值
    ///   - key: 键
    func setDouble(_ value: Double, forKey key: String) {
        set(value, forKey: key)
    }
    
    /// 获取浮点数
    /// - Parameter key: 键
    /// - Returns: 浮点数值
    func getDouble(forKey key: String) -> Double {
        return double(forKey: key)
    }
    
    /// 存储日期
    /// - Parameters:
    ///   - value: 日期
    ///   - key: 键
    func setDate(_ value: Date?, forKey key: String) {
        if let date = value {
            set(date.timeIntervalSince1970, forKey: key)
        } else {
            removeObject(forKey: key)
        }
    }
    
    /// 获取日期
    /// - Parameter key: 键
    /// - Returns: 日期
    func getDate(forKey key: String) -> Date? {
        let timestamp = double(forKey: key)
        return timestamp > 0 ? Date(timeIntervalSince1970: timestamp) : nil
    }
    
    /// 存储数组
    /// - Parameters:
    ///   - value: 数组
    ///   - key: 键
    func setArray<T: Codable>(_ value: [T]?, forKey key: String) {
        if let array = value {
            set(array, forKey: key)
        } else {
            removeObject(forKey: key)
        }
    }
    
    /// 获取数组
    /// - Parameters:
    ///   - type: 元素类型
    ///   - key: 键
    /// - Returns: 数组
    func getArray<T: Codable>(_ type: T.Type, forKey key: String) -> [T]? {
        return get([T].self, forKey: key)
    }
    
    // MARK: - 删除
    
    /// 删除指定键的值
    /// - Parameter key: 键
    func remove(forKey key: String) {
        removeObject(forKey: key)
    }
    
    /// 删除多个键的值
    /// - Parameter keys: 键数组
    func remove(forKeys keys: [String]) {
        keys.forEach { removeObject(forKey: $0) }
    }
    
    /// 清除所有数据
    func clearAll() {
        if let bundleID = Bundle.main.bundleIdentifier {
            removePersistentDomain(forName: bundleID)
        }
    }
    
    // MARK: - 检查
    
    /// 检查键是否存在
    /// - Parameter key: 键
    /// - Returns: 是否存在
    func hasValue(forKey key: String) -> Bool {
        return object(forKey: key) != nil
    }
}

// MARK: - UserDefaults 键管理
struct UserDefaultsKeys {
    // 在这里定义所有的UserDefaults键，避免硬编码
    // 示例：
    // static let userId = "userId"
    // static let userName = "userName"
    // static let isFirstLaunch = "isFirstLaunch"
}

