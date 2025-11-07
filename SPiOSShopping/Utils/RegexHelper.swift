//
//  RegexHelper.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation

// MARK: - 正则表达式工具类
struct RegexHelper {
    
    // MARK: - 常用正则表达式
    
    /// 邮箱
    static let email = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
    
    /// 手机号（中国大陆）
    static let phone = "^1[3-9]\\d{9}$"
    
    /// 身份证号（中国大陆）
    static let idCard = "^[1-9]\\d{5}(18|19|20)\\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\\d|3[01])\\d{3}[0-9Xx]$"
    
    /// 密码（6-20位字母数字组合）
    static let password = "^[A-Za-z0-9]{6,20}$"
    
    /// 强密码（至少8位，包含大小写字母和数字）
    static let strongPassword = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    
    /// URL
    static let url = "^(https?://)?([\\da-z.-]+)\\.([a-z.]{2,6})([/\\w .-]*)*/?$"
    
    /// IP地址
    static let ipAddress = "^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
    
    /// 中文
    static let chinese = "^[\\u4e00-\\u9fa5]+$"
    
    /// 数字
    static let number = "^[0-9]+$"
    
    /// 字母
    static let letter = "^[A-Za-z]+$"
    
    /// 字母和数字
    static let alphanumeric = "^[A-Za-z0-9]+$"
    
    /// 银行卡号
    static let bankCard = "^[0-9]{16,19}$"
    
    /// 邮政编码（中国大陆）
    static let postalCode = "^[1-9]\\d{5}$"
    
    // MARK: - 验证方法
    
    /// 验证字符串是否匹配正则表达式
    /// - Parameters:
    ///   - string: 要验证的字符串
    ///   - pattern: 正则表达式
    /// - Returns: 是否匹配
    static func match(_ string: String, pattern: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return predicate.evaluate(with: string)
    }
    
    /// 查找所有匹配的字符串
    /// - Parameters:
    ///   - string: 源字符串
    ///   - pattern: 正则表达式
    /// - Returns: 匹配的字符串数组
    static func findAll(_ string: String, pattern: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return []
        }
        let matches = regex.matches(in: string, options: [], range: NSRange(location: 0, length: string.count))
        return matches.map { match in
            let range = Range(match.range, in: string)!
            return String(string[range])
        }
    }
    
    /// 替换匹配的字符串
    /// - Parameters:
    ///   - string: 源字符串
    ///   - pattern: 正则表达式
    ///   - replacement: 替换字符串
    /// - Returns: 替换后的字符串
    static func replace(_ string: String, pattern: String, replacement: String) -> String {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return string
        }
        let range = NSRange(location: 0, length: string.count)
        return regex.stringByReplacingMatches(in: string, options: [], range: range, withTemplate: replacement)
    }
    
    /// 提取第一个匹配的字符串
    /// - Parameters:
    ///   - string: 源字符串
    ///   - pattern: 正则表达式
    /// - Returns: 匹配的字符串
    static func firstMatch(_ string: String, pattern: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return nil
        }
        let range = NSRange(location: 0, length: string.count)
        if let match = regex.firstMatch(in: string, options: [], range: range) {
            let matchRange = Range(match.range, in: string)!
            return String(string[matchRange])
        }
        return nil
    }
}

// MARK: - String 正则扩展
extension String {
    
    /// 是否匹配正则表达式
    /// - Parameter pattern: 正则表达式
    /// - Returns: 是否匹配
    func matches(_ pattern: String) -> Bool {
        return RegexHelper.match(self, pattern: pattern)
    }
    
    /// 查找所有匹配
    /// - Parameter pattern: 正则表达式
    /// - Returns: 匹配的字符串数组
    func findAllMatches(_ pattern: String) -> [String] {
        return RegexHelper.findAll(self, pattern: pattern)
    }
    
    /// 替换匹配
    /// - Parameters:
    ///   - pattern: 正则表达式
    ///   - replacement: 替换字符串
    /// - Returns: 替换后的字符串
    func replaceMatches(_ pattern: String, with replacement: String) -> String {
        return RegexHelper.replace(self, pattern: pattern, replacement: replacement)
    }
    
    /// 提取第一个匹配
    /// - Parameter pattern: 正则表达式
    /// - Returns: 匹配的字符串
    func firstMatch(_ pattern: String) -> String? {
        return RegexHelper.firstMatch(self, pattern: pattern)
    }
}

