//
//  CountDownTimerExampleViewController.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit
import SnapKit

class CountDownTimerExampleViewController: BaseExampleViewController {
    
    private var timer: CountDownTimer?
    private var timerLabel: UILabel?
    
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "基本倒计时", description: "CountDownTimer(totalSeconds: 10)") {
                self.demoBasicTimer()
            },
            ExampleItem(title: "按钮倒计时", description: "button.startCountDown(seconds: 60)") {
                self.demoButtonTimer()
            }
        ]
        
        addExampleSection(title: "CountDownTimer 示例", examples: examples)
    }
    
    private func demoBasicTimer() {
        let alert = UIAlertController(title: "倒计时示例", message: nil, preferredStyle: .alert)
        
        let label = UILabel()
        label.text = "10"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = .mainColor
        
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        containerView.addSubview(label)
        label.frame = containerView.bounds
        
        alert.view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 60),
            containerView.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 200),
            containerView.heightAnchor.constraint(equalToConstant: 100),
            alert.view.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        let timer = CountDownTimer(totalSeconds: 10)
        timer.onTick = { remaining in
            label.text = "\(remaining)"
        }
        timer.onFinish = {
            label.text = "完成"
            label.textColor = .systemGreen
        }
        
        alert.addAction(UIAlertAction(title: "开始", style: .default) { _ in
            timer.start()
        })
        alert.addAction(UIAlertAction(title: "关闭", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func demoButtonTimer() {
        let button = UIButton(title: "获取验证码", titleColor: .white, backgroundColor: .mainColor)
        button.setCornerRadius(8)
        button.frame = CGRect(x: 0, y: 0, width: 120, height: 40)
        
        let alert = UIAlertController(title: "按钮倒计时示例", message: nil, preferredStyle: .alert)
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        containerView.addSubview(button)
        button.center = containerView.center
        
        alert.view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 60),
            containerView.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 200),
            containerView.heightAnchor.constraint(equalToConstant: 100),
            alert.view.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        button.addAction { _ in
            button.startCountDown(seconds: 10, format: "重新获取(%ds)")
        }
        
        alert.addAction(UIAlertAction(title: "关闭", style: .cancel))
        present(alert, animated: true)
    }
}

