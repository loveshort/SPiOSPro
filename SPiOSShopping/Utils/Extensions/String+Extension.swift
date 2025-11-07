//
//  String+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation
import UIKit

// MARK: - String 常用扩展
extension String {
    
    // MARK: - 验证
    
    /// 验证是否为有效邮箱
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    /// 验证是否为有效手机号（中国大陆）
    var isValidPhone: Bool {
        let phoneRegex = "^1[3-9]\\d{9}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: self)
    }
    
    /// 验证是否为有效身份证号（中国大陆）
    var isValidIDCard: Bool {
        let idCardRegex = "^[1-9]\\d{5}(18|19|20)\\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\\d|3[01])\\d{3}[0-9Xx]$"
        let idCardPredicate = NSPredicate(format: "SELF MATCHES %@", idCardRegex)
        return idCardPredicate.evaluate(with: self)
    }
    
    /// 验证是否为空（去除空格后）
    var isEmptyAfterTrim: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    // MARK: - 格式化
    
    /// 去除首尾空格
    var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// 去除所有空格
    var removeAllSpaces: String {
        return replacingOccurrences(of: " ", with: "")
    }
    
    /// 手机号格式化（138****8888）
    var formattedPhone: String {
        guard isValidPhone, count == 11 else { return self }
        let startIndex = index(self.startIndex, offsetBy: 3)
        let endIndex = index(self.startIndex, offsetBy: 7)
        return replacingCharacters(in: startIndex..<endIndex, with: "****")
    }
    
    /// 银行卡号格式化（每4位加空格）
    var formattedBankCard: String {
        let trimmed = removeAllSpaces
        var formatted = ""
        for (index, char) in trimmed.enumerated() {
            if index > 0 && index % 4 == 0 {
                formatted += " "
            }
            formatted.append(char)
        }
        return formatted
    }
    
    // MARK: - 尺寸计算
    
    /// 计算文本尺寸
    /// - Parameters:
    ///   - font: 字体
    ///   - maxWidth: 最大宽度
    /// - Returns: 文本尺寸
    func size(with font: UIFont, maxWidth: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let size = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = (self as NSString).boundingRect(
            with: size,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attributes,
            context: nil
        )
        return CGSize(width: ceil(rect.width), height: ceil(rect.height))
    }
    
    /// 计算文本高度
    /// - Parameters:
    ///   - font: 字体
    ///   - width: 宽度
    /// - Returns: 文本高度
    func height(with font: UIFont, width: CGFloat) -> CGFloat {
        return size(with: font, maxWidth: width).height
    }
    
    /// 计算文本宽度
    /// - Parameter font: 字体
    /// - Returns: 文本宽度
    func width(with font: UIFont) -> CGFloat {
        return size(with: font).width
    }
    
    // MARK: - 字符串截取
    
    /// 安全截取字符串
    /// - Parameters:
    ///   - start: 起始位置
    ///   - length: 长度
    /// - Returns: 截取后的字符串
    func substring(from start: Int, length: Int) -> String {
        let startIndex = index(self.startIndex, offsetBy: max(0, start))
        let endIndex = index(startIndex, offsetBy: min(length, count - start))
        return String(self[startIndex..<endIndex])
    }
    
    /// 截取到指定位置
    /// - Parameter index: 位置
    /// - Returns: 截取后的字符串
    func substring(to index: Int) -> String {
        let endIndex = index(self.startIndex, offsetBy: min(index, count))
        return String(self[..<endIndex])
    }
    
    /// 从指定位置截取
    /// - Parameter index: 位置
    /// - Returns: 截取后的字符串
    func substring(from index: Int) -> String {
        let startIndex = index(self.startIndex, offsetBy: min(index, count))
        return String(self[startIndex...])
    }
    
    // MARK: - URL编码
    
    /// URL编码
    var urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    /// URL解码
    var urlDecoded: String? {
        return removingPercentEncoding
    }
    
    // MARK: - 正则匹配
    
    /// 正则匹配
    /// - Parameter pattern: 正则表达式
    /// - Returns: 匹配结果数组
    func matches(pattern: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return []
        }
        let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: count))
        return matches.map { match in
            let range = Range(match.range, in: self)!
            return String(self[range])
        }
    }
    
    // MARK: - 拼音
    
    /// 转换为拼音（带声调）
    var toPinyin: String {
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        return mutableString as String
    }
    
    /// 转换为拼音（不带声调）
    var toPinyinWithoutTone: String {
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        return mutableString as String
    }
    
    /// 获取首字母
    var firstLetter: String {
        let pinyin = toPinyinWithoutTone.uppercased()
        guard let firstChar = pinyin.first else { return "#" }
        return String(firstChar)
    }
}

