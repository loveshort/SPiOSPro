//
//  UIColor+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

// MARK: - UIColor 常用扩展
extension UIColor {
    
    // MARK: - 十六进制颜色
    
    /// 通过十六进制字符串创建颜色
    /// - Parameters:
    ///   - hex: 十六进制字符串（支持 #FFFFFF 或 FFFFFF 格式）
    ///   - alpha: 透明度（0.0-1.0）
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// 通过RGB值创建颜色
    /// - Parameters:
    ///   - r: 红色值（0-255）
    ///   - g: 绿色值（0-255）
    ///   - b: 蓝色值（0-255）
    ///   - alpha: 透明度（0.0-1.0）
    convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(r) / 255.0,
            green: CGFloat(g) / 255.0,
            blue: CGFloat(b) / 255.0,
            alpha: alpha
        )
    }
    
    /// 转换为十六进制字符串
    /// - Returns: 十六进制字符串（不包含#）
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0
        
        return String(format: "#%06x", rgb)
    }
    
    // MARK: - 随机颜色
    
    /// 随机颜色
    /// - Parameter alpha: 透明度
    /// - Returns: 随机颜色
    static func random(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: alpha
        )
    }
    
    // MARK: - 常用颜色
    
    /// 主色调（可根据项目需求修改）
    static var mainColor: UIColor {
        return UIColor(hex: "#007AFF")
    }
    
    /// 背景色
    static var backgroundColor: UIColor {
        return UIColor(hex: "#F5F5F5")
    }
    
    /// 分割线颜色
    static var separatorColor: UIColor {
        return UIColor(hex: "#E5E5E5")
    }
    
    /// 文字主色
    static var textPrimaryColor: UIColor {
        return UIColor(hex: "#333333")
    }
    
    /// 文字次要色
    static var textSecondaryColor: UIColor {
        return UIColor(hex: "#666666")
    }
    
    /// 文字辅助色
    static var textTertiaryColor: UIColor {
        return UIColor(hex: "#999999")
    }
}

