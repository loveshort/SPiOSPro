//
//  MJRefreshWrapper.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit
import MJRefresh

// MARK: - UIScrollView 刷新封装
extension UIScrollView {
    
    /// 添加下拉刷新
    /// - Parameter handler: 刷新回调
    func addHeaderRefresh(handler: @escaping () -> Void) {
        mj_header = MJRefreshNormalHeader { [weak self] in
            handler()
        }
    }
    
    /// 添加下拉刷新（自定义文字）
    /// - Parameters:
    ///   - handler: 刷新回调
    ///   - idleText: 普通状态文字
    ///   - pullingText: 松开刷新文字
    ///   - refreshingText: 刷新中文字
    func addHeaderRefresh(
        handler: @escaping () -> Void,
        idleText: String = "下拉刷新",
        pullingText: String = "松开刷新",
        refreshingText: String = "刷新中..."
    ) {
        let header = MJRefreshNormalHeader { [weak self] in
            handler()
        }
        header?.setTitle(idleText, for: .idle)
        header?.setTitle(pullingText, for: .pulling)
        header?.setTitle(refreshingText, for: .refreshing)
        mj_header = header
    }
    
    /// 添加上拉加载
    /// - Parameter handler: 加载回调
    func addFooterRefresh(handler: @escaping () -> Void) {
        mj_footer = MJRefreshAutoNormalFooter { [weak self] in
            handler()
        }
    }
    
    /// 添加上拉加载（自定义文字）
    /// - Parameters:
    ///   - handler: 加载回调
    ///   - idleText: 普通状态文字
    ///   - refreshingText: 加载中文字
    ///   - noMoreDataText: 没有更多数据文字
    func addFooterRefresh(
        handler: @escaping () -> Void,
        idleText: String = "上拉加载更多",
        refreshingText: String = "加载中...",
        noMoreDataText: String = "没有更多数据了"
    ) {
        let footer = MJRefreshAutoNormalFooter { [weak self] in
            handler()
        }
        footer?.setTitle(idleText, for: .idle)
        footer?.setTitle(refreshingText, for: .refreshing)
        footer?.setTitle(noMoreDataText, for: .noMoreData)
        mj_footer = footer
    }
    
    /// 开始刷新
    func beginRefreshing() {
        mj_header?.beginRefreshing()
    }
    
    /// 结束刷新
    func endRefreshing() {
        mj_header?.endRefreshing()
    }
    
    /// 开始加载
    func beginLoading() {
        mj_footer?.beginRefreshing()
    }
    
    /// 结束加载
    func endLoading() {
        mj_footer?.endRefreshing()
    }
    
    /// 结束加载（没有更多数据）
    func endLoadingWithNoMoreData() {
        mj_footer?.endRefreshingWithNoMoreData()
    }
    
    /// 重置上拉加载（恢复可加载状态）
    func resetFooter() {
        mj_footer?.resetNoMoreData()
    }
    
    /// 移除下拉刷新
    func removeHeaderRefresh() {
        mj_header = nil
    }
    
    /// 移除上拉加载
    func removeFooterRefresh() {
        mj_footer = nil
    }
}

// MARK: - UITableView 刷新封装
extension UITableView {
    
    /// 配置刷新（下拉刷新 + 上拉加载）
    /// - Parameters:
    ///   - headerHandler: 下拉刷新回调
    ///   - footerHandler: 上拉加载回调
    func configRefresh(
        headerHandler: @escaping () -> Void,
        footerHandler: @escaping () -> Void
    ) {
        addHeaderRefresh(handler: headerHandler)
        addFooterRefresh(handler: footerHandler)
    }
}

// MARK: - UICollectionView 刷新封装
extension UICollectionView {
    
    /// 配置刷新（下拉刷新 + 上拉加载）
    /// - Parameters:
    ///   - headerHandler: 下拉刷新回调
    ///   - footerHandler: 上拉加载回调
    func configRefresh(
        headerHandler: @escaping () -> Void,
        footerHandler: @escaping () -> Void
    ) {
        addHeaderRefresh(handler: headerHandler)
        addFooterRefresh(handler: footerHandler)
    }
}

