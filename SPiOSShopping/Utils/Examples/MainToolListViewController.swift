//
//  MainToolListViewController.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

// MARK: - 工具类列表主界面
class MainToolListViewController: UIViewController {
    
    // MARK: - 属性
    
    private let tableView = UITableView()
    
    private let toolSections: [(title: String, tools: [ToolItem])] = [
        ("扩展类 (Extensions)", [
            ToolItem(title: "UIView 扩展", description: "圆角、阴影、渐变色、动画等", type: .uiview),
            ToolItem(title: "UIColor 扩展", description: "十六进制颜色、RGB颜色等", type: .uicolor),
            ToolItem(title: "String 扩展", description: "验证、格式化、尺寸计算等", type: .string),
            ToolItem(title: "Date 扩展", description: "格式化、计算、比较等", type: .date),
            ToolItem(title: "UIViewController 扩展", description: "提示框、Toast、导航栏等", type: .uiviewcontroller),
            ToolItem(title: "UIImage 扩展", description: "缩放、裁剪、压缩等", type: .uiimage),
            ToolItem(title: "Array 扩展", description: "安全访问、去重、分组等", type: .array),
            ToolItem(title: "Dictionary 扩展", description: "安全访问、合并、转换等", type: .dictionary),
            ToolItem(title: "Int/Double 扩展", description: "格式化、范围限制等", type: .number),
            ToolItem(title: "UILabel 扩展", description: "便捷初始化、样式设置等", type: .uilabel),
            ToolItem(title: "UIButton 扩展", description: "便捷初始化、布局设置等", type: .uibutton),
            ToolItem(title: "UITextField 扩展", description: "占位符、左右视图等", type: .uitextfield),
            ToolItem(title: "UITextView 扩展", description: "占位符、输入限制等", type: .uitextview),
            ToolItem(title: "UIScrollView 扩展", description: "滚动到指定位置等", type: .uiscrollview),
            ToolItem(title: "UIApplication 扩展", description: "应用信息、打开设置等", type: .uiapplication),
        ]),
        ("工具类 (Helpers)", [
            ToolItem(title: "DeviceInfo", description: "设备信息工具类", type: .deviceinfo),
            ToolItem(title: "AppInfo", description: "应用信息工具类", type: .appinfo),
            ToolItem(title: "KeyboardManager", description: "键盘管理工具类", type: .keyboardmanager),
            ToolItem(title: "CountDownTimer", description: "倒计时工具类", type: .countdowntimer),
            ToolItem(title: "JSONHelper", description: "JSON处理工具类", type: .jsonhelper),
            ToolItem(title: "RegexHelper", description: "正则表达式工具类", type: .regexhelper),
            ToolItem(title: "ThreadHelper", description: "线程工具类", type: .threadhelper),
            ToolItem(title: "UserDefaults 扩展", description: "用户偏好设置扩展", type: .userdefaults),
            ToolItem(title: "PrintHelper", description: "打印工具类", type: .printhelper),
            ToolItem(title: "网络请求", description: "网络请求封装和调用", type: .network),
            ToolItem(title: "第三方库封装", description: "Kingfisher、MJRefresh等封装", type: .thirdparty),
            ToolItem(title: "权限管理", description: "相机、相册、定位等权限", type: .permission),
            ToolItem(title: "加密解密", description: "MD5、SHA256、Base64等", type: .crypto),
            ToolItem(title: "分享功能", description: "系统分享功能封装", type: .share),
            ToolItem(title: "版本管理", description: "版本比较和检查", type: .version),
            ToolItem(title: "Realm 数据库", description: "Realm数据库封装", type: .realm),
        ])
    ]
    
    // MARK: - 生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI设置
    
