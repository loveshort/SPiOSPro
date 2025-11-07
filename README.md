# SPiOSPro 工具类库

这是一个 iOS 开发常用工具类库，提供了丰富的扩展方法和工具类，帮助开发者提高开发效率。

## 📚 目录

- [扩展类 (Extensions)](#扩展类-extensions)
- [工具类 (Helpers)](#工具类-helpers)
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

## 📱 使用示例

项目包含完整的示例应用，展示了所有工具类的使用方法。运行项目后，可以在主界面查看各个工具类的示例。

## 📦 安装说明

1. 将 `Utils` 文件夹添加到项目中
2. 确保所有文件都已添加到 Target
3. 直接使用即可，无需额外配置

## 📄 许可证

MIT License

## 👨‍💻 作者

顾明次

## 📝 更新日志

### v1.0.0
- 初始版本
- 包含所有基础工具类和扩展

