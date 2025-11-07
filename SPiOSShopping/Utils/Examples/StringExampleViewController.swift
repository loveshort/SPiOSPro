//
//  StringExampleViewController.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

class StringExampleViewController: BaseExampleViewController {
    
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "验证邮箱", description: "\"test@example.com\".isValidEmail") {
                let email = "test@example.com"
                let result = email.isValidEmail
                self.showResult("邮箱: \(email)\n验证结果: \(result ? "✅ 有效" : "❌ 无效")")
            },
            ExampleItem(title: "验证手机号", description: "\"13800138000\".isValidPhone") {
                let phone = "13800138000"
                let result = phone.isValidPhone
                self.showResult("手机号: \(phone)\n验证结果: \(result ? "✅ 有效" : "❌ 无效")")
            },
            ExampleItem(title: "手机号格式化", description: "\"13800138000\".formattedPhone") {
                let phone = "13800138000"
                let formatted = phone.formattedPhone
                self.showResult("原手机号: \(phone)\n格式化后: \(formatted)")
            },
            ExampleItem(title: "银行卡格式化", description: "\"6222021234567890123\".formattedBankCard") {
                let card = "6222021234567890123"
                let formatted = card.formattedBankCard
                self.showResult("原卡号: \(card)\n格式化后: \(formatted)")
            },
            ExampleItem(title: "文本尺寸计算", description: "\"Hello World\".size(with:font:maxWidth:)") {
                let text = "Hello World"
                let font = UIFont.systemFont(ofSize: 16)
                let size = text.size(with: font, maxWidth: 200)
                self.showResult("文本: \(text)\n字体大小: 16\n最大宽度: 200\n计算结果: 宽度=\(Int(size.width)), 高度=\(Int(size.height))")
            },
            ExampleItem(title: "拼音转换", description: "\"你好\".toPinyinWithoutTone") {
                let text = "你好"
                let pinyin = text.toPinyinWithoutTone
                let firstLetter = text.firstLetter
                self.showResult("原文本: \(text)\n拼音: \(pinyin)\n首字母: \(firstLetter)")
            }
        ]
        
        addExampleSection(title: "String 扩展示例", examples: examples)
    }
    
    private func showResult(_ text: String) {
        showAlert(message: text)
    }
}

