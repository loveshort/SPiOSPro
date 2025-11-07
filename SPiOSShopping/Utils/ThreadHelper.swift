//
//  ThreadHelper.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation

// MARK: - 线程工具类
struct ThreadHelper {
    
    // MARK: - 主线程执行
    
    /// 在主线程执行代码
    /// - Parameter block: 要执行的代码块
    static func main(_ block: @escaping () -> Void) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
    
    /// 在主线程同步执行代码
    /// - Parameter block: 要执行的代码块
    static func mainSync(_ block: @escaping () -> Void) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.sync {
                block()
            }
        }
    }
    
    // MARK: - 延迟执行
    
    /// 延迟执行
    /// - Parameters:
    ///   - delay: 延迟时间（秒）
    ///   - block: 要执行的代码块
    static func delay(_ delay: TimeInterval, block: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            block()
        }
    }
    
    /// 延迟执行（可取消）
    /// - Parameters:
    ///   - delay: 延迟时间（秒）
    ///   - block: 要执行的代码块
    /// - Returns: 可取消的任务
    @discardableResult
    static func delayCancellable(_ delay: TimeInterval, block: @escaping () -> Void) -> DispatchWorkItem {
        let workItem = DispatchWorkItem(block: block)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: workItem)
        return workItem
    }
    
    // MARK: - 后台线程执行
    
    /// 在后台线程执行代码
    /// - Parameter block: 要执行的代码块
    static func background(_ block: @escaping () -> Void) {
        DispatchQueue.global(qos: .default).async {
            block()
        }
    }
    
    /// 在后台线程执行代码（指定优先级）
    /// - Parameters:
    ///   - qos: 服务质量
    ///   - block: 要执行的代码块
    static func background(qos: DispatchQoS.QoSClass, block: @escaping () -> Void) {
        DispatchQueue.global(qos: qos).async {
            block()
        }
    }
    
    // MARK: - 异步执行后回到主线程
    
    /// 在后台执行代码，完成后回到主线程
    /// - Parameters:
    ///   - backgroundBlock: 后台执行的代码块
    ///   - mainBlock: 主线程执行的代码块
    static func async(_ backgroundBlock: @escaping () -> Void, main mainBlock: @escaping () -> Void) {
        DispatchQueue.global(qos: .default).async {
            backgroundBlock()
            DispatchQueue.main.async {
                mainBlock()
            }
        }
    }
}

// MARK: - DispatchQueue 扩展
extension DispatchQueue {
    
    /// 安全执行（如果已在当前队列则同步执行，否则异步执行）
    /// - Parameter block: 要执行的代码块
    func safeAsync(_ block: @escaping () -> Void) {
        if self === DispatchQueue.main && Thread.isMainThread {
            block()
        } else {
            async(execute: block)
        }
    }
}

