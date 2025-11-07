# 快速开始指南

## 🚀 快速使用

### 1. 基本扩展使用

```swift
import UIKit

// UIView扩展
view.setCornerRadius(10)
view.setShadow(color: .black, opacity: 0.1, radius: 4)

// UIColor扩展
let color = UIColor(hex: "#FF0000")

// String扩展
"test@example.com".isValidEmail  // true
"13800138000".isValidPhone       // true

// Date扩展
Date().toString(format: "yyyy-MM-dd")
Date().relativeTime  // "刚刚"、"5分钟前"等
```

### 2. 网络请求

```swift
import RxSwift

let disposeBag = DisposeBag()

// 基本请求
MCNetworkManager.shared.request(MCApiService.banners)
    .subscribe(onNext: { (response: MCResponse<[BannerModel]>) in
        if response.isSuccess, let banners = response.data {
            // 处理数据
        }
    })
    .disposed(by: disposeBag)

// 带加载提示
MCNetworkManager.shared.requestWithCache(MCApiService.categories)
    .showLoading(message: "加载中...", inView: view)
    .subscribe(onNext: { categories in
        // 处理数据
    })
    .disposed(by: disposeBag)
```

### 3. 图片加载

```swift
// 加载网络图片
imageView.setImage(urlString: "https://example.com/image.jpg")

// 加载圆形图片
avatarView.setRoundImage(urlString: "https://example.com/avatar.jpg")
```

### 4. 下拉刷新

```swift
// 添加下拉刷新
tableView.addHeaderRefresh {
    loadData()
}

// 添加上拉加载
tableView.addFooterRefresh {
    loadMore()
}

// 结束刷新
tableView.endRefreshing()
```

### 5. Toast提示

```swift
// 普通Toast
view.showToast(message: "提示信息")

// 成功Toast
view.showSuccessToast(message: "操作成功！")

// 错误Toast
view.showErrorToast(message: "操作失败！")
```

### 6. 权限请求

```swift
// 请求相机权限
PermissionHelper.requestCameraPermission { granted in
    if granted {
        // 使用相机
    }
}
```

### 7. 加密解密

```swift
// MD5
let md5 = "Hello World".md5

// SHA256
let sha256 = "Hello World".sha256

// Base64
let encoded = "Hello World".base64Encoded
```

### 8. 分享功能

```swift
// 分享文本
viewController.shareText("要分享的文本")

// 分享图片
viewController.shareImage(image)
```

## 📖 更多示例

运行项目后，可以在主界面查看所有工具类的详细示例和演示。

## 🔗 相关文档

- [完整文档](./README.md)
- [网络请求文档](./MCHttpManager/README.md) (待补充)

