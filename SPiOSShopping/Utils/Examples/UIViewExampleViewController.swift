//
//  UIViewExampleViewController.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit
import SnapKit

class UIViewExampleViewController: BaseExampleViewController {
    
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "设置圆角", description: "view.setCornerRadius(10)") {
                self.demoCornerRadius()
            },
            ExampleItem(title: "设置圆形", description: "view.setRound()") {
                self.demoRound()
            },
            ExampleItem(title: "设置阴影", description: "view.setShadow()") {
                self.demoShadow()
            },
            ExampleItem(title: "添加渐变色", description: "view.addGradientLayer()") {
                self.demoGradient()
            },
            ExampleItem(title: "淡入动画", description: "view.fadeIn()") {
                self.demoFadeIn()
            },
            ExampleItem(title: "缩放动画", description: "view.scaleAnimation()") {
                self.demoScale()
            }
        ]
        
        addExampleSection(title: "UIView 扩展示例", examples: examples)
    }
    
    private func demoCornerRadius() {
        let demoView = UIView()
        demoView.backgroundColor = .mainColor
        demoView.setCornerRadius(10)
        showDemoView(demoView, title: "圆角示例")
    }
    
    private func demoRound() {
        let demoView = UIView()
        demoView.backgroundColor = .mainColor
        demoView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        demoView.setRound()
        showDemoView(demoView, title: "圆形示例")
    }
    
    private func demoShadow() {
        let demoView = UIView()
        demoView.backgroundColor = .white
        demoView.setShadow(color: .black, opacity: 0.2, radius: 8)
        demoView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        showDemoView(demoView, title: "阴影示例")
    }
    
    private func demoGradient() {
        let demoView = UIView()
        demoView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        demoView.addGradientLayer(colors: [.red, .blue])
        showDemoView(demoView, title: "渐变色示例")
    }
    
    private func demoFadeIn() {
        let demoView = UIView()
        demoView.backgroundColor = .mainColor
        demoView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        demoView.isHidden = true
        showDemoView(demoView, title: "淡入动画示例") {
            demoView.fadeIn()
        }
    }
    
    private func demoScale() {
        let demoView = UIView()
        demoView.backgroundColor = .mainColor
        demoView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        showDemoView(demoView, title: "缩放动画示例") {
            demoView.scaleAnimation()
        }
    }
    
    private func showDemoView(_ demoView: UIView, title: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: 250, height: 200)
        containerView.backgroundColor = .backgroundColor
        containerView.addSubview(demoView)
        demoView.center = containerView.center
        
        alert.view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 60),
            containerView.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 250),
            containerView.heightAnchor.constraint(equalToConstant: 200),
            alert.view.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        alert.addAction(UIAlertAction(title: "确定", style: .default))
        present(alert, animated: true) {
            completion?()
        }
    }
}

