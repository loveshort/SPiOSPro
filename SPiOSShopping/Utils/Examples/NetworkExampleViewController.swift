//
//  NetworkExampleViewController.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit
import RxSwift
import SnapKit

class NetworkExampleViewController: BaseExampleViewController {
    
    private let disposeBag = DisposeBag()
    private let networkManager = MCNetworkManager.shared
    
    override func setupExamples() {
        let examples = [
            ExampleItem(title: "GET请求（带缓存）", description: "requestWithCache()") {
                self.demoGetRequestWithCache()
            },
            ExampleItem(title: "POST请求", description: "request()") {
                self.demoPostRequest()
            },
            ExampleItem(title: "分页请求", description: "requestPage()") {
                self.demoPageRequest()
            },
            ExampleItem(title: "带加载提示的请求", description: "showLoading()") {
                self.demoRequestWithLoading()
            },
            ExampleItem(title: "错误处理", description: "错误捕获和处理") {
                self.demoErrorHandling()
            },
            ExampleItem(title: "网络状态监听", description: "networkStatusObservable") {
                self.demoNetworkStatus()
            },
            ExampleItem(title: "清除缓存", description: "clearCache()") {
                self.demoClearCache()
            }
        ]
        
        addExampleSection(title: "网络请求示例", examples: examples)
    }
    
    // MARK: - 示例方法
    
    private func demoGetRequestWithCache() {
        // 模拟获取Banner列表
        networkManager.requestWithCache(MCApiService.banners)
            .subscribe(onNext: { (banners: [BannerModel]) in
                self.showResult("获取成功\n数量: \(banners.count)\n(实际项目中会显示Banner列表)")
            }, onError: { error in
                self.showError(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func demoPostRequest() {
        // 模拟登录请求
        let username = "test"
        let password = "123456"
        
        networkManager.request(MCApiService.login(username: username, password: password))
            .subscribe(onNext: { (response: MCResponse<UserModel>) in
                if response.isSuccess, let user = response.data {
                    self.showResult("登录成功\n用户名: \(user.username)\n用户ID: \(user.id)")
                } else {
                    self.showResult("登录失败: \(response.message)")
                }
            }, onError: { error in
                self.showError(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func demoPageRequest() {
        // 模拟分页请求
        networkManager.requestPage(MCApiService.productList(page: 1, pageSize: 10, categoryId: nil))
            .subscribe(onNext: { (pageResponse: MCPageResponse<ProductModel>) in
                self.showResult("""
                获取成功
                当前页: \(pageResponse.page)
                每页数量: \(pageResponse.pageSize)
                总数: \(pageResponse.total)
                总页数: \(pageResponse.totalPages)
                是否有下一页: \(pageResponse.hasNextPage ? "是" : "否")
                列表数量: \(pageResponse.list.count)
                """)
            }, onError: { error in
                self.showError(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func demoRequestWithLoading() {
        // 带加载提示的请求
        networkManager.requestWithCache(MCApiService.categories)
            .showLoading(message: "加载分类中...", inView: view)
            .subscribe(onNext: { (categories: [CategoryModel]) in
                self.showResult("加载完成\n分类数量: \(categories.count)")
            }, onError: { error in
                self.showError(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func demoErrorHandling() {
        // 错误处理示例
        networkManager.requestWithCache(MCApiService.productDetail(productId: 999999))
            .subscribe(onNext: { (product: ProductModel) in
                self.showResult("获取成功: \(product.name)")
            }, onError: { error in
                if let networkError = error as? MCNetworkError {
                    self.showResult("""
                    错误类型: \(networkError.code)
                    错误信息: \(networkError.localizedDescription)
                    """)
                } else {
                    self.showResult("错误: \(error.localizedDescription)")
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func demoNetworkStatus() {
        // 网络状态监听
        networkManager.networkStatusObservable
            .take(1) // 只取第一次
            .subscribe(onNext: { isReachable in
                self.showResult("网络状态: \(isReachable ? "已连接" : "未连接")")
            })
            .disposed(by: disposeBag)
    }
    
    private func demoClearCache() {
        // 清除缓存
        networkManager.clearCache(for: MCApiService.banners)
        showResult("已清除Banner缓存")
    }
    
    // MARK: - 辅助方法
    
    private func showResult(_ text: String) {
        showAlert(message: text)
    }
    
    private func showError(_ error: Error) {
        if let networkError = error as? MCNetworkError {
            showAlert(message: "请求失败\n\(networkError.localizedDescription)")
        } else {
            showAlert(message: "请求失败\n\(error.localizedDescription)")
        }
    }
}

// MARK: - 示例模型
struct BannerModel: Codable {
    let id: Int
    let imageUrl: String
    let title: String
}

struct CategoryModel: Codable {
    let id: Int
    let name: String
    let icon: String
}

struct ProductModel: Codable {
    let id: Int
    let name: String
    let price: Double
    let imageUrl: String
}

struct UserModel: Codable {
    let id: Int
    let username: String
    let email: String
}

