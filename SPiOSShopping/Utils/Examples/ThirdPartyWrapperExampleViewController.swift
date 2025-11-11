//
//  ThirdPartyWrapperExampleViewController.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit
import SnapKit
import RxSwift

class ThirdPartyWrapperExampleViewController: BaseExampleViewController {
    
    private let disposeBag = DisposeBag()
    
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "Kingfisher 图片加载", description: "UIImageView.setImage(urlString:)") {
                self.demoKingfisher()
            },
            ExampleItem(title: "MJRefresh 下拉刷新", description: "scrollView.addHeaderRefresh()") {
                self.demoMJRefresh()
            },
            ExampleItem(title: "SnapKit 自动布局", description: "view.fillSuperview()") {
                self.demoSnapKit()
            },
            ExampleItem(title: "SwiftyJSON 解析", description: "MCJSONHelper.parse()") {
                self.demoSwiftyJSON()
            },
            ExampleItem(title: "EmptyDataSet 空数据", description: "tableView.setEmptyDataSet()") {
                self.demoEmptyDataSet()
            },
            ExampleItem(title: "RxSwift 响应式", description: "button.rx.tap") {
                self.demoRxSwift()
            },
            ExampleItem(title: "Router 路由跳转", description: "MCRouter.shared.push()") {
                self.demoRouter()
            },
            ExampleItem(title: "SwiftyBeaver 日志", description: "MCLogger.shared.debug()") {
                self.demoSwiftyBeaver()
            },
            ExampleItem(title: "Toast-Swift 提示", description: "view.showToast()") {
                self.demoToast()
            }
        ]
        
        addExampleSection(title: "第三方库封装示例", examples: examples)
    }
    
    // MARK: - 示例方法
    
    private func demoKingfisher() {
        let alert = UIAlertController(title: "Kingfisher 示例", message: nil, preferredStyle: .alert)
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .backgroundColor
        imageView.setCornerRadius(8)
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        // 使用示例图片URL
        let imageURL = "https://picsum.photos/200/200"
        imageView.setImage(urlString: imageURL, placeholder: UIImage(systemName: "photo"))
        
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
        containerView.backgroundColor = .backgroundColor
        containerView.addSubview(imageView)
        imageView.center = containerView.center
        
        alert.view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 60),
            containerView.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 250),
            containerView.heightAnchor.constraint(equalToConstant: 250),
            alert.view.heightAnchor.constraint(equalToConstant: 350)
        ])
        
        alert.addAction(UIAlertAction(title: "确定", style: .default))
        present(alert, animated: true)
    }
    
    private func demoMJRefresh() {
        let tableView = UITableView()
        tableView.addHeaderRefresh {
            ThreadHelper.delay(1.0) {
                tableView.endRefreshing()
                self.showToast(message: "刷新完成")
            }
        }
        
        tableView.addFooterRefresh {
            ThreadHelper.delay(1.0) {
                tableView.endLoading()
                self.showToast(message: "加载完成")
            }
        }
        
        showAlert(message: "MJRefresh 示例\n\n已添加下拉刷新和上拉加载功能\n请在实际的TableView中测试")
    }
    
    private func demoSnapKit() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        let subView = UIView()
        subView.backgroundColor = .mainColor
        containerView.addSubview(subView)
        
        // 使用SnapKit封装方法
        subView.fillSuperview(insets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        
        let alert = UIAlertController(title: "SnapKit 示例", message: "使用 fillSuperview() 快速设置约束", preferredStyle: .alert)
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
    
    private func demoSwiftyJSON() {
        let jsonString = """
        {
            "name": "张三",
            "age": 25,
            "isActive": true,
            "score": 95.5
        }
        """
        
        if let json = MCJSONHelper.parse(jsonString) {
            let name = json["name"].stringValue()
            let age = json["age"].intValue()
            let isActive = json["isActive"].boolValue()
            let score = json["score"].doubleValue()
            
            showResult("""
            SwiftyJSON 解析示例
            
            姓名: \(name)
            年龄: \(age)
            是否激活: \(isActive)
            分数: \(score)
            """)
        }
    }
    
    private func demoEmptyDataSet() {
        let tableView = UITableView()
        tableView.setEmptyDataSet(
            title: "暂无数据",
            description: "这里还没有任何内容",
            image: UIImage(systemName: "tray"),
            buttonTitle: "刷新",
            buttonAction: {
                self.showToast(message: "点击了刷新按钮")
            }
        )
        
        showAlert(message: "EmptyDataSet 示例\n\n已设置空数据视图\n在实际的TableView中测试")
    }
    
    private func demoRxSwift() {
        let button = UIButton(title: "点击我", titleColor: .white, backgroundColor: .mainColor)
        button.setCornerRadius(8)
        button.frame = CGRect(x: 0, y: 0, width: 120, height: 40)
        
        // 使用RxSwift封装
        button.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showToast(message: "RxSwift 响应式编程示例")
            })
            .disposed(by: disposeBag)
        
        let alert = UIAlertController(title: "RxSwift 示例", message: "使用 button.rx.tap 监听点击", preferredStyle: .alert)
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
        alert.addAction(UIAlertAction(title: "关闭", style: .cancel))
        present(alert, animated: true)
    }
    
    private func demoRouter() {
        showAlert(message: "Router 示例\n\n使用 MCRouter.shared.push() 进行路由跳转\n需要先注册路由路径")
    }
    
    private func demoSwiftyBeaver() {
        MCLogger.shared.debug("这是调试日志")
        MCLogger.shared.info("这是信息日志")
        MCLogger.shared.warning("这是警告日志")
        MCLogger.shared.error("这是错误日志")
        
        showResult("SwiftyBeaver 日志示例\n\n已输出日志到控制台\n请查看Xcode控制台")
    }
    
    private func demoToast() {
        let alert = UIAlertController(title: "Toast-Swift 示例", message: "选择Toast类型", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "普通Toast", style: .default) { _ in
            self.view.showToast(message: "这是普通Toast提示")
        })
        
        alert.addAction(UIAlertAction(title: "成功Toast", style: .default) { _ in
            self.view.showSuccessToast(message: "操作成功！")
        })
        
        alert.addAction(UIAlertAction(title: "错误Toast", style: .default) { _ in
            self.view.showErrorToast(message: "操作失败！")
        })
        
        alert.addAction(UIAlertAction(title: "警告Toast", style: .default) { _ in
            self.view.showWarningToast(message: "请注意！")
        })
        
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        
        // iPad支持
        if let popover = alert.popoverPresentationController {
            popover.sourceView = view
            popover.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popover.permittedArrowDirections = []
        }
        
        present(alert, animated: true)
    }
    
    // MARK: - 辅助方法
    
    private func showResult(_ text: String) {
        showAlert(message: text)
    }
}

