//
//  Data+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation

// MARK: - Data 常用扩展
extension Data {
    
    // MARK: - 转换
    
    /// 转换为字符串
    /// - Parameter encoding: 编码方式
    /// - Returns: 字符串
    func toString(encoding: String.Encoding = .utf8) -> String? {
        return String(data: self, encoding: encoding)
    }
    
    /// 转换为十六进制字符串
    /// - Returns: 十六进制字符串
    func toHexString() -> String {
        return map { String(format: "%02x", $0) }.joined()
    }
    
    /// 从十六进制字符串创建Data
    /// - Parameter hexString: 十六进制字符串
    /// - Returns: Data对象
    static func fromHexString(_ hexString: String) -> Data? {
        var data = Data()
        var index = hexString.startIndex
        
        while index < hexString.endIndex {
            let nextIndex = hexString.index(index, offsetBy: 2, limitedBy: hexString.endIndex) ?? hexString.endIndex
            let byteString = String(hexString[index..<nextIndex])
            if let byte = UInt8(byteString, radix: 16) {
                data.append(byte)
            }
            index = nextIndex
        }
        
        return data.isEmpty ? nil : data
    }
    
    // MARK: - Base64
    
    /// Base64编码
    /// - Returns: Base64字符串
    var base64String: String {
        return base64EncodedString()
    }
    
    /// 从Base64字符串创建Data
    /// - Parameter base64String: Base64字符串
    /// - Returns: Data对象
    static func fromBase64String(_ base64String: String) -> Data? {
        return Data(base64Encoded: base64String)
    }
    
    // MARK: - JSON
    
    /// 转换为JSON对象
    /// - Returns: JSON对象
    func toJSON() -> Any? {
        return try? JSONSerialization.jsonObject(with: self, options: [])
    }
    
    /// 转换为字典
    /// - Returns: 字典
    func toDictionary() -> [String: Any]? {
        return toJSON() as? [String: Any]
    }
    
    /// 转换为数组
    /// - Returns: 数组
    func toArray() -> [Any]? {
        return toJSON() as? [Any]
    }
    
    // MARK: - 文件操作
    
    /// 保存到文件
    /// - Parameter path: 文件路径
    /// - Returns: 是否保存成功
    @discardableResult
    func save(to path: String) -> Bool {
        let url = URL(fileURLWithPath: path)
        do {
            try write(to: url)
            return true
        } catch {
            PrintHelper.error("保存文件失败: \(error)")
            return false
        }
    }
    
    /// 从文件读取
    /// - Parameter path: 文件路径
    /// - Returns: Data对象
    static func fromFile(_ path: String) -> Data? {
        let url = URL(fileURLWithPath: path)
        return try? Data(contentsOf: url)
    }
    
    // MARK: - 大小格式化
    
    /// 格式化文件大小
    /// - Returns: 格式化后的字符串
    var formattedSize: String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useKB, .useMB, .useGB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: Int64(count))
    }
}

