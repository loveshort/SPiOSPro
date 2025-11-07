//
//  RxSwiftWrapper.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import NSObject_Rx

// MARK: - RxSwift 便捷扩展
extension Reactive where Base: UIButton {
    
    /// 点击事件（简化版）
    var tap: ControlEvent<Void> {
        return controlEvent(.touchUpInside)
    }
}

extension Reactive where Base: UITextField {
    
    /// 文本变化（简化版，已存在value属性）
    // var textChanged: ControlProperty<String?> {
    //     return value
    // }
}

extension Reactive where Base: UISwitch {
    
    /// 开关变化（简化版，已存在isOn属性）
    // var isOn: ControlProperty<Bool> {
    //     return value
    // }
}

extension Reactive where Base: UISlider {
    
    /// 滑块值变化（简化版，已存在value属性）
    // var value: ControlProperty<Float> {
    //     return self.value
    // }
}

// MARK: - UIView 手势扩展
extension Reactive where Base: UIView {
    
    /// 点击手势
    var tapGesture: Observable<UITapGestureRecognizer> {
        return tapGesture().asObservable()
    }
    
    /// 长按手势
    var longPressGesture: Observable<UILongPressGestureRecognizer> {
        return longPressGesture().asObservable()
    }
    
    /// 滑动手势
    var swipeGesture: Observable<UISwipeGestureRecognizer> {
        return swipeGesture(.any).asObservable()
    }
}

// MARK: - UITableView 扩展
extension Reactive where Base: UITableView {
    
    /// 选中事件
    var itemSelected: Observable<IndexPath> {
        return itemSelected.asObservable()
    }
    
    /// 取消选中事件
    var itemDeselected: Observable<IndexPath> {
        return itemDeselected.asObservable()
    }
}

// MARK: - UICollectionView 扩展
extension Reactive where Base: UICollectionView {
    
    /// 选中事件
    var itemSelected: Observable<IndexPath> {
        return itemSelected.asObservable()
    }
}

// MARK: - UIViewController 扩展
extension UIViewController {
    
    /// DisposeBag（自动管理）
    var disposeBag: DisposeBag {
        return rx.disposeBag
    }
}

// MARK: - Observable 便捷方法
extension ObservableType {
    
    /// 绑定到标签
    /// - Parameter label: 标签
    /// - Returns: Disposable
    func bind(to label: UILabel) -> Disposable {
        return map { "\($0)" }
            .bind(to: label.rx.text)
    }
    
    /// 绑定到按钮标题
    /// - Parameters:
    ///   - button: 按钮
    ///   - state: 按钮状态
    /// - Returns: Disposable
    func bind(to button: UIButton, state: UIControl.State = .normal) -> Disposable {
        return map { "\($0)" }
            .subscribe(onNext: { title in
                button.setTitle(title, for: state)
            })
    }
}

// MARK: - Driver 扩展（已在RxCocoa中提供，这里只是示例）
// extension ObservableType {
//     func asDriver() -> Driver<Element> {
//         return asDriver(onErrorJustReturn: ...)
//     }
// }

// MARK: - 错误处理扩展
extension ObservableType {
    
    /// 错误处理（显示提示）
    /// - Parameter viewController: 视图控制器
    /// - Returns: Observable
    func handleError(in viewController: UIViewController) -> Observable<Element> {
        return catchError { error in
            viewController.showAlert(message: error.localizedDescription)
            return Observable.empty()
        }
    }
}

// MARK: - 加载状态扩展
extension ObservableType {
    
    /// 显示加载状态
    /// - Parameters:
    ///   - loadingView: 加载视图
    ///   - message: 加载提示
    /// - Returns: Observable
    func showLoading(in loadingView: UIView? = nil, message: String = "加载中...") -> Observable<Element> {
        return self.do(
            onSubscribe: {
                MCLoadingManager.shared.showLoading(message: message, inView: loadingView)
            },
            onDispose: {
                MCLoadingManager.shared.hideLoading()
            }
        )
    }
}

