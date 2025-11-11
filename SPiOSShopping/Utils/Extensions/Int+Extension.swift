//
//  Int+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation

// MARK: - Int 常用扩展
extension Int {
    
    // MARK: - 格式化
    
    /// 格式化数字（添加千分位）
    /// - Returns: 格式化后的字符串
    var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
    /// 转换为字符串（带单位：万、亿）
    /// - Returns: 格式化后的字符串
    var formattedWithUnit: String {
        if self >= 100000000 {
            let yi = Double(self) / 100000000.0
            return String(format: "%.2f亿", yi)
        } else if self >= 10000 {
            let wan = Double(self) / 10000.0
            return String(format: "%.2f万", wan)
        }
        return "\(self)"
    }
    
    // MARK: - 范围检查
    
    /// 限制在指定范围内
    /// - Parameters:
    ///   - min: 最小值
    ///   - max: 最大值
    /// - Returns: 限制后的值
    func clamped(min: Int, max: Int) -> Int {
        return Swift.max(min, Swift.min(max, self))
    }
    
    /// 限制在指定范围内（可变版本）
    /// - Parameters:
    ///   - min: 最小值
    ///   - max: 最大值
    mutating func clamp(min: Int, max: Int) {
        self = clamped(min: min, max: max)
    }
    
    // MARK: - 随机数
    
    /// 生成指定范围内的随机数
    /// - Parameters:
    ///   - min: 最小值
    ///   - max: 最大值
    /// - Returns: 随机数
    static func random(in range: ClosedRange<Int>) -> Int {
        return Int.random(in: range)
    }
    
    // MARK: - 时间转换
    
    /// 转换为时间字符串（秒 -> 时:分:秒）
    /// - Returns: 时间字符串
    var toTimeString: String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let seconds = self % 60
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    /// 转换为时长描述（如：1小时30分钟）
    /// - Returns: 时长描述
    var toDurationString: String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let seconds = self % 60
        
        var components: [String] = []
        if hours > 0 {
            components.append("\(hours)小时")
        }
        if minutes > 0 {
            components.append("\(minutes)分钟")
        }
        if seconds > 0 && hours == 0 {
            components.append("\(seconds)秒")
        }
        
        return components.isEmpty ? "0秒" : components.joined()
    }
}

// MARK: - Double 常用扩展
extension Double {
    
    /// 格式化数字（保留指定位小数）
    /// - Parameter decimalPlaces: 小数位数
    /// - Returns: 格式化后的字符串
    func formatted(decimalPlaces: Int = 2) -> String {
        return String(format: "%.\(decimalPlaces)f", self)
    }
    
    /// 限制在指定范围内
    /// - Parameters:
    ///   - min: 最小值
    ///   - max: 最大值
    /// - Returns: 限制后的值
    func clamped(min: Double, max: Double) -> Double {
        return Swift.max(min, Swift.min(max, self))
    }
    
    /// 转换为百分比字符串
    /// - Parameter decimalPlaces: 小数位数
    /// - Returns: 百分比字符串
    func toPercentage(decimalPlaces: Int = 2) -> String {
        return String(format: "%.\(decimalPlaces)f%%", self * 100)
    }
    
    /// 转换为文件大小字符串
    /// - Returns: 文件大小字符串
    var toFileSizeString: String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useKB, .useMB, .useGB, .useTB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: Int64(self))
    }
}

// MARK: - CGFloat 常用扩展
extension CGFloat {
    
    /// 限制在指定范围内
    /// - Parameters:
    ///   - min: 最小值
    ///   - max: 最大值
    /// - Returns: 限制后的值
    func clamped(min: CGFloat, max: CGFloat) -> CGFloat {
        return Swift.max(min, Swift.min(max, self))
    }
}

