//
//  PrintHelper.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation

// MARK: - 打印工具类
struct PrintHelper {
    
    // MARK: - 日志级别
    
    enum LogLevel: String {
        case debug = "🔵 DEBUG"
        case info = "ℹ️ INFO"
        case warning = "⚠️ WARNING"
        case error = "❌ ERROR"
        case success = "✅ SUCCESS"
    }
    
    // MARK: - 日志开关
    
    /// 是否启用日志（默认：Debug模式启用）
    static var isEnabled: Bool = {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }()
    
    // MARK: - 日志方法
    
    /// 打印日志
    /// - Parameters:
    ///   - message: 消息
    ///   - level: 日志级别
    ///   - file: 文件名
    ///   - function: 函数名
    ///   - line: 行号
    static func log(_ message: Any,
                   level: LogLevel = .debug,
                   file: String = #file,
                   function: String = #function,
                   line: Int = #line) {
        guard isEnabled else { return }
        
        let fileName = (file as NSString).lastPathComponent
        let logMessage = """
        \(level.rawValue) [\(fileName):\(line)] \(function)
        \(message)
        """
        print(logMessage)
    }
    
    /// 调试日志
    static func debug(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .debug, file: file, function: function, line: line)
    }
    
    /// 信息日志
    static func info(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .info, file: file, function: function, line: line)
    }
    
    /// 警告日志
    static func warning(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .warning, file: file, function: function, line: line)
    }
    
    /// 错误日志
    static func error(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .error, file: file, function: function, line: line)
    }
    
    /// 成功日志
    static func success(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
        log(message, level: .success, file: file, function: function, line: line)
    }
    
    // MARK: - 打印对象
    
    /// 打印对象（格式化）
    /// - Parameter object: 对象
    static func printObject(_ object: Any) {
        guard isEnabled else { return }
        print("📦 Object:")
        dump(object)
    }
    
    /// 打印字典（格式化）
    /// - Parameter dictionary: 字典
    static func printDictionary(_ dictionary: [String: Any]) {
        guard isEnabled else { return }
        if let jsonString = JSONHelper.encodeDictionary(dictionary) {
            print("📋 Dictionary:\n\(jsonString)")
        } else {
            print("📋 Dictionary: \(dictionary)")
        }
    }
}

// MARK: - 全局打印函数
func printLog(_ message: Any, level: PrintHelper.LogLevel = .debug) {
    PrintHelper.log(message, level: level)
}

