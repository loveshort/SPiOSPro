//
//  CountDownTimer.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import Foundation

// MARK: - 倒计时工具类
class CountDownTimer {
    
    /// 倒计时更新回调
    var onTick: ((Int) -> Void)?
    
    /// 倒计时结束回调
    var onFinish: (() -> Void)?
    
    /// 当前剩余秒数
    private(set) var remainingSeconds: Int = 0
    
    /// 总秒数
    private(set) var totalSeconds: Int = 0
    
    /// 定时器
    private var timer: Timer?
    
    /// 是否正在运行
    private(set) var isRunning: Bool = false
    
    // MARK: - 初始化
    
    /// 初始化
    /// - Parameter totalSeconds: 总秒数
    init(totalSeconds: Int = 60) {
        self.totalSeconds = totalSeconds
        self.remainingSeconds = totalSeconds
    }
    
    deinit {
        stop()
    }
    
    // MARK: - 控制方法
    
    /// 开始倒计时
    /// - Parameter totalSeconds: 总秒数（可选，不传则使用初始值）
    func start(totalSeconds: Int? = nil) {
        if let seconds = totalSeconds {
            self.totalSeconds = seconds
            self.remainingSeconds = seconds
        }
        
        guard !isRunning else { return }
        
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.tick()
        }
        
        // 添加到RunLoop以确保在滚动时也能正常工作
        if let timer = timer {
            RunLoop.current.add(timer, forMode: .common)
        }
    }
    
    /// 停止倒计时
    func stop() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }
    
    /// 重置倒计时
    func reset() {
        stop()
        remainingSeconds = totalSeconds
    }
    
    /// 暂停（保留当前剩余时间）
    func pause() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }
    
    /// 继续（从当前剩余时间继续）
    func resume() {
        guard !isRunning, remainingSeconds > 0 else { return }
        
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.tick()
        }
        
        if let timer = timer {
            RunLoop.current.add(timer, forMode: .common)
        }
    }
    
    // MARK: - 私有方法
    
    private func tick() {
        remainingSeconds -= 1
        onTick?(remainingSeconds)
        
        if remainingSeconds <= 0 {
            stop()
            onFinish?()
        }
    }
}

// MARK: - UIButton 倒计时扩展
extension UIButton {
    
    private struct AssociatedKeys {
        static var countDownTimer = "countDownTimer"
        static var originalTitle = "originalTitle"
        static var originalEnabled = "originalEnabled"
    }
    
    private var countDownTimer: CountDownTimer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.countDownTimer) as? CountDownTimer
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.countDownTimer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var originalTitle: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.originalTitle) as? String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.originalTitle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 开始倒计时
    /// - Parameters:
    ///   - seconds: 倒计时秒数
    ///   - format: 格式字符串（默认：重新获取(%ds)）
    func startCountDown(seconds: Int = 60, format: String = "重新获取(%ds)") {
        // 保存原始状态
        originalTitle = currentTitle
        isEnabled = false
        
        // 创建定时器
        let timer = CountDownTimer(totalSeconds: seconds)
        countDownTimer = timer
        
        timer.onTick = { [weak self] remaining in
            guard let self = self else { return }
            let title = format.replacingOccurrences(of: "%d", with: "\(remaining)")
            self.setTitle(title, for: .normal)
        }
        
        timer.onFinish = { [weak self] in
            guard let self = self else { return }
            self.setTitle(self.originalTitle, for: .normal)
            self.isEnabled = true
            self.countDownTimer = nil
        }
        
        timer.start()
    }
    
    /// 停止倒计时
    func stopCountDown() {
        countDownTimer?.stop()
        setTitle(originalTitle, for: .normal)
        isEnabled = true
        countDownTimer = nil
    }
}

// 需要导入 Objective-C 运行时
import ObjectiveC

