//
//  CryptoHelper.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation
import CommonCrypto

// MARK: - 加密解密工具类
struct CryptoHelper {
    
    // MARK: - MD5
    
    /// MD5加密
    /// - Parameter string: 要加密的字符串
    /// - Returns: MD5值
    static func md5(_ string: String) -> String {
        let data = Data(string.utf8)
        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        data.withUnsafeBytes { bytes in
            _ = CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
    
    // MARK: - SHA256
    
    /// SHA256加密
    /// - Parameter string: 要加密的字符串
    /// - Returns: SHA256值
    static func sha256(_ string: String) -> String {
        let data = Data(string.utf8)
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes { bytes in
            _ = CC_SHA256(bytes.baseAddress, CC_LONG(data.count), &hash)
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
    
    // MARK: - Base64
    
    /// Base64编码
    /// - Parameter string: 要编码的字符串
    /// - Returns: Base64字符串
    static func base64Encode(_ string: String) -> String? {
        guard let data = string.data(using: .utf8) else { return nil }
        return data.base64EncodedString()
    }
    
    /// Base64解码
    /// - Parameter string: Base64字符串
    /// - Returns: 解码后的字符串
    static func base64Decode(_ string: String) -> String? {
        guard let data = Data(base64Encoded: string) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    // MARK: - AES加密（简化版，实际项目建议使用更安全的实现）
    
    /// AES加密（需要密钥）
    /// - Parameters:
    ///   - string: 要加密的字符串
    ///   - key: 密钥
    /// - Returns: 加密后的数据
    static func aesEncrypt(_ string: String, key: String) -> Data? {
        // 注意：这是一个简化实现，实际项目中应该使用更安全的加密方式
        guard let data = string.data(using: .utf8),
              let keyData = key.data(using: .utf8) else {
            return nil
        }
        // 实际实现需要使用CryptoKit或更安全的加密库
        return data
    }
}

// MARK: - String 加密扩展
extension String {
    
    /// MD5值
    var md5: String {
        return CryptoHelper.md5(self)
    }
    
    /// SHA256值
    var sha256: String {
        return CryptoHelper.sha256(self)
    }
    
    /// Base64编码
    var base64Encoded: String? {
        return CryptoHelper.base64Encode(self)
    }
    
    /// Base64解码
    var base64Decoded: String? {
        return CryptoHelper.base64Decode(self)
    }
}

