//
//  RealmExampleViewController.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit
import RealmSwift

class RealmExampleViewController: BaseExampleViewController {
    
    // MARK: - 示例模型
    
    class User: Object {
        @Persisted var id: Int = 0
        @Persisted var name: String = ""
        @Persisted var email: String = ""
        @Persisted var age: Int = 0
        @Persisted var createdAt: Date = Date()
        
        override static func primaryKey() -> String? {
            return "id"
        }
    }
    
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "写入对象", description: "MCRealmManager.shared.write()") {
                self.demoWrite()
            },
            ExampleItem(title: "查询所有", description: "MCRealmManager.shared.objects()") {
                self.demoQueryAll()
            },
            ExampleItem(title: "条件查询", description: "MCRealmManager.shared.objects(where:)") {
                self.demoQueryWithCondition()
            },
            ExampleItem(title: "更新对象", description: "user.save(update: .modified)") {
                self.demoUpdate()
            },
            ExampleItem(title: "删除对象", description: "MCRealmManager.shared.delete()") {
                self.demoDelete()
            },
            ExampleItem(title: "数据库信息", description: "MCRealmManager.shared.getDatabaseSize()") {
                self.demoDatabaseInfo()
            }
        ]
        
        addExampleSection(title: "Realm 数据库示例", examples: examples)
    }
    
    // MARK: - 示例方法
    
    private func demoWrite() {
        let user = User()
        user.id = Int.random(in: 1000...9999)
        user.name = "测试用户\(user.id)"
        user.email = "user\(user.id)@example.com"
        user.age = Int.random(in: 18...60)
        user.createdAt = Date()
        
        MCRealmManager.shared.write(user)
        showResult("已写入用户:\nID: \(user.id)\n姓名: \(user.name)\n邮箱: \(user.email)")
    }
    
    private func demoQueryAll() {
        if let users = MCRealmManager.shared.objects(User.self) {
            let count = users.count
            let userList = users.prefix(5).map { "\($0.name) (ID: \($0.id))" }.joined(separator: "\n")
            showResult("用户总数: \(count)\n\n前5个用户:\n\(userList.isEmpty ? "暂无数据" : userList)")
        } else {
            showResult("查询失败")
        }
    }
    
    private func demoQueryWithCondition() {
        let predicate = NSPredicate(format: "age > %d", 30)
        if let users = MCRealmManager.shared.objects(User.self, where: predicate) {
            let count = users.count
            let userList = users.prefix(5).map { "\($0.name) (年龄: \($0.age))" }.joined(separator: "\n")
            showResult("年龄>30的用户数: \(count)\n\n前5个用户:\n\(userList.isEmpty ? "暂无数据" : userList)")
        } else {
            showResult("查询失败")
        }
    }
    
    private func demoUpdate() {
        if let users = MCRealmManager.shared.objects(User.self), let firstUser = users.first {
            MCRealmManager.shared.write {
                realm in
                firstUser.name = "已更新: \(firstUser.name)"
                firstUser.age += 1
            }
            showResult("已更新用户:\nID: \(firstUser.id)\n新姓名: \(firstUser.name)\n新年龄: \(firstUser.age)")
        } else {
            showResult("没有可更新的数据，请先写入数据")
        }
    }
    
    private func demoDelete() {
        if let users = MCRealmManager.shared.objects(User.self), let firstUser = users.first {
            MCRealmManager.shared.delete(firstUser)
            showResult("已删除用户:\nID: \(firstUser.id)\n姓名: \(firstUser.name)")
        } else {
            showResult("没有可删除的数据")
        }
    }
    
    private func demoDatabaseInfo() {
        let size = MCRealmManager.shared.getDatabaseSizeString()
        if let users = MCRealmManager.shared.objects(User.self) {
            showResult("数据库大小: \(size)\n用户总数: \(users.count)")
        } else {
            showResult("数据库大小: \(size)")
        }
    }
    
    private func showResult(_ text: String) {
        showAlert(message: text)
    }
}

