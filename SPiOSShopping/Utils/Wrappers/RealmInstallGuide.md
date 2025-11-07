# Realm 数据库安装指南

## 📦 使用 SPM 安装 Realm

### 方法一：通过 Xcode 界面添加

1. 打开 Xcode 项目
2. 选择项目文件（SPiOSShopping.xcodeproj）
3. 选择 Target（SPiOSShopping）
4. 点击 **"Package Dependencies"** 标签
5. 点击 **"+"** 按钮添加包
6. 在搜索框中输入：`https://github.com/realm/realm-swift`
7. 选择版本（建议选择最新稳定版本）
8. 点击 **"Add Package"**
9. 在 **"Add to Target"** 中选择 **SPiOSShopping**
10. 点击 **"Add Package"** 完成

### 方法二：通过 Package.resolved 文件

如果项目已经有 Package.resolved 文件，可以手动添加：

```json
{
  "pins" : [
    {
      "identity" : "realm",
      "kind" : "remoteSourceControl",
      "location" : "https://github.com/realm/realm-swift",
      "state" : {
        "revision" : "最新版本",
        "version" : "版本号"
      }
    }
  ]
}
```

## 🔧 使用 Realm 封装

安装完成后，可以直接使用 `MCRealmManager` 进行数据库操作。

### 基本使用

```swift
import RealmSwift

// 定义模型
class User: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var email: String = ""
}

// 写入数据
let user = User()
user.id = 1
user.name = "张三"
user.email = "zhangsan@example.com"
MCRealmManager.shared.write(user)

// 查询数据
if let users = MCRealmManager.shared.objects(User.self) {
    print("用户数量: \(users.count)")
}

// 更新数据
MCRealmManager.shared.write {
    realm in
    user.name = "新名称"
}

// 删除数据
MCRealmManager.shared.delete(user)
```

## 📝 注意事项

1. **模型定义**：所有 Realm 模型必须继承自 `Object`
2. **主键**：使用 `@Persisted(primaryKey: true)` 定义主键
3. **线程安全**：Realm 实例不能跨线程共享，每个线程需要创建自己的实例
4. **迁移**：当模型结构改变时，需要更新 `schemaVersion` 并实现迁移逻辑

## 🔗 相关资源

- [Realm 官方文档](https://www.mongodb.com/docs/realm/sdk/swift/)
- [Realm GitHub](https://github.com/realm/realm-swift)

