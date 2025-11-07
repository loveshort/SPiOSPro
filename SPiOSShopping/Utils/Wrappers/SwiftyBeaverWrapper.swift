//
//  SwiftyBeaverWrapper.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation
import SwiftyBeaver

// MARK: - SwiftyBeaver 日志封装
class MCLogger {
    
    /// 单例
    static let shared = MCLogger()
    
    /// 日志实例
    private let log = SwiftyBeaver.self
    
    private init() {
        setupLogger()
    }
    
    // MARK: - 初始化配置
    
    private func setupLogger() {
        // 控制台输出
        let console = ConsoleDestination()
        console.format = "$DHH:mm:ss$d $L $M"
        console.levelColor.verbose = "⚪️ "
        console.levelColor.debug = "🔵 "
        console.levelColor.info = "ℹ️ "
        console.levelColor.warning = "⚠️ "
        console.levelColor.error = "❌ "
        log.addDestination(console)
        
        #if DEBUG
        // Debug模式下设置详细日志
        console.level = .verbose
        #else
        // Release模式下只记录警告和错误
        console.level = .warning
        #endif
    }
    
    // MARK: - 日志方法
    
    /// 详细日志
    /// - Parameter message: 消息
    func verbose(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
        log.verbose(message, file: file, function: function, line: line)
    }
    
    /// 调试日志
    /// - Parameter message: 消息
    func debug(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
        log.debug(message, file: file, function: function, line: line)
    }
    
    /// 信息日志
    /// - Parameter message: 消息
    func info(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
        log.info(message, file: file, function: function, line: line)
    }
    
    /// 警告日志
    /// - Parameter message: 消息
    func warning(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
        log.warning(message, file: file, function: function, line: line)
    }
    
    /// 错误日志
    /// - Parameter message: 消息
    func error(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
        log.error(message, file: file, function: function, line: line)
    }
    
    // MARK: - 文件日志（可选）
    
    /// 添加文件日志
    /// - Parameter filePath: 文件路径（可选，默认在Documents目录）
    func addFileDestination(filePath: String? = nil) {
        let file = FileDestination()
        
        if let filePath = filePath {
            file.logFileURL = URL(fileURLWithPath: filePath)
        } else {
            let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            file.logFileURL = documentsPath.appendingPathComponent("app.log")
        }
        
        file.format = "$Dyyyy-MM-dd HH:mm:ss$d $L $M"
        log.addDestination(file)
    }
}

// MARK: - 全局日志函数
func MCLog(_ message: Any, level: SwiftyBeaver.Level = .debug) {
    switch level {
    case .verbose:
        MCLogger.shared.verbose(message)
    case .debug:
        MCLogger.shared.debug(message)
    case .info:
        MCLogger.shared.info(message)
    case .warning:
        MCLogger.shared.warning(message)
    case .error:
        MCLogger.shared.error(message)
    }
}

