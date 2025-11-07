//
//  RealmModels.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation
import RealmSwift

// MARK: - Realm 数据模型示例

/// 用户模型
class MCUser: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var email: String = ""
    @Persisted var phone: String = ""
    @Persisted var avatar: String = ""
    @Persisted var age: Int = 0
    @Persisted var createdAt: Date = Date()
    @Persisted var updatedAt: Date = Date()
    
    convenience init(id: Int, name: String, email: String, phone: String = "", avatar: String = "", age: Int = 0) {
        self.init()
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.avatar = avatar
        self.age = age
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}

/// 商品模型
class MCProduct: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var price: Double = 0.0
    @Persisted var imageUrl: String = ""
    @Persisted var description: String = ""
    @Persisted var categoryId: Int = 0
    @Persisted var stock: Int = 0
    @Persisted var createdAt: Date = Date()
}

/// 订单模型
class MCOrder: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var userId: Int = 0
    @Persisted var totalAmount: Double = 0.0
    @Persisted var status: Int = 0  // 0:待支付 1:已支付 2:已发货 3:已完成 4:已取消
    @Persisted var address: String = ""
    @Persisted var createdAt: Date = Date()
    @Persisted var updatedAt: Date = Date()
}

/// 购物车模型
class MCCartItem: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var userId: Int = 0
    @Persisted var productId: Int = 0
    @Persisted var quantity: Int = 1
    @Persisted var createdAt: Date = Date()
}

