//
//  Array+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation

// MARK: - Array 常用扩展
extension Array {
    
    // MARK: - 安全访问
    
    /// 安全获取元素（不会越界）
    /// - Parameter index: 索引
    /// - Returns: 元素（如果索引有效）
    func safe(at index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    /// 安全设置元素
    /// - Parameters:
    ///   - index: 索引
    ///   - element: 元素
    /// - Returns: 是否设置成功
    @discardableResult
    mutating func safeSet(_ element: Element, at index: Int) -> Bool {
        guard indices.contains(index) else { return false }
        self[index] = element
        return true
    }
    
    // MARK: - 去重
    
    /// 去重（保持顺序）
    /// - Returns: 去重后的数组
    func unique() -> [Element] where Element: Hashable {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
    
    /// 去重（根据某个属性）
    /// - Parameter keyPath: 属性路径
    /// - Returns: 去重后的数组
    func unique<T: Hashable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        var seen = Set<T>()
        return filter { seen.insert($0[keyPath: keyPath]).inserted }
    }
    
    // MARK: - 分组
    
    /// 根据某个属性分组
    /// - Parameter keyPath: 属性路径
    /// - Returns: 分组后的字典
    func grouped<T: Hashable>(by keyPath: KeyPath<Element, T>) -> [T: [Element]] {
        return Dictionary(grouping: self, by: { $0[keyPath: keyPath] })
    }
    
    // MARK: - 分页
    
    /// 分页
    /// - Parameter pageSize: 每页大小
    /// - Returns: 分页后的数组
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
    
    // MARK: - 随机
    
    /// 随机元素
    /// - Returns: 随机元素
    func randomElement() -> Element? {
        return isEmpty ? nil : self[Int.random(in: 0..<count)]
    }
    
    /// 随机打乱数组
    /// - Returns: 打乱后的数组
    func shuffled() -> [Element] {
        var array = self
        for i in stride(from: array.count - 1, through: 1, by: -1) {
            let j = Int.random(in: 0...i)
            array.swapAt(i, j)
        }
        return array
    }
}

// MARK: - Array where Element: Equatable
extension Array where Element: Equatable {
    
    /// 移除指定元素
    /// - Parameter element: 要移除的元素
    /// - Returns: 移除后的数组
    func removing(_ element: Element) -> [Element] {
        return filter { $0 != element }
    }
    
    /// 移除多个元素
    /// - Parameter elements: 要移除的元素数组
    /// - Returns: 移除后的数组
    func removing(_ elements: [Element]) -> [Element] {
        return filter { !elements.contains($0) }
    }
    
    /// 是否包含所有指定元素
    /// - Parameter elements: 元素数组
    /// - Returns: 是否包含
    func contains(all elements: [Element]) -> Bool {
        return elements.allSatisfy { contains($0) }
    }
    
    /// 是否包含任意指定元素
    /// - Parameter elements: 元素数组
    /// - Returns: 是否包含
    func contains(any elements: [Element]) -> Bool {
        return elements.contains { contains($0) }
    }
}

