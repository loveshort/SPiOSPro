//
//  RealmHelper.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation
import RealmSwift

// MARK: - Realm 辅助工具类
struct RealmHelper {
    
    // MARK: - 数据库配置
    
    /// 配置默认数据库
    /// - Parameters:
    ///   - schemaVersion: 数据库版本
    ///   - migrationBlock: 迁移闭包
    static func configureDefault(schemaVersion: UInt64 = 1, migrationBlock: MigrationBlock? = nil) {
        var config = Realm.Configuration()
        config.schemaVersion = schemaVersion
        
        if let migrationBlock = migrationBlock {
            config.migrationBlock = migrationBlock
        }
        
        Realm.Configuration.defaultConfiguration = config
    }
    
    /// 配置自定义数据库
    /// - Parameters:
    ///   - fileName: 数据库文件名
    ///   - schemaVersion: 数据库版本
    ///   - migrationBlock: 迁移闭包
    /// - Returns: Realm配置
    static func configureCustom(fileName: String, schemaVersion: UInt64 = 1, migrationBlock: MigrationBlock? = nil) -> Realm.Configuration {
        var config = Realm.Configuration()
        
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        config.fileURL = documentsPath.appendingPathComponent("\(fileName).realm")
        config.schemaVersion = schemaVersion
        
        if let migrationBlock = migrationBlock {
            config.migrationBlock = migrationBlock
        }
        
        return config
    }
    
    // MARK: - 数据库文件操作
    
    /// 获取数据库文件路径
    /// - Returns: 文件路径
    static func getDatabasePath() -> String? {
        guard let realm = try? Realm() else { return nil }
        return realm.configuration.fileURL?.path
    }
    
    /// 复制数据库文件
    /// - Parameters:
    ///   - toPath: 目标路径
    /// - Returns: 是否成功
    static func copyDatabase(toPath: String) -> Bool {
        guard let sourcePath = getDatabasePath(),
              FileManager.default.fileExists(atPath: sourcePath) else {
            return false
        }
        
        do {
            if FileManager.default.fileExists(atPath: toPath) {
                try FileManager.default.removeItem(atPath: toPath)
            }
            try FileManager.default.copyItem(atPath: sourcePath, toPath: toPath)
            return true
        } catch {
            PrintHelper.error("复制数据库失败: \(error)")
            return false
        }
    }
    
    /// 删除数据库文件
    /// - Returns: 是否成功
    static func deleteDatabase() -> Bool {
        guard let fileURL = try? Realm().configuration.fileURL else { return false }
        
        let fileManager = FileManager.default
        let filePath = fileURL.path
        
        // 删除主文件
        var success = true
        if fileManager.fileExists(atPath: filePath) {
            do {
                try fileManager.removeItem(atPath: filePath)
            } catch {
                PrintHelper.error("删除数据库文件失败: \(error)")
                success = false
            }
        }
        
        // 删除相关文件
        let relatedFiles = [
            "\(filePath).lock",
            "\(filePath).note",
            "\(filePath).management"
        ]
        
        for relatedFile in relatedFiles {
            if fileManager.fileExists(atPath: relatedFile) {
                do {
                    try fileManager.removeItem(atPath: relatedFile)
                } catch {
                    PrintHelper.error("删除相关文件失败: \(error)")
                }
            }
        }
        
        return success
    }
    
    // MARK: - 数据库信息
    
    /// 获取数据库文件大小
    /// - Returns: 文件大小（字节）
    static func getDatabaseSize() -> Int64? {
        guard let filePath = getDatabasePath(),
              FileManager.default.fileExists(atPath: filePath) else {
            return nil
        }
        
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: filePath)
            return attributes[.size] as? Int64
        } catch {
            PrintHelper.error("获取数据库大小失败: \(error)")
            return nil
        }
    }
    
    /// 获取数据库文件大小（格式化字符串）
    /// - Returns: 格式化后的文件大小字符串
    static func getDatabaseSizeString() -> String {
        guard let size = getDatabaseSize() else {
            return "未知"
        }
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useKB, .useMB, .useGB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: size)
    }
    
    // MARK: - 验证
    
    /// 验证数据库文件是否有效
    /// - Returns: 是否有效
    static func isValidDatabase() -> Bool {
        do {
            _ = try Realm()
            return true
        } catch {
            PrintHelper.error("数据库无效: \(error)")
            return false
        }
    }
}

// MARK: - Results 扩展（排序、分页等）
extension Results {
    
    /// 排序
    /// - Parameter keyPath: 排序字段
    /// - Parameter ascending: 是否升序
    /// - Returns: 排序后的结果
    func sorted(by keyPath: String, ascending: Bool = true) -> Results<Element> {
        return sorted(byKeyPath: keyPath, ascending: ascending)
    }
    
    /// 分页获取
    /// - Parameters:
    ///   - page: 页码（从1开始）
    ///   - pageSize: 每页数量
    /// - Returns: 分页后的数组
    func paginated(page: Int, pageSize: Int) -> [Element] {
        let startIndex = (page - 1) * pageSize
        let endIndex = min(startIndex + pageSize, count)
        guard startIndex < count else { return [] }
        return Array(self[startIndex..<endIndex])
    }
    
    /// 转换为数组
    /// - Returns: 数组
    func toArray() -> [Element] {
        return Array(self)
    }
}

