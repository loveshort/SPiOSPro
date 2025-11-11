//
//  BaseExampleViewController.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit
import SnapKit

// MARK: - 示例视图控制器基类
class BaseExampleViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
        setupExamples()
    }
    
    private func setupBaseUI() {
        view.backgroundColor = .backgroundColor
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func setupExamples() {
        // 子类实现
    }
    
    // MARK: - 便捷方法
    
    func addExampleSection(title: String, examples: [ExampleItem]) {
        let sectionView = ExampleSectionView(title: title, examples: examples)
        contentView.addSubview(sectionView)
        
        var topView: UIView = contentView
        if let lastView = contentView.subviews.last, lastView != sectionView {
            topView = lastView
        }
        
        sectionView.snp.makeConstraints { make in
            if topView == contentView {
                make.top.equalToSuperview().offset(20)
            } else {
                make.top.equalTo(topView.snp.bottom).offset(20)
            }
            make.left.right.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
    }
}

// MARK: - 示例项模型
struct ExampleItem {
    let title: String
    let description: String
    let action: () -> Void
}

// MARK: - 示例区域视图
class ExampleSectionView: UIView {
    
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    
    init(title: String, examples: [ExampleItem]) {
        super.init(frame: .zero)
        setupUI(title: title, examples: examples)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(title: String, examples: [ExampleItem]) {
        backgroundColor = .white
        
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .textPrimaryColor
        
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fill
        
        addSubview(titleLabel)
        addSubview(stackView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        // 添加示例项
        for example in examples {
            let itemView = ExampleItemView(item: example)
            stackView.addArrangedSubview(itemView)
        }
    }
}

// MARK: - 示例项视图
class ExampleItemView: UIView {
    
    private let titleLabel = UILabel()
    private let descLabel = UILabel()
    private let actionButton = UIButton()
    private let resultLabel = UILabel()
    
    private let item: ExampleItem
    
    init(item: ExampleItem) {
        self.item = item
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .backgroundColor
        setCornerRadius(8)
        
        titleLabel.text = item.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textColor = .textPrimaryColor
        
        descLabel.text = item.description
        descLabel.font = UIFont.systemFont(ofSize: 13)
        descLabel.textColor = .textSecondaryColor
        descLabel.numberOfLines = 0
        
        actionButton.setTitle("执行", for: .normal)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.backgroundColor = .mainColor
        actionButton.setCornerRadius(6)
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        actionButton.addAction { [weak self] _ in
            self?.executeAction()
        }
        
        resultLabel.text = "点击执行按钮查看结果"
        resultLabel.font = UIFont.systemFont(ofSize: 12)
        resultLabel.textColor = .textTertiaryColor
        resultLabel.numberOfLines = 0
        resultLabel.isHidden = true
        
        addSubview(titleLabel)
        addSubview(descLabel)
        addSubview(actionButton)
        addSubview(resultLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(80)
            make.height.equalTo(32)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(actionButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    private func executeAction() {
        resultLabel.isHidden = false
        item.action()
    }
}

