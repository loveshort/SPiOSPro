//
//  RealmUsageExample.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation
import RealmSwift

// MARK: - Realm 使用示例
class RealmUsageExample {
    
    // MARK: - 模型定义示例
    
    /// 用户模型
    class User: Object {
        @Persisted(primaryKey: true) var id: Int = 0
        @Persisted var name: String = ""
        @Persisted var email: String = ""
        @Persisted var age: Int = 0
        @Persisted var createdAt: Date = Date()
    }
    
    // MARK: - 基本操作示例
    
    /// 写入数据示例
    func exampleWrite() {
        // 创建对象
        let user = User()
        user.id = 1
        user.name = "张三"
        user.email = "zhangsan@example.com"
        user.age = 25
        
        // 写入数据库
        MCRealmManager.shared.write(user)
        
        // 或使用便捷方法
        user.save()
    }
    
    /// 查询数据示例
    func exampleQuery() {
        // 查询所有
        if let users = MCRealmManager.shared.objects(User.self) {
            print("用户数量: \(users.count)")
            for user in users {
                print("用户: \(user.name)")
            }
        }
        
        // 主键查询
        if let user = MCRealmManager.shared.object(ofType: User.self, forPrimaryKey: 1) {
            print("找到用户: \(user.name)")
        }
        
        // 条件查询
        let predicate = NSPredicate(format: "age > %d", 18)
        if let users = MCRealmManager.shared.objects(User.self, where: predicate) {
            print("成年用户数量: \(users.count)")
        }
        
        // 字符串格式条件查询
        if let users = MCRealmManager.shared.objects(User.self, where: "age > %d", args: [18]) {
            print("成年用户数量: \(users.count)")
        }
    }
    
    /// 更新数据示例
    func exampleUpdate() {
        if let user = MCRealmManager.shared.object(ofType: User.self, forPrimaryKey: 1) {
            // 方式1：使用write方法
            MCRealmManager.shared.write {
                realm in
                user.name = "新名称"
                user.age = 26
            }
            
            // 方式2：直接修改后保存
            MCRealmManager.shared.write(user, update: .modified)
        }
    }
    
    /// 删除数据示例
    func exampleDelete() {
        if let user = MCRealmManager.shared.object(ofType: User.self, forPrimaryKey: 1) {
            // 方式1：使用delete方法
            MCRealmManager.shared.delete(user)
            
            // 方式2：使用便捷方法
            user.delete()
        }
        
        // 删除所有用户
        MCRealmManager.shared.deleteAll(User.self)
    }
    
    /// 分页查询示例
    func examplePagination() {
        if let users = MCRealmManager.shared.objects(User.self) {
            // 分页获取（第1页，每页10条）
            let page1 = users.paginated(page: 1, pageSize: 10)
            print("第1页用户: \(page1.count)个")
            
            // 转换为数组
            let userArray = users.toArray()
            print("所有用户: \(userArray.count)个")
        }
    }
    
    /// 数据库信息示例
    func exampleDatabaseInfo() {
        // 获取数据库大小
        if let size = MCRealmManager.shared.getDatabaseSize() {
            print("数据库大小: \(size) 字节")
        }
        
        // 获取格式化的大小
        let sizeString = MCRealmManager.shared.getDatabaseSizeString()
        print("数据库大小: \(sizeString)")
    }
}

