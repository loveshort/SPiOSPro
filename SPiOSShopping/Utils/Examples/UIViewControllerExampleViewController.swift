//
//  UIViewControllerExampleViewController.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

class UIViewControllerExampleViewController: BaseExampleViewController {
    
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "显示提示框", description: "showAlert(message:)") {
                self.showAlert(message: "这是一个提示框示例")
            },
            ExampleItem(title: "显示确认框", description: "showConfirm(message:)") {
                self.showConfirm(message: "确定要执行此操作吗？", confirmHandler: {
                    self.showToast(message: "已确认")
                })
            },
            ExampleItem(title: "显示输入框", description: "showInput(message:)") {
                self.showInput(message: "请输入内容", placeholder: "请输入") { text in
                    if let text = text, !text.isEmpty {
                        self.showToast(message: "输入内容: \(text)")
                    }
                }
            },
            ExampleItem(title: "显示Toast", description: "showToast(message:)") {
                self.showToast(message: "这是一个Toast提示")
            },
            ExampleItem(title: "点击空白处收起键盘", description: "addTapToDismissKeyboard()") {
                self.addTapToDismissKeyboard()
                self.showToast(message: "已启用点击空白处收起键盘")
            }
        ]
        
        addExampleSection(title: "UIViewController 扩展示例", examples: examples)
    }
}

