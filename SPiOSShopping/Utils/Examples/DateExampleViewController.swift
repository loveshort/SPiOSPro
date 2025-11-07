//
//  DateExampleViewController.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

class DateExampleViewController: BaseExampleViewController {
    
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "日期格式化", description: "Date().toString(format:)") {
                let date = Date()
                let formatted = date.toString(format: "yyyy-MM-dd HH:mm:ss")
                self.showResult("当前日期: \(formatted)")
            },
            ExampleItem(title: "时间戳转换", description: "Date().timestamp") {
                let date = Date()
                let timestamp = date.timestamp
                let dateFromTimestamp = Date.fromTimestamp(timestamp)
                self.showResult("时间戳: \(Int(timestamp))\n转换回日期: \(dateFromTimestamp.toString())")
            },
            ExampleItem(title: "日期计算", description: "Date().addingDays(1)") {
                let today = Date()
                let tomorrow = today.addingDays(1)
                let nextWeek = today.addingDays(7)
                self.showResult("今天: \(today.toString(format: "yyyy-MM-dd"))\n明天: \(tomorrow.toString(format: "yyyy-MM-dd"))\n下周: \(nextWeek.toString(format: "yyyy-MM-dd"))")
            },
            ExampleItem(title: "日期比较", description: "Date().isToday") {
                let date = Date()
                self.showResult("是否今天: \(date.isToday ? "是" : "否")\n是否本周: \(date.isThisWeek ? "是" : "否")\n是否今年: \(date.isThisYear ? "是" : "否")")
            },
            ExampleItem(title: "相对时间", description: "Date().relativeTime") {
                let now = Date()
                let oneMinuteAgo = now.addingMinutes(-1)
                let oneHourAgo = now.addingHours(-1)
                self.showResult("1分钟前: \(oneMinuteAgo.relativeTime)\n1小时前: \(oneHourAgo.relativeTime)\n现在: \(now.relativeTime)")
            },
            ExampleItem(title: "日期组件", description: "Date().year, .month, .day") {
                let date = Date()
                self.showResult("年: \(date.year)\n月: \(date.month)\n日: \(date.day)\n星期: \(date.weekdayString)")
            }
        ]
        
        addExampleSection(title: "Date 扩展示例", examples: examples)
    }
    
    private func showResult(_ text: String) {
        showAlert(message: text)
    }
}

