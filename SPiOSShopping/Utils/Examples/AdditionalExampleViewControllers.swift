//
//  AdditionalExampleViewControllers.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit
import AVFoundation
import Photos

// MARK: - 权限示例
class PermissionExampleViewController: BaseExampleViewController {
    
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "检查相机权限", description: "PermissionHelper.checkCameraPermission()") {
                let status = PermissionHelper.checkCameraPermission()
                let statusText = status == .authorized ? "已授权" : status == .denied ? "已拒绝" : "未确定"
                self.showResult("相机权限状态: \(statusText)")
            },
            ExampleItem(title: "请求相机权限", description: "PermissionHelper.requestCameraPermission()") {
                PermissionHelper.requestCameraPermission { granted in
                    self.showResult("相机权限: \(granted ? "已授权" : "已拒绝")")
                }
            },
            ExampleItem(title: "请求相册权限", description: "PermissionHelper.requestPhotoLibraryPermission()") {
                PermissionHelper.requestPhotoLibraryPermission { granted in
                    self.showResult("相册权限: \(granted ? "已授权" : "已拒绝")")
                }
            },
            ExampleItem(title: "打开应用设置", description: "PermissionHelper.openAppSettings()") {
                PermissionHelper.openAppSettings()
                self.showToast(message: "已打开应用设置")
            }
        ]
        
        addExampleSection(title: "权限管理示例", examples: examples)
    }
    
    private func showResult(_ text: String) {
        showAlert(message: text)
    }
}

// MARK: - 加密解密示例
class CryptoExampleViewController: BaseExampleViewController {
    
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "MD5加密", description: "string.md5") {
                let text = "Hello World"
                let md5 = text.md5
                self.showResult("原文: \(text)\nMD5: \(md5)")
            },
            ExampleItem(title: "SHA256加密", description: "string.sha256") {
                let text = "Hello World"
                let sha256 = text.sha256
                self.showResult("原文: \(text)\nSHA256: \(sha256)")
            },
            ExampleItem(title: "Base64编码", description: "string.base64Encoded") {
                let text = "Hello World"
                let encoded = text.base64Encoded ?? "编码失败"
                self.showResult("原文: \(text)\nBase64: \(encoded)")
            },
            ExampleItem(title: "Base64解码", description: "string.base64Decoded") {
                let encoded = "SGVsbG8gV29ybGQ="
                let decoded = encoded.base64Decoded ?? "解码失败"
                self.showResult("Base64: \(encoded)\n原文: \(decoded)")
            }
        ]
        
        addExampleSection(title: "加密解密示例", examples: examples)
    }
    
    private func showResult(_ text: String) {
        showAlert(message: text)
    }
}

// MARK: - 分享示例
class ShareExampleViewController: BaseExampleViewController {
    
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "分享文本", description: "shareText()") {
                self.shareText("这是要分享的文本内容")
            },
            ExampleItem(title: "分享图片", description: "shareImage()") {
                if let image = UIImage(systemName: "photo") {
                    self.shareImage(image)
                }
            },
            ExampleItem(title: "分享URL", description: "shareURL()") {
                if let url = URL(string: "https://www.example.com") {
                    self.shareURL(url)
                }
            }
        ]
        
        addExampleSection(title: "分享功能示例", examples: examples)
    }
}

// MARK: - 版本管理示例
class VersionExampleViewController: BaseExampleViewController {
    
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "版本比较", description: "VersionHelper.compare()") {
                let result = VersionHelper.compare("1.2.3", "1.2.0")
                let resultText = result > 0 ? "大于" : result < 0 ? "小于" : "等于"
                self.showResult("1.2.3 与 1.2.0 比较: \(resultText)")
            },
            ExampleItem(title: "iOS版本检查", description: "VersionHelper.isIOSVersionGreaterOrEqual()") {
                let isGreater = VersionHelper.isIOSVersionGreaterOrEqual("13.0")
                self.showResult("当前iOS版本: \(DeviceInfo.systemVersion)\n是否 >= 13.0: \(isGreater ? "是" : "否")")
            },
            ExampleItem(title: "应用版本检查", description: "VersionHelper.isAppVersionGreaterOrEqual()") {
                let currentVersion = AppInfo.appVersion
                let isGreater = VersionHelper.isAppVersionGreaterOrEqual("1.0.0")
                self.showResult("当前应用版本: \(currentVersion)\n是否 >= 1.0.0: \(isGreater ? "是" : "否")")
            }
        ]
        
        addExampleSection(title: "版本管理示例", examples: examples)
    }
    
    private func showResult(_ text: String) {
        showAlert(message: text)
    }
}

