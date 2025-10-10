//
//  MCNetworkDemo.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation
import RxSwift
import Moya

/// 网络请求示例类
class MCNetworkDemo {
    
    /// 处理网络请求的DisposeBag
    private let disposeBag = DisposeBag()
    
    /// 网络管理器
    private let networkManager = MCNetworkManager.shared
    
    // MARK: - 模型
    
    /// Banner模型
    struct Banner: Codable {
        let id: Int
        let imageUrl: String
        let linkUrl: String
        let title: String
    }
    
    /// 分类模型
    struct Category: Codable {
        let id: Int
        let name: String
        let icon: String
    }
    
    /// 商品模型
    struct Product: Codable {
        let id: Int
        let name: String
        let price: Double
        let imageUrl: String
        let description: String
    }
    
    /// 分页响应模型
    struct PageResponse<T: Codable>: Codable {
        let list: [T]
        let total: Int
        let page: Int
        let pageSize: Int
    }
    
    // MARK: - 示例方法
    
    /// 获取Banner（带缓存）
    func fetchBanners() {
        networkManager.requestWithCache(MCApiService.banners)
            .subscribe(onNext: { (banners: [Banner]) in
                print("获取到\(banners.count)个Banner")
                for banner in banners {
                    print("Banner: \(banner.title)")
                }
            }, onError: { error in
                print("获取Banner失败: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    /// 获取分类（带缓存）
    func fetchCategories() {
        networkManager.requestWithCache(MCApiService.categories)
            .subscribe(onNext: { (categories: [Category]) in
                print("获取到\(categories.count)个分类")
                for category in categories {
                    print("分类: \(category.name)")
                }
            }, onError: { error in
                print("获取分类失败: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    /// 获取商品列表（带缓存）
    func fetchProducts(page: Int = 1, pageSize: Int = 10, categoryId: Int? = nil) {
        networkManager.requestWithCache(MCApiService.productList(page: page, pageSize: pageSize, categoryId: categoryId))
            .subscribe(onNext: { (response: PageResponse<Product>) in
                print("获取到\(response.list.count)个商品，总数: \(response.total)")
                for product in response.list {
                    print("商品: \(product.name), 价格: \(product.price)")
                }
            }, onError: { error in
                print("获取商品列表失败: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    /// 获取商品详情（不使用缓存）
    func fetchProductDetail(productId: Int) {
        networkManager.requestWithCache(MCApiService.productDetail(productId: productId), useCache: false)
            .subscribe(onNext: { (product: Product) in
                print("商品详情: \(product.name)")
                print("价格: \(product.price)")
                print("描述: \(product.description)")
            }, onError: { error in
                print("获取商品详情失败: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    /// 只从缓存获取数据
    func fetchCachedBanners() {
        networkManager.requestWithCache(MCCacheApiService.banners)
            .subscribe(onNext: { (banners: [Banner]) in
                print("从缓存获取到\(banners.count)个Banner")
            }, onError: { error in
                print("从缓存获取Banner失败: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    /// 清除指定缓存
    func clearBannersCache() {
        networkManager.clearCache(for: MCApiService.banners)
        print("已清除Banner缓存")
    }
    
    /// 清除所有缓存
    func clearAllCache() {
        networkManager.clearAllCache()
        print("已清除所有缓存")
    }
    
    /// 监听网络状态变化
    func monitorNetworkStatus() {
        networkManager.networkStatusObservable
            .subscribe(onNext: { isReachable in
                if isReachable {
                    print("网络已连接，重启待处理的请求")
                } else {
                    print("网络已断开，请求将在网络恢复后自动重启")
                }
            })
            .disposed(by: disposeBag)
    }
    
    /// 综合示例：先从缓存获取，然后从网络获取最新数据
    func fetchProductsWithCacheThenNetwork(page: Int = 1, pageSize: Int = 10) {
        // 先从缓存获取
        networkManager.requestWithCache(MCCacheApiService.productList(page: page, pageSize: pageSize, categoryId: nil))
            .subscribe(onNext: { (response: PageResponse<Product>) in
                print("从缓存获取到\(response.list.count)个商品")
            }, onError: { _ in
                print("缓存中没有数据")
            })
            .disposed(by: disposeBag)
        
        // 然后从网络获取最新数据
        networkManager.requestWithCache(MCApiService.productList(page: page, pageSize: pageSize, categoryId: nil))
            .subscribe(onNext: { (response: PageResponse<Product>) in
                print("从网络获取到\(response.list.count)个最新商品")
            }, onError: { error in
                print("从网络获取商品失败: \(error)")
            })
            .disposed(by: disposeBag)
    }
}