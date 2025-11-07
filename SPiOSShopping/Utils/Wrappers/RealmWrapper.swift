//
//  RealmWrapper.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation
import RealmSwift

// MARK: - Realm 数据库封装
class MCRealmManager {
    
    /// 单例
    static let shared = MCRealmManager()
    
    /// Realm实例
    private var realm: Realm?
    
    private init() {
        setupRealm()
    }
    
    // MARK: - 初始化
    
    /// 配置Realm
    private func setupRealm() {
        do {
            // 配置Realm
            var config = Realm.Configuration()
            
            // 设置数据库文件路径（可选，默认在Documents目录）
            let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            config.fileURL = documentsPath.appendingPathComponent("default.realm")
            
            // 设置数据库版本（用于迁移）
            config.schemaVersion = 1
            
            // 迁移配置（如果需要）
            config.migrationBlock = { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    // 执行迁移逻辑
                }
            }
            
            // 创建Realm实例
            realm = try Realm(configuration: config)
            
            PrintHelper.info("Realm数据库初始化成功")
        } catch {
            PrintHelper.error("Realm数据库初始化失败: \(error)")
        }
    }
    
    // MARK: - 获取Realm实例
    
    /// 获取Realm实例
    /// - Returns: Realm实例
    func getRealm() throws -> Realm {
        guard let realm = realm else {
            throw NSError(domain: "MCRealmManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Realm未初始化"])
        }
        return realm
    }
    
    // MARK: - 写入操作
    
    /// 写入对象
    /// - Parameters:
    ///   - object: 要写入的对象
    ///   - update: 是否更新（如果已存在）
    func write<T: Object>(_ object: T, update: Realm.UpdatePolicy = .modified) {
        do {
            let realm = try getRealm()
            try realm.write {
                realm.add(object, update: update)
            }
        } catch {
            PrintHelper.error("写入对象失败: \(error)")
        }
    }
    
    /// 写入多个对象
    /// - Parameters:
    ///   - objects: 要写入的对象数组
    ///   - update: 是否更新（如果已存在）
    func write<T: Object>(_ objects: [T], update: Realm.UpdatePolicy = .modified) {
        do {
            let realm = try getRealm()
            try realm.write {
                realm.add(objects, update: update)
            }
        } catch {
            PrintHelper.error("写入对象失败: \(error)")
        }
    }
    
    /// 执行写入操作
    /// - Parameter block: 写入操作闭包
    func write(_ block: (Realm) throws -> Void) {
        do {
            let realm = try getRealm()
            try realm.write {
                try block(realm)
            }
        } catch {
            PrintHelper.error("写入操作失败: \(error)")
        }
    }
    
    // MARK: - 查询操作
    
    /// 查询所有对象
    /// - Parameter type: 对象类型
    /// - Returns: 结果集
    func objects<T: Object>(_ type: T.Type) -> Results<T>? {
        do {
            let realm = try getRealm()
            return realm.objects(type)
        } catch {
            PrintHelper.error("查询对象失败: \(error)")
            return nil
        }
    }
    
    /// 根据主键查询
    /// - Parameters:
    ///   - type: 对象类型
    ///   - key: 主键值
    /// - Returns: 对象
    func object<T: Object, KeyType>(ofType type: T.Type, forPrimaryKey key: KeyType) -> T? {
        do {
            let realm = try getRealm()
            return realm.object(ofType: type, forPrimaryKey: key)
        } catch {
            PrintHelper.error("查询对象失败: \(error)")
            return nil
        }
    }
    
    /// 根据条件查询
    /// - Parameters:
    ///   - type: 对象类型
    ///   - predicate: 查询条件（NSPredicate格式）
    /// - Returns: 结果集
    func objects<T: Object>(_ type: T.Type, where predicate: NSPredicate) -> Results<T>? {
        do {
            let realm = try getRealm()
            return realm.objects(type).filter(predicate)
        } catch {
            PrintHelper.error("查询对象失败: \(error)")
            return nil
        }
    }
    
    /// 根据条件查询（字符串格式）
    /// - Parameters:
    ///   - type: 对象类型
    ///   - predicateFormat: 查询条件格式字符串
    ///   - args: 参数数组
    /// - Returns: 结果集
    func objects<T: Object>(_ type: T.Type, where predicateFormat: String, args: [Any] = []) -> Results<T>? {
        do {
            let realm = try getRealm()
            let predicate = NSPredicate(format: predicateFormat, argumentArray: args)
            return realm.objects(type).filter(predicate)
        } catch {
            PrintHelper.error("查询对象失败: \(error)")
            return nil
        }
    }
    
    // MARK: - 删除操作
    
    /// 删除对象
    /// - Parameter object: 要删除的对象
    func delete<T: Object>(_ object: T) {
        do {
            let realm = try getRealm()
            try realm.write {
                realm.delete(object)
            }
        } catch {
            PrintHelper.error("删除对象失败: \(error)")
        }
    }
    
    /// 删除多个对象
    /// - Parameter objects: 要删除的对象数组
    func delete<T: Object>(_ objects: [T]) {
        do {
            let realm = try getRealm()
            try realm.write {
                realm.delete(objects)
            }
        } catch {
            PrintHelper.error("删除对象失败: \(error)")
        }
    }
    
    /// 删除所有指定类型的对象
    /// - Parameter type: 对象类型
    func deleteAll<T: Object>(_ type: T.Type) {
        do {
            let realm = try getRealm()
            if let objects = realm.objects(type) as? Results<T> {
                try realm.write {
                    realm.delete(objects)
                }
            }
        } catch {
            PrintHelper.error("删除对象失败: \(error)")
        }
    }
    
    /// 清空数据库
    func deleteAll() {
        do {
            let realm = try getRealm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            PrintHelper.error("清空数据库失败: \(error)")
        }
    }
    
    // MARK: - 其他操作
    
    /// 获取数据库文件大小
    /// - Returns: 文件大小（字节）
    func getDatabaseSize() -> Int64? {
        guard let realm = realm,
              let fileURL = realm.configuration.fileURL else {
            return nil
        }
        
        let filePath = fileURL.path
        guard FileManager.default.fileExists(atPath: filePath) else {
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
    func getDatabaseSizeString() -> String {
        guard let size = getDatabaseSize() else {
            return "未知"
        }
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useKB, .useMB, .useGB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: size)
    }
}

// MARK: - Realm 便捷扩展
extension Object {
    
    /// 保存到数据库
    /// - Parameter update: 是否更新
    func save(update: Realm.UpdatePolicy = .modified) {
        MCRealmManager.shared.write(self, update: update)
    }
    
    /// 从数据库删除
    func delete() {
        MCRealmManager.shared.delete(self)
    }
}

// MARK: - 查询结果扩展
extension Results {
    
    /// 转换为数组
    /// - Returns: 数组
    func toArray() -> [Element] {
        return Array(self)
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
}

