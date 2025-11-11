# SPiOSPro 工具类库

这是一个 iOS 开发常用工具类库，提供了丰富的扩展方法和工具类，帮助开发者提高开发效率。

## 📚 目录

- [扩展类 (Extensions)](#扩展类-extensions)
- [工具类 (Helpers)](#工具类-helpers)
- [网络请求封装](#网络请求封装)
- [第三方库封装](#第三方库封装)
- [使用示例](#使用示例)
- [安装说明](#安装说明)

## 🔧 扩展类 (Extensions)

### UIView+Extension

UIView 常用扩展，提供圆角、边框、阴影、渐变色、动画等功能。

**主要功能：**
- ✅ 圆角设置（普通圆角、指定角圆角、圆形）
- ✅ 边框设置
- ✅ 阴影设置
- ✅ 渐变色
- ✅ 动画效果（淡入、淡出、缩放）
- ✅ 截图功能
- ✅ 查找父视图控制器
- ✅ 添加点击手势

**使用示例：**
```swift
// 设置圆角
view.setCornerRadius(10)

// 设置圆形
avatarView.setRound()

// 设置阴影
cardView.setShadow(color: .black, opacity: 0.1, radius: 4)

// 添加渐变色
view.addGradientLayer(colors: [.red, .blue])

// 淡入动画
view.fadeIn(duration: 0.3)
```

### UIColor+Extension

颜色处理扩展，支持十六进制颜色、RGB颜色等。

**主要功能：**
- ✅ 十六进制颜色创建
- ✅ RGB颜色创建
- ✅ 颜色转十六进制字符串
- ✅ 随机颜色生成
- ✅ 常用颜色常量

**使用示例：**
```swift
// 十六进制颜色
let color = UIColor(hex: "#FF0000")
let colorWithAlpha = UIColor(hex: "#FF0000", alpha: 0.5)

// RGB颜色
let rgbColor = UIColor(r: 255, g: 0, b: 0)

// 随机颜色
let randomColor = UIColor.random()

// 常用颜色
let mainColor = UIColor.mainColor
let backgroundColor = UIColor.backgroundColor
```

### String+Extension

字符串处理扩展，提供验证、格式化、尺寸计算等功能。

**主要功能：**
- ✅ 验证（邮箱、手机号、身份证号）
- ✅ 格式化（去除空格、手机号格式化、银行卡格式化）
- ✅ 文本尺寸计算
- ✅ 字符串截取
- ✅ URL编码/解码
- ✅ 正则匹配
- ✅ 拼音转换

**使用示例：**
```swift
// 验证
"test@example.com".isValidEmail  // true
"13800138000".isValidPhone       // true

// 格式化
"13800138000".formattedPhone     // "138****8000"
"6222021234567890123".formattedBankCard  // "6222 0212 3456 7890 123"

// 尺寸计算
let size = "Hello World".size(with: UIFont.systemFont(ofSize: 16), maxWidth: 200)

// 拼音转换
"你好".toPinyinWithoutTone  // "nihao"
"你好".firstLetter           // "N"
```

### Date+Extension

日期处理扩展，提供格式化、计算、比较等功能。

**主要功能：**
- ✅ 日期格式化
- ✅ 时间戳转换
- ✅ 日期计算（增加年、月、日、小时、分钟）
- ✅ 日期比较（今天、昨天、本周、今年等）
- ✅ 日期组件获取
- ✅ 相对时间描述

**使用示例：**
```swift
// 格式化
Date().toString(format: "yyyy-MM-dd HH:mm:ss")

// 时间戳
let timestamp = Date().timestamp
let date = Date.fromTimestamp(timestamp)

// 日期计算
let tomorrow = Date().addingDays(1)
let nextWeek = Date().addingDays(7)

// 日期比较
Date().isToday      // true
Date().isThisYear   // true

// 相对时间
Date().relativeTime  // "刚刚"、"5分钟前"、"昨天"等
```

### UIViewController+Extension

视图控制器扩展，提供提示框、Toast、导航栏设置等功能。

**主要功能：**
- ✅ 提示框（Alert、Confirm、Input）
- ✅ Toast提示
- ✅ 导航栏设置
- ✅ 返回按钮设置
- ✅ 键盘处理
- ✅ 安全区域获取

**使用示例：**
```swift
// 提示框
showAlert(message: "操作成功")
showConfirm(message: "确定删除吗？") {
    // 确认操作
}

// Toast
showToast(message: "加载成功")

// 导航栏设置
setNavigationTitle("首页")
setNavigationTitleColor(.white)

// 键盘处理
addTapToDismissKeyboard()
```

### UIImage+Extension

图片处理扩展，提供缩放、裁剪、压缩等功能。

**主要功能：**
- ✅ 通过颜色创建图片
- ✅ 图片缩放
- ✅ 图片裁剪（矩形、圆形）
- ✅ 图片压缩
- ✅ 图片旋转
- ✅ 图片效果（圆角、边框、灰度）

**使用示例：**
```swift
// 通过颜色创建图片
let image = UIImage.fromColor(.red, size: CGSize(width: 100, height: 100))

// 缩放
let scaledImage = image?.resize(to: CGSize(width: 200, height: 200))

// 裁剪为圆形
let circularImage = image?.circular()

// 压缩
let compressedData = image?.compress(maxSize: 100 * 1024)  // 100KB

// 添加圆角
let roundedImage = image?.rounded(radius: 10)
```

### Array+Extension

数组扩展，提供安全访问、去重、分组等功能。

**主要功能：**
- ✅ 安全访问（不会越界）
- ✅ 去重（保持顺序）
- ✅ 分组
- ✅ 分页
- ✅ 随机元素

**使用示例：**
```swift
// 安全访问
let item = array.safe(at: 10)  // 不会崩溃

// 去重
let uniqueArray = array.unique()

// 分组
let grouped = users.grouped(by: \.city)

// 分页
let pages = array.chunked(into: 20)

// 随机元素
let random = array.randomElement()
```

### Dictionary+Extension

字典扩展，提供安全访问、合并、类型转换等功能。

**主要功能：**
- ✅ 安全访问
- ✅ 合并字典
- ✅ 类型转换（String、Int、Double、Bool等）
- ✅ JSON转换

**使用示例：**
```swift
// 安全访问
let value = dict.safeValue(forKey: "key")

// 合并
let merged = dict1.merging(dict2)

// 类型转换
let string = dict.string(forKey: "name")
let int = dict.int(forKey: "age")
let bool = dict.bool(forKey: "isActive")
```

### Int+Extension / Double+Extension

数值扩展，提供格式化、范围限制等功能。

**主要功能：**
- ✅ 数字格式化（千分位）
- ✅ 单位转换（万、亿）
- ✅ 范围限制
- ✅ 时间转换

**使用示例：**
```swift
// 格式化
10000.formatted          // "10,000"
100000.formattedWithUnit // "10.00万"

// 范围限制
let clamped = 150.clamped(min: 0, max: 100)  // 100

// 时间转换
3661.toTimeString        // "01:01:01"
3661.toDurationString    // "1小时1分钟1秒"
```

## 🛠️ 工具类 (Helpers)

### DeviceInfo

设备信息工具类，获取屏幕、设备等信息。

**主要功能：**
- ✅ 屏幕信息（宽度、高度、缩放比例）
- ✅ 设备信息（型号、系统版本、是否模拟器）
- ✅ 安全区域信息
- ✅ 设备型号判断

**使用示例：**
```swift
// 屏幕信息
DeviceInfo.screenWidth
DeviceInfo.screenHeight
DeviceInfo.isLandscape

// 设备信息
DeviceInfo.deviceModel
DeviceInfo.systemVersion
DeviceInfo.isiPhone
DeviceInfo.isSimulator

// 安全区域
DeviceInfo.statusBarHeight
DeviceInfo.bottomSafeAreaHeight
DeviceInfo.isiPhoneXSeries
```

### AppInfo

应用信息工具类，获取应用版本、Bundle信息等。

**主要功能：**
- ✅ Bundle信息（应用名称、版本号、Bundle ID）
- ✅ 首次启动判断
- ✅ 启动次数统计
- ✅ 版本比较

**使用示例：**
```swift
// 应用信息
AppInfo.appName
AppInfo.appVersion
AppInfo.buildVersion
AppInfo.bundleId

// 首次启动
if AppInfo.isFirstLaunch {
    // 显示引导页
}

// 版本比较
AppInfo.isVersionGreaterThan("1.0.0")
```

### KeyboardManager

键盘管理工具类，监听键盘显示/隐藏。

**主要功能：**
- ✅ 键盘高度监听
- ✅ 自动调整视图位置
- ✅ 收起键盘

**使用示例：**
```swift
// 监听键盘
KeyboardManager.shared.onKeyboardHeightChanged = { height, duration in
    // 调整视图位置
}

// 调整视图
adjustViewForKeyboard(textField, offset: 20)

// 收起键盘
KeyboardManager.shared.dismissKeyboard()
```

### CountDownTimer

倒计时工具类，用于验证码倒计时等场景。

**主要功能：**
- ✅ 倒计时功能
- ✅ 暂停/继续
- ✅ 按钮倒计时扩展

**使用示例：**
```swift
// 基本使用
let timer = CountDownTimer(totalSeconds: 60)
timer.onTick = { remaining in
    print("剩余: \(remaining)秒")
}
timer.onFinish = {
    print("倒计时结束")
}
timer.start()

// 按钮倒计时
button.startCountDown(seconds: 60, format: "重新获取(%ds)")
```

### JSONHelper

JSON处理工具类，提供编码解码功能。

**主要功能：**
- ✅ 对象编码为JSON
- ✅ JSON解码为对象
- ✅ JSON验证
- ✅ JSON格式化

**使用示例：**
```swift
// 编码
let jsonString = user.toJSONString()
let dict = user.toDictionary()

// 解码
let user = User.fromJSONString(jsonString)
let user = User.fromDictionary(dict)

// 验证
JSONHelper.isValidJSON(jsonString)
```

### RegexHelper

正则表达式工具类，提供常用正则和匹配功能。

**主要功能：**
- ✅ 常用正则表达式（邮箱、手机号、身份证等）
- ✅ 匹配验证
- ✅ 查找所有匹配
- ✅ 替换匹配

**使用示例：**
```swift
// 验证
RegexHelper.match("test@example.com", pattern: RegexHelper.email)

// 查找
"123-456-7890".findAllMatches("\\d+")

// 替换
"Hello World".replaceMatches("World", with: "Swift")
```

### ThreadHelper

线程工具类，提供主线程执行、延迟执行等功能。

**主要功能：**
- ✅ 主线程执行
- ✅ 延迟执行
- ✅ 后台线程执行
- ✅ 异步执行后回到主线程

**使用示例：**
```swift
// 主线程执行
ThreadHelper.main {
    // 更新UI
}

// 延迟执行
ThreadHelper.delay(2.0) {
    // 2秒后执行
}

// 后台执行
ThreadHelper.background {
    // 后台任务
}
```

### UserDefaults+Extension

用户偏好设置扩展，提供便捷的存储方法。

**主要功能：**
- ✅ Codable对象存储
- ✅ 基础类型存储
- ✅ 日期存储
- ✅ 数组存储

**使用示例：**
```swift
// 存储
UserDefaults.standard.setString("value", forKey: "key")
UserDefaults.standard.setInt(100, forKey: "count")
UserDefaults.standard.set(user, forKey: "user")

// 获取
let value = UserDefaults.standard.getString(forKey: "key")
let count = UserDefaults.standard.getInt(forKey: "count")
let user = UserDefaults.standard.get(User.self, forKey: "user")
```

### PrintHelper

打印工具类，提供分级日志功能。

**主要功能：**
- ✅ 分级日志（Debug、Info、Warning、Error、Success）
- ✅ 格式化打印
- ✅ 对象打印

**使用示例：**
```swift
PrintHelper.debug("调试信息")
PrintHelper.info("普通信息")
PrintHelper.warning("警告信息")
PrintHelper.error("错误信息")
PrintHelper.success("成功信息")
```

## 🌐 网络请求封装

### MCNetworkManager

网络请求管理器，提供统一的网络请求接口，支持缓存、错误处理等功能。

**主要功能：**
- ✅ 统一响应格式（MCResponse）
- ✅ 自动缓存管理
- ✅ 网络状态监听
- ✅ 错误统一处理
- ✅ 加载状态管理
- ✅ Token自动添加

**使用示例：**
```swift
// 基本请求（统一响应格式）
networkManager.request(MCApiService.login(username: "test", password: "123"))
    .subscribe(onNext: { (response: MCResponse<UserModel>) in
        if response.isSuccess, let user = response.data {
            // 处理成功
        }
    }, onError: { error in
        // 处理错误
    })

// 直接获取数据
networkManager.requestData(MCApiService.productList(page: 1, pageSize: 10))
    .subscribe(onNext: { (products: [ProductModel]) in
        // 处理数据
    })

// 分页请求
networkManager.requestPage(MCApiService.productList(page: 1, pageSize: 10))
    .subscribe(onNext: { (pageResponse: MCPageResponse<ProductModel>) in
        print("当前页: \(pageResponse.page)")
        print("总数: \(pageResponse.total)")
    })

// 带加载提示的请求
networkManager.requestWithCache(MCApiService.banners)
    .showLoading(message: "加载中...", inView: view)
    .subscribe(onNext: { banners in
        // 处理数据
    })
```

### MCResponse

统一响应模型，包含状态码、消息和数据。

**使用示例：**
```swift
struct MCResponse<T: Codable>: Codable {
    let code: Int
    let message: String
    let data: T?
    var isSuccess: Bool { return code == 200 || code == 0 }
}
```

### MCNetworkError

网络错误枚举，统一错误处理。

**错误类型：**
- `networkUnavailable` - 网络不可用
- `timeout` - 请求超时
- `serverError` - 服务器错误
- `decodeError` - 数据解析失败
- `businessError` - 业务错误

## 📦 第三方库封装

### KingfisherWrapper

图片加载封装，简化Kingfisher的使用。

**主要功能：**
- ✅ 一行代码加载网络图片
- ✅ 自动圆角处理
- ✅ 图片预加载
- ✅ 缓存管理

**使用示例：**
```swift
// 加载网络图片
imageView.setImage(urlString: "https://example.com/image.jpg")

// 加载带圆角的图片
imageView.setImage(urlString: "https://example.com/image.jpg", cornerRadius: 10)

// 加载圆形图片
imageView.setRoundImage(urlString: "https://example.com/image.jpg")

// 预加载图片
MCImageLoader.prefetchImages(["url1", "url2", "url3"])

// 清除缓存
MCImageLoader.clearMemoryCache()
MCImageLoader.clearDiskCache()
```

### MJRefreshWrapper

下拉刷新封装，简化MJRefresh的使用。

**主要功能：**
- ✅ 一行代码添加下拉刷新
- ✅ 一行代码添加上拉加载
- ✅ 自定义刷新文字
- ✅ 自动状态管理

**使用示例：**
```swift
// 添加下拉刷新
tableView.addHeaderRefresh {
    // 刷新数据
    loadData()
}

// 添加上拉加载
tableView.addFooterRefresh {
    // 加载更多
    loadMore()
}

// 结束刷新
tableView.endRefreshing()
tableView.endLoading()

// 没有更多数据
tableView.endLoadingWithNoMoreData()
```

### SnapKitWrapper

自动布局封装，简化SnapKit的使用。

**主要功能：**
- ✅ 快速填充父视图
- ✅ 快速居中
- ✅ 快速对齐
- ✅ 固定尺寸

**使用示例：**
```swift
// 填充父视图
subView.fillSuperview(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))

// 居中
subView.centerInSuperview(size: CGSize(width: 100, height: 100))

// 顶部对齐
subView.alignTop(top: 0, left: 0, right: 0, height: 44)

// 固定尺寸
subView.setSize(width: 100, height: 100)
```

### SwiftyJSONWrapper

JSON解析封装，简化SwiftyJSON的使用。

**主要功能：**
- ✅ 安全获取值（带默认值）
- ✅ JSON解析工具
- ✅ Codable转换

**使用示例：**
```swift
// 解析JSON
if let json = MCJSONHelper.parse(jsonString) {
    let name = json["name"].stringValue("默认名称")
    let age = json["age"].intValue(0)
    let isActive = json["isActive"].boolValue(false)
}

// JSON转字符串
let jsonString = MCJSONHelper.stringify(json)

// Codable转换
let user = json.toObject(User.self)
let json = user.toJSON()
```

### EmptyDataSetWrapper

空数据视图封装，简化EmptyDataSet的使用。

**主要功能：**
- ✅ 一行代码设置空数据视图
- ✅ 支持标题、描述、图片、按钮
- ✅ 自动实现协议

**使用示例：**
```swift
tableView.setEmptyDataSet(
    title: "暂无数据",
    description: "这里还没有任何内容",
    image: UIImage(systemName: "tray"),
    buttonTitle: "刷新",
    buttonAction: {
        // 刷新操作
        loadData()
    }
)
```

### RxSwiftWrapper

响应式编程封装，简化RxSwift的使用。

**主要功能：**
- ✅ 简化事件绑定
- ✅ 手势事件扩展
- ✅ 加载状态扩展
- ✅ 错误处理扩展

**使用示例：**
```swift
// 按钮点击
button.rx.tap
    .subscribe(onNext: {
        // 处理点击
    })
    .disposed(by: disposeBag)

// 视图点击手势
view.rx.tapGesture
    .subscribe(onNext: { _ in
        // 处理点击
    })
    .disposed(by: disposeBag)

// 带加载状态的请求
observable
    .showLoading(in: view, message: "加载中...")
    .subscribe(onNext: { data in
        // 处理数据
    })
```

### RouterWrapper

路由封装，简化JLSwiftRouter的使用。

**主要功能：**
- ✅ 路由注册
- ✅ Push跳转
- ✅ Present弹出
- ✅ 参数传递

**使用示例：**
```swift
// 注册路由
MCRouter.shared.register(path: "/user/detail") { params in
    let userId = params?["userId"] as? Int ?? 0
    return UserDetailViewController(userId: userId)
}

// Push跳转
MCRouter.shared.push(path: "/user/detail", params: ["userId": 123])

// 或使用扩展方法
viewController.push(path: "/user/detail", params: ["userId": 123])
```

### SwiftyBeaverWrapper

日志封装，简化SwiftyBeaver的使用。

**主要功能：**
- ✅ 分级日志（Debug、Info、Warning、Error）
- ✅ 自动配置
- ✅ 文件日志支持

**使用示例：**
```swift
// 使用封装类
MCLogger.shared.debug("调试信息")
MCLogger.shared.info("普通信息")
MCLogger.shared.warning("警告信息")
MCLogger.shared.error("错误信息")

// 或使用全局函数
MCLog("调试信息", level: .debug)
```

### ToastWrapper

Toast提示封装，简化Toast-Swift的使用（SPM库）。

**主要功能：**
- ✅ 一行代码显示Toast
- ✅ 成功/错误/警告Toast
- ✅ 自定义位置和样式
- ✅ 带图片的Toast

**使用示例：**
```swift
// 普通Toast
view.showToast(message: "提示信息")
viewController.showToast(message: "提示信息")

// 成功Toast
view.showSuccessToast(message: "操作成功！")

// 错误Toast
view.showErrorToast(message: "操作失败！")

// 警告Toast
view.showWarningToast(message: "请注意！")

// 带图片的Toast
view.showToastWithImage(message: "提示", image: UIImage(systemName: "checkmark"))

// 全局方法
MCToast.show(message: "提示信息")
MCToast.showSuccess(message: "成功")
MCToast.showError(message: "错误")
```

## 🔐 其他工具类

### PermissionHelper

权限管理工具类，简化系统权限请求。

**主要功能：**
- ✅ 相机权限
- ✅ 相册权限
- ✅ 定位权限
- ✅ 通知权限
- ✅ 麦克风权限
- ✅ 打开应用设置

**使用示例：**
```swift
// 检查相机权限
let status = PermissionHelper.checkCameraPermission()

// 请求相机权限
PermissionHelper.requestCameraPermission { granted in
    if granted {
        // 使用相机
    }
}

// 打开应用设置
PermissionHelper.openAppSettings()
```

### CryptoHelper

加密解密工具类，提供常用加密算法。

**主要功能：**
- ✅ MD5加密
- ✅ SHA256加密
- ✅ Base64编码/解码

**使用示例：**
```swift
// MD5
let md5 = "Hello World".md5

// SHA256
let sha256 = "Hello World".sha256

// Base64
let encoded = "Hello World".base64Encoded
let decoded = encoded?.base64Decoded
```

### ShareHelper

分享功能封装，简化系统分享。

**主要功能：**
- ✅ 分享文本
- ✅ 分享图片
- ✅ 分享URL
- ✅ 分享多个项目
- ✅ iPad支持

**使用示例：**
```swift
// 分享文本
viewController.shareText("要分享的文本")

// 分享图片
viewController.shareImage(image)

// 分享URL
viewController.shareURL(url)

// 或使用工具类
ShareHelper.shareText("文本", from: viewController)
```

### VersionHelper

版本管理工具类，提供版本比较功能。

**主要功能：**
- ✅ 版本号比较
- ✅ iOS版本检查
- ✅ 应用版本检查

**使用示例：**
```swift
// 版本比较
VersionHelper.compare("1.2.3", "1.2.0")  // 1 (大于)

// iOS版本检查
VersionHelper.isIOSVersionGreaterOrEqual("13.0")

// 应用版本检查
VersionHelper.isAppVersionGreaterOrEqual("1.0.0")
```

### Data+Extension

Data扩展，提供常用转换和操作。

**主要功能：**
- ✅ 字符串转换
- ✅ 十六进制转换
- ✅ Base64编码/解码
- ✅ JSON转换
- ✅ 文件操作

**使用示例：**
```swift
// 转换为字符串
let string = data.toString()

// 转换为十六进制
let hex = data.toHexString()

// 转换为JSON
let dict = data.toDictionary()

// 格式化大小
let size = data.formattedSize
```

### Bundle+Extension

Bundle扩展，提供应用信息获取。

**主要功能：**
- ✅ 应用信息获取
- ✅ 文件读取
- ✅ JSON文件读取

**使用示例：**
```swift
// 应用信息
Bundle.main.appName
Bundle.main.appVersion
Bundle.main.bundleId

// 读取文件
Bundle.main.readFile(name: "config", type: "json")
Bundle.main.readJSON(name: "config")
```

### RealmWrapper

Realm数据库封装，简化Realm的使用（SPM库）。

**主要功能：**
- ✅ 写入对象（单个/多个）
- ✅ 查询对象（所有/条件查询/主键查询）
- ✅ 更新对象
- ✅ 删除对象
- ✅ 数据库管理

**使用示例：**
```swift
// 写入对象
let user = MCUser(id: 1, name: "张三", email: "zhangsan@example.com")
MCRealmManager.shared.write(user)

// 查询所有
if let users = MCRealmManager.shared.objects(MCUser.self) {
    print("用户数量: \(users.count)")
}

// 条件查询（使用NSPredicate）
let predicate = NSPredicate(format: "age > %d", 18)
if let users = MCRealmManager.shared.objects(MCUser.self, where: predicate) {
    // 处理结果
}

// 条件查询（字符串格式）
if let users = MCRealmManager.shared.objects(MCUser.self, where: "age > %d", args: [18]) {
    // 处理结果
}

// 主键查询
if let user = MCRealmManager.shared.object(ofType: MCUser.self, forPrimaryKey: 1) {
    // 处理用户
}

// 更新对象
MCRealmManager.shared.write {
    realm in
    user.name = "新名称"
    user.age = 25
}

// 删除对象
MCRealmManager.shared.delete(user)

// 便捷方法
user.save()  // 保存
user.delete()  // 删除
```

**注意：** 需要在Xcode中添加Realm Swift Package依赖。

## 📱 使用示例

项目包含完整的示例应用，展示了所有工具类的使用方法。运行项目后，可以在主界面查看各个工具类的示例。

## 🚀 快速开始

### 基本使用

```swift
// UIView扩展
view.setCornerRadius(10)
view.setShadow(color: .black, opacity: 0.1, radius: 4)

// UIColor扩展
let color = UIColor(hex: "#FF0000")

// String扩展
"test@example.com".isValidEmail  // true

// 网络请求
MCNetworkManager.shared.request(MCApiService.banners)
    .subscribe(onNext: { response in
        // 处理数据
    })

// 图片加载
imageView.setImage(urlString: "https://example.com/image.jpg")

// Toast提示
view.showToast(message: "提示信息")
```

更多示例请查看 [QuickStart.md](./SPiOSShopping/Utils/QuickStart.md)

## 📦 安装说明

### 使用 CocoaPods

项目已配置 CocoaPods，依赖的第三方库包括：
- Moya (网络请求)
- RxSwift (响应式编程)
- Kingfisher (图片加载)
- MJRefresh (下拉刷新)
- SnapKit (自动布局)
- SwiftyJSON (JSON解析)
- EmptyDataSet-Swift (空数据视图)
- 等等...

### 使用 Swift Package Manager

项目包含以下 SPM 依赖：
- Toast-Swift (Toast提示)
- RealmSwift (Realm数据库)

**添加Realm依赖：**
1. 在Xcode中选择项目
2. 选择Target -> Package Dependencies
3. 点击 "+" 添加包
4. 输入URL: `https://github.com/realm/realm-swift`
5. 选择版本并添加

### 手动安装

1. 将 `Utils` 文件夹添加到项目中
2. 将 `MCHttpManager` 文件夹添加到项目中
3. 确保所有文件都已添加到 Target
4. 安装 CocoaPods 依赖：`pod install`
5. 直接使用即可

## 📄 许可证

MIT License

## 👨‍💻 作者

顾明次

## 📝 更新日志

### v1.3.0
- 新增Realm数据库封装（RealmWrapper）
- 新增Realm数据模型示例（MCUser、MCProduct等）
- 完善数据库操作封装（增删改查）
- 添加Realm安装指南

### v1.2.0
- 新增权限管理工具类（PermissionHelper）
- 新增加密解密工具类（CryptoHelper）
- 新增分享功能封装（ShareHelper）
- 新增版本管理工具类（VersionHelper）
- 新增Data扩展（字符串转换、十六进制、JSON等）
- 新增Bundle扩展（应用信息、文件读取等）
- 完善文档和示例

### v1.1.0
- 新增网络请求封装（MCNetworkManager、MCResponse、MCNetworkError）
- 新增第三方库封装（Kingfisher、MJRefresh、SnapKit、SwiftyJSON等）
- 新增SPM库封装（Toast-Swift）
- 新增加载状态管理（MCLoadingManager）
- 新增网络插件（MCNetworkPlugin、MCNetworkLoggerPlugin）
- 完善示例应用，添加所有工具类的演示

### v1.0.0
- 初始版本
- 包含所有基础工具类和扩展