    private func setupUI() {
        title = "工具类示例"
        view.backgroundColor = .backgroundColor
        
        // 设置导航栏
        setNavigationTitle("工具类示例")
        setNavigationTitleColor(.textPrimaryColor)
        
        // 设置表格视图
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .backgroundColor
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .separatorColor
        tableView.register(ToolListCell.self, forCellReuseIdentifier: "ToolListCell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource
extension MainToolListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return toolSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toolSections[section].tools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToolListCell", for: indexPath) as! ToolListCell
        let tool = toolSections[indexPath.section].tools[indexPath.row]
        cell.configure(with: tool)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return toolSections[section].title
    }
}

// MARK: - UITableViewDelegate
extension MainToolListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let tool = toolSections[indexPath.section].tools[indexPath.row]
        let exampleVC = createExampleViewController(for: tool.type)
        exampleVC.title = tool.title
        navigationController?.pushViewController(exampleVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // MARK: - 创建示例视图控制器
    
    private func createExampleViewController(for type: ToolType) -> UIViewController {
        switch type {
        case .uiview:
            return UIViewExampleViewController()
        case .uicolor:
            return UIColorExampleViewController()
        case .string:
            return StringExampleViewController()
        case .date:
            return DateExampleViewController()
        case .uiviewcontroller:
            return UIViewControllerExampleViewController()
        case .uiimage:
            return UIImageExampleViewController()
        case .array:
            return ArrayExampleViewController()
        case .dictionary:
            return DictionaryExampleViewController()
        case .number:
            return NumberExampleViewController()
        case .uilabel:
            return UILabelExampleViewController()
        case .uibutton:
            return UIButtonExampleViewController()
        case .uitextfield:
            return UITextFieldExampleViewController()
        case .uitextview:
            return UITextViewExampleViewController()
        case .uiscrollview:
            return UIScrollViewExampleViewController()
        case .uiapplication:
            return UIApplicationExampleViewController()
        case .deviceinfo:
            return DeviceInfoExampleViewController()
        case .appinfo:
            return AppInfoExampleViewController()
        case .keyboardmanager:
            return KeyboardManagerExampleViewController()
        case .countdowntimer:
            return CountDownTimerExampleViewController()
        case .jsonhelper:
            return JSONHelperExampleViewController()
        case .regexhelper:
            return RegexHelperExampleViewController()
        case .threadhelper:
            return ThreadHelperExampleViewController()
        case .userdefaults:
            return UserDefaultsExampleViewController()
        case .printhelper:
            return PrintHelperExampleViewController()
        case .network:
            return NetworkExampleViewController()
        case .thirdparty:
            return ThirdPartyWrapperExampleViewController()
        case .permission:
            return PermissionExampleViewController()
        case .crypto:
            return CryptoExampleViewController()
        case .share:
            return ShareExampleViewController()
        case .version:
            return VersionExampleViewController()
        case .realm:
            return RealmExampleViewController()
        }
    }
}

// MARK: - 工具项模型
struct ToolItem {
    let title: String
    let description: String
    let type: ToolType
}

enum ToolType {
    case uiview
    case uicolor
    case string
    case date
    case uiviewcontroller
    case uiimage
    case array
    case dictionary
    case number
    case uilabel
    case uibutton
    case uitextfield
    case uitextview
    case uiscrollview
    case uiapplication
    case deviceinfo
    case appinfo
    case keyboardmanager
    case countdowntimer
    case jsonhelper
    case regexhelper
    case threadhelper
    case userdefaults
    case printhelper
    case network
    case thirdparty
    case permission
    case crypto
    case share
    case version
    case realm
}

// MARK: - 工具列表单元格
class ToolListCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let descLabel = UILabel()
    private let arrowImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .white
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .textPrimaryColor
        
        descLabel.font = UIFont.systemFont(ofSize: 13)
        descLabel.textColor = .textSecondaryColor
        descLabel.numberOfLines = 2
        
        arrowImageView.image = UIImage(systemName: "chevron.right")
        arrowImageView.tintColor = .textTertiaryColor
        arrowImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(arrowImageView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(arrowImageView.snp.left).offset(-10)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(arrowImageView.snp.left).offset(-10)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.width.height.equalTo(20)
        }
    }
    
    func configure(with tool: ToolItem) {
        titleLabel.text = tool.title
        descLabel.text = tool.description
    }
}

// 需要导入 SnapKit
import SnapKit

