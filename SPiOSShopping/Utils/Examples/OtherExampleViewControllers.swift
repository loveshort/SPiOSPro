//
//  OtherExampleViewControllers.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

// MARK: - UIColor 示例
class UIColorExampleViewController: BaseExampleViewController {
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "十六进制颜色", description: "UIColor(hex: \"#FF0000\")") {
                let color = UIColor(hex: "#FF0000")
                self.showColorDemo(color, title: "红色 #FF0000")
            },
            ExampleItem(title: "RGB颜色", description: "UIColor(r: 255, g: 0, b: 0)") {
                let color = UIColor(r: 255, g: 0, b: 0)
                self.showColorDemo(color, title: "RGB(255, 0, 0)")
            },
            ExampleItem(title: "随机颜色", description: "UIColor.random()") {
                let color = UIColor.random()
                self.showColorDemo(color, title: "随机颜色")
            }
        ]
        addExampleSection(title: "UIColor 扩展示例", examples: examples)
    }
    
    private func showColorDemo(_ color: UIColor, title: String) {
        let view = UIView()
        view.backgroundColor = color
        view.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        showDemoView(view, title: title)
    }
    
    private func showDemoView(_ view: UIView, title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        containerView.backgroundColor = .backgroundColor
        containerView.addSubview(view)
        view.center = containerView.center
        
        alert.view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 60),
            containerView.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 200),
            containerView.heightAnchor.constraint(equalToConstant: 200),
            alert.view.heightAnchor.constraint(equalToConstant: 300)
        ])
        alert.addAction(UIAlertAction(title: "确定", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UIImage 示例
class UIImageExampleViewController: BaseExampleViewController {
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "颜色创建图片", description: "UIImage.fromColor(.red)") {
                if let image = UIImage.fromColor(.red, size: CGSize(width: 100, height: 100)) {
                    self.showImageDemo(image, title: "红色图片")
                }
            },
            ExampleItem(title: "图片缩放", description: "image?.resize(to:size:)") {
                if let original = UIImage.fromColor(.blue, size: CGSize(width: 200, height: 200)),
                   let scaled = original.resize(to: CGSize(width: 100, height: 100)) {
                    self.showImageDemo(scaled, title: "缩放后图片")
                }
            }
        ]
        addExampleSection(title: "UIImage 扩展示例", examples: examples)
    }
    
    private func showImageDemo(_ image: UIImage, title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        imageView.contentMode = .scaleAspectFit
        
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        containerView.backgroundColor = .backgroundColor
        containerView.addSubview(imageView)
        imageView.center = containerView.center
        
        alert.view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 60),
            containerView.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 200),
            containerView.heightAnchor.constraint(equalToConstant: 200),
            alert.view.heightAnchor.constraint(equalToConstant: 300)
        ])
        alert.addAction(UIAlertAction(title: "确定", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Array 示例
class ArrayExampleViewController: BaseExampleViewController {
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "安全访问", description: "array.safe(at: 10)") {
                let array = [1, 2, 3, 4, 5]
                let item = array.safe(at: 10)
                self.showResult("数组: \(array)\n安全访问索引10: \(item?.description ?? "nil")")
            },
            ExampleItem(title: "去重", description: "array.unique()") {
                let array = [1, 2, 2, 3, 3, 3, 4]
                let unique = array.unique()
                self.showResult("原数组: \(array)\n去重后: \(unique)")
            },
            ExampleItem(title: "分页", description: "array.chunked(into: 3)") {
                let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
                let pages = array.chunked(into: 3)
                self.showResult("原数组: \(array)\n分页结果: \(pages)")
            }
        ]
        addExampleSection(title: "Array 扩展示例", examples: examples)
    }
    
    private func showResult(_ text: String) {
        showAlert(message: text)
    }
}

