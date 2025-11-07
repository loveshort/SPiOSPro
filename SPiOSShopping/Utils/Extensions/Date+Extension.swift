//
//  Date+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation

// MARK: - Date 常用扩展
extension Date {
    
    // MARK: - 格式化
    
    /// 格式化日期
    /// - Parameter format: 格式字符串（如：yyyy-MM-dd HH:mm:ss）
    /// - Returns: 格式化后的字符串
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "zh_CN")
        return formatter.string(from: self)
    }
    
    /// 转换为时间戳（秒）
    var timestamp: TimeInterval {
        return timeIntervalSince1970
    }
    
    /// 转换为时间戳（毫秒）
    var timestampMilliseconds: Int64 {
        return Int64(timeIntervalSince1970 * 1000)
    }
    
    // MARK: - 创建日期
    
    /// 通过时间戳创建日期
    /// - Parameter timestamp: 时间戳（秒）
    /// - Returns: 日期对象
    static func fromTimestamp(_ timestamp: TimeInterval) -> Date {
        return Date(timeIntervalSince1970: timestamp)
    }
    
    /// 通过时间戳（毫秒）创建日期
    /// - Parameter timestamp: 时间戳（毫秒）
    /// - Returns: 日期对象
    static func fromTimestampMilliseconds(_ timestamp: Int64) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(timestamp) / 1000)
    }
    
    /// 通过字符串创建日期
    /// - Parameters:
    ///   - string: 日期字符串
    ///   - format: 格式字符串
    /// - Returns: 日期对象
    static func fromString(_ string: String, format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "zh_CN")
        return formatter.date(from: string)
    }
    
    // MARK: - 日期计算
    
    /// 增加年
    /// - Parameter years: 年数
    /// - Returns: 新日期
    func addingYears(_ years: Int) -> Date {
        return Calendar.current.date(byAdding: .year, value: years, to: self) ?? self
    }
    
    /// 增加月
    /// - Parameter months: 月数
    /// - Returns: 新日期
    func addingMonths(_ months: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: months, to: self) ?? self
    }
    
    /// 增加天
    /// - Parameter days: 天数
    /// - Returns: 新日期
    func addingDays(_ days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }
    
    /// 增加小时
    /// - Parameter hours: 小时数
    /// - Returns: 新日期
    func addingHours(_ hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self) ?? self
    }
    
    /// 增加分钟
    /// - Parameter minutes: 分钟数
    /// - Returns: 新日期
    func addingMinutes(_ minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self) ?? self
    }
    
    // MARK: - 日期比较
    
    /// 是否为今天
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    /// 是否为昨天
    var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    /// 是否为明天
    var isTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    
    /// 是否为本周
    var isThisWeek: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }
    
    /// 是否为今年
    var isThisYear: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year)
    }
    
    /// 计算两个日期的天数差
    /// - Parameter date: 另一个日期
    /// - Returns: 天数差
    func daysBetween(_ date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self, to: date)
        return abs(components.day ?? 0)
    }
    
    // MARK: - 日期组件
    
    /// 年
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    /// 月
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    /// 日
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    /// 小时
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    /// 分钟
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    /// 秒
    var second: Int {
        return Calendar.current.component(.second, from: self)
    }
    
    /// 星期几（1-7，1为周日）
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    /// 星期几（中文）
    var weekdayString: String {
        let weekdays = ["", "周日", "周一", "周二", "周三", "周四", "周五", "周六"]
        return weekdays[weekday]
    }
    
    // MARK: - 相对时间
    
    /// 相对时间描述（刚刚、几分钟前等）
    var relativeTime: String {
        let now = Date()
        let interval = now.timeIntervalSince(self)
        
        if interval < 60 {
            return "刚刚"
        } else if interval < 3600 {
            let minutes = Int(interval / 60)
            return "\(minutes)分钟前"
        } else if interval < 86400 {
            let hours = Int(interval / 3600)
            return "\(hours)小时前"
        } else if isYesterday {
            return "昨天"
        } else if interval < 604800 {
            let days = Int(interval / 86400)
            return "\(days)天前"
        } else if isThisYear {
            return toString(format: "MM-dd")
        } else {
            return toString(format: "yyyy-MM-dd")
        }
    }
}

