//
//  DeviceInfoExampleViewController.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

class DeviceInfoExampleViewController: BaseExampleViewController {
    
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "屏幕信息", description: "DeviceInfo.screenWidth") {
                let info = """
                屏幕宽度: \(Int(DeviceInfo.screenWidth))
                屏幕高度: \(Int(DeviceInfo.screenHeight))
                屏幕缩放: \(DeviceInfo.screenScale)
                是否横屏: \(DeviceInfo.isLandscape ? "是" : "否")
                """
                self.showResult(info)
            },
            ExampleItem(title: "设备信息", description: "DeviceInfo.deviceModel") {
                let info = """
                设备型号: \(DeviceInfo.deviceModel)
                设备名称: \(DeviceInfo.deviceName)
                系统名称: \(DeviceInfo.systemName)
                系统版本: \(DeviceInfo.systemVersion)
                是否iPhone: \(DeviceInfo.isiPhone ? "是" : "否")
                是否iPad: \(DeviceInfo.isiPad ? "是" : "否")
                是否模拟器: \(DeviceInfo.isSimulator ? "是" : "否")
                """
                self.showResult(info)
            },
            ExampleItem(title: "安全区域", description: "DeviceInfo.statusBarHeight") {
                let info = """
                状态栏高度: \(Int(DeviceInfo.statusBarHeight))
                导航栏高度: \(Int(DeviceInfo.navigationBarHeight))
                顶部总高度: \(Int(DeviceInfo.topBarHeight))
                TabBar高度: \(Int(DeviceInfo.tabBarHeight))
                底部安全区域: \(Int(DeviceInfo.bottomSafeAreaHeight))
                是否iPhone X系列: \(DeviceInfo.isiPhoneXSeries ? "是" : "否")
                """
                self.showResult(info)
            },
            ExampleItem(title: "设备判断", description: "DeviceInfo.isSmallScreen") {
                let info = """
                是否小屏设备: \(DeviceInfo.isSmallScreen ? "是" : "否")
                是否大屏设备: \(DeviceInfo.isLargeScreen ? "是" : "否")
                """
                self.showResult(info)
            }
        ]
        
        addExampleSection(title: "DeviceInfo 示例", examples: examples)
    }
    
    private func showResult(_ text: String) {
        showAlert(message: text)
    }
}