// MARK: - Dictionary 示例
class DictionaryExampleViewController: BaseExampleViewController {
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "类型转换", description: "dict.string(forKey:)") {
                let dict: [String: Any] = ["name": "张三", "age": 25, "isActive": true]
                let name = dict.string(forKey: "name")
                let age = dict.int(forKey: "age")
                let isActive = dict.bool(forKey: "isActive")
                self.showResult("字典: \(dict)\nname: \(name ?? "nil")\nage: \(age?.description ?? "nil")\nisActive: \(isActive?.description ?? "nil")")
            },
            ExampleItem(title: "合并字典", description: "dict1.merging(dict2)") {
                let dict1 = ["a": 1, "b": 2]
                let dict2 = ["b": 3, "c": 4]
                let merged = dict1.merging(dict2)
                self.showResult("字典1: \(dict1)\n字典2: \(dict2)\n合并后: \(merged)")
            }
        ]
        addExampleSection(title: "Dictionary 扩展示例", examples: examples)
    }
    
    private func showResult(_ text: String) {
        showAlert(message: text)
    }
}

// MARK: - Number 示例
class NumberExampleViewController: BaseExampleViewController {
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "数字格式化", description: "10000.formatted") {
                let num = 10000
                self.showResult("原数字: \(num)\n格式化: \(num.formatted)")
            },
            ExampleItem(title: "单位转换", description: "100000.formattedWithUnit") {
                let num = 100000
                self.showResult("原数字: \(num)\n转换后: \(num.formattedWithUnit)")
            },
            ExampleItem(title: "时间转换", description: "3661.toTimeString") {
                let seconds = 3661
                self.showResult("秒数: \(seconds)\n时间字符串: \(seconds.toTimeString)\n时长描述: \(seconds.toDurationString)")
            }
        ]
        addExampleSection(title: "Number 扩展示例", examples: examples)
    }
    
    private func showResult(_ text: String) {
        showAlert(message: text)
    }
}

// MARK: - 其他示例（简化版）
class UILabelExampleViewController: BaseExampleViewController {
    override func setupExamples() {
        showAlert(message: "UILabel 扩展示例\n\n使用便捷初始化方法创建标签")
    }
}

class UIButtonExampleViewController: BaseExampleViewController {
    override func setupExamples() {
        showAlert(message: "UIButton 扩展示例\n\n使用便捷初始化方法创建按钮")
    }
}

class UITextFieldExampleViewController: BaseExampleViewController {
    override func setupExamples() {
        showAlert(message: "UITextField 扩展示例\n\n设置占位符、左右视图等")
    }
}

class UITextViewExampleViewController: BaseExampleViewController {
    override func setupExamples() {
        showAlert(message: "UITextView 扩展示例\n\n设置占位符、输入限制等")
    }
}

class UIScrollViewExampleViewController: BaseExampleViewController {
    override func setupExamples() {
        showAlert(message: "UIScrollView 扩展示例\n\n滚动到指定位置")
    }
}

class UIApplicationExampleViewController: BaseExampleViewController {
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "应用信息", description: "UIApplication.shared.appVersion") {
                let info = """
                应用版本: \(UIApplication.shared.appVersion)
                构建版本: \(UIApplication.shared.buildVersion)
                Bundle ID: \(UIApplication.shared.bundleId)
                """
                self.showResult(info)
            }
        ]
        addExampleSection(title: "UIApplication 扩展示例", examples: examples)
    }
    
    private func showResult(_ text: String) {
        showAlert(message: text)
    }
}

class AppInfoExampleViewController: BaseExampleViewController {
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "应用信息", description: "AppInfo.appName") {
                let info = """
                应用名称: \(AppInfo.appName)
                应用版本: \(AppInfo.appVersion)
                构建版本: \(AppInfo.buildVersion)
                完整版本: \(AppInfo.fullVersion)
                Bundle ID: \(AppInfo.bundleId)
                """
                self.showResult(info)
            },
            ExampleItem(title: "启动信息", description: "AppInfo.isFirstLaunch") {
                let info = """
                是否首次启动: \(AppInfo.isFirstLaunch ? "是" : "否")
                启动次数: \(AppInfo.launchCount)
                """
                self.showResult(info)
            }
        ]
        addExampleSection(title: "AppInfo 示例", examples: examples)
    }
    
    private func showResult(_ text: String) {
        showAlert(message: text)
    }
}

class KeyboardManagerExampleViewController: BaseExampleViewController {
    override func setupExamples() {
        let textField = UITextField(placeholder: "点击输入测试键盘管理")
        textField.borderStyle = .roundedRect
        contentView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        showAlert(message: "键盘管理示例\n\n点击输入框测试键盘监听功能")
    }
}

class JSONHelperExampleViewController: BaseExampleViewController {
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "JSON编码", description: "object.toJSONString()") {
                let dict = ["name": "张三", "age": 25]
                if let json = JSONHelper.encodeDictionary(dict) {
                    self.showResult("字典: \(dict)\nJSON: \(json)")
                }
            },
            ExampleItem(title: "JSON验证", description: "JSONHelper.isValidJSON()") {
                let validJSON = "{\"name\":\"test\"}"
                let invalidJSON = "{name:test}"
                self.showResult("有效JSON: \(JSONHelper.isValidJSON(validJSON))\n无效JSON: \(JSONHelper.isValidJSON(invalidJSON))")
            }
        ]
        addExampleSection(title: "JSONHelper 示例", examples: examples)
    }
    
    private func showResult(_ text: String) {
        showAlert(message: text)
    }
}

class RegexHelperExampleViewController: BaseExampleViewController {
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "邮箱验证", description: "RegexHelper.match(email, pattern:)") {
                let email = "test@example.com"
                let result = RegexHelper.match(email, pattern: RegexHelper.email)
                self.showResult("邮箱: \(email)\n验证结果: \(result ? "✅ 有效" : "❌ 无效")")
            },
            ExampleItem(title: "手机号验证", description: "RegexHelper.match(phone, pattern:)") {
                let phone = "13800138000"
                let result = RegexHelper.match(phone, pattern: RegexHelper.phone)
                self.showResult("手机号: \(phone)\n验证结果: \(result ? "✅ 有效" : "❌ 无效")")
            }
        ]
        addExampleSection(title: "RegexHelper 示例", examples: examples)
    }
    
    private func showResult(_ text: String) {
        showAlert(message: text)
    }
}

class ThreadHelperExampleViewController: BaseExampleViewController {
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "主线程执行", description: "ThreadHelper.main {}") {
                ThreadHelper.main {
                    self.showToast(message: "在主线程执行")
                }
            },
            ExampleItem(title: "延迟执行", description: "ThreadHelper.delay(2.0) {}") {
                ThreadHelper.delay(1.0) {
                    self.showToast(message: "1秒后执行")
                }
                self.showToast(message: "已设置延迟1秒执行")
            }
        ]
        addExampleSection(title: "ThreadHelper 示例", examples: examples)
    }
}

class UserDefaultsExampleViewController: BaseExampleViewController {
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "存储字符串", description: "UserDefaults.setString()") {
                UserDefaults.standard.setString("测试值", forKey: "test_key")
                let value = UserDefaults.standard.getString(forKey: "test_key")
                self.showResult("存储的值: \(value ?? "nil")")
            },
            ExampleItem(title: "存储整数", description: "UserDefaults.setInt()") {
                UserDefaults.standard.setInt(100, forKey: "test_int")
                let value = UserDefaults.standard.getInt(forKey: "test_int")
                self.showResult("存储的值: \(value)")
            }
        ]
        addExampleSection(title: "UserDefaults 扩展示例", examples: examples)
    }
    
    private func showResult(_ text: String) {
        showAlert(message: text)
    }
}

class PrintHelperExampleViewController: BaseExampleViewController {
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "Debug日志", description: "PrintHelper.debug()") {
                PrintHelper.debug("这是调试信息")
                self.showToast(message: "请查看控制台输出")
            },
            ExampleItem(title: "Error日志", description: "PrintHelper.error()") {
                PrintHelper.error("这是错误信息")
                self.showToast(message: "请查看控制台输出")
            }
        ]
        addExampleSection(title: "PrintHelper 示例", examples: examples)
    }
}

