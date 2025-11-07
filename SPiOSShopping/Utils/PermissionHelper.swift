//
//  PermissionHelper.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit
import AVFoundation
import Photos
import CoreLocation

// MARK: - 权限请求工具类
struct PermissionHelper {
    
    // MARK: - 相机权限
    
    /// 检查相机权限
    /// - Returns: 权限状态
    static func checkCameraPermission() -> AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatus(for: .video)
    }
    
    /// 请求相机权限
    /// - Parameter completion: 完成回调
    static func requestCameraPermission(completion: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            ThreadHelper.main {
                completion(granted)
            }
        }
    }
    
    // MARK: - 相册权限
    
    /// 检查相册权限
    /// - Returns: 权限状态
    @available(iOS 14, *)
    static func checkPhotoLibraryPermission() -> PHAuthorizationStatus {
        return PHPhotoLibrary.authorizationStatus(for: .readWrite)
    }
    
    /// 请求相册权限
    /// - Parameter completion: 完成回调
    static func requestPhotoLibraryPermission(completion: @escaping (Bool) -> Void) {
        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                ThreadHelper.main {
                    completion(status == .authorized || status == .limited)
                }
            }
        } else {
            PHPhotoLibrary.requestAuthorization { status in
                ThreadHelper.main {
                    completion(status == .authorized)
                }
            }
        }
    }
    
    // MARK: - 定位权限
    
    /// 检查定位权限
    /// - Returns: 权限状态
    static func checkLocationPermission() -> CLAuthorizationStatus {
        return CLLocationManager().authorizationStatus
    }
    
    /// 请求定位权限
    /// - Parameters:
    ///   - manager: 定位管理器
    ///   - completion: 完成回调
    static func requestLocationPermission(manager: CLLocationManager, completion: @escaping (Bool) -> Void) {
        let status = manager.authorizationStatus
        
        if status == .notDetermined {
            manager.requestWhenInUseAuthorization()
            // 注意：实际项目中需要使用代理来获取权限结果
        } else {
            completion(status == .authorizedWhenInUse || status == .authorizedAlways)
        }
    }
    
    // MARK: - 通知权限
    
    /// 请求通知权限
    /// - Parameter completion: 完成回调
    @available(iOS 10.0, *)
    static func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            ThreadHelper.main {
                completion(granted)
            }
        }
    }
    
    // MARK: - 麦克风权限
    
    /// 检查麦克风权限
    /// - Returns: 权限状态
    static func checkMicrophonePermission() -> AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatus(for: .audio)
    }
    
    /// 请求麦克风权限
    /// - Parameter completion: 完成回调
    static func requestMicrophonePermission(completion: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .audio) { granted in
            ThreadHelper.main {
                completion(granted)
            }
        }
    }
    
    // MARK: - 打开设置
    
    /// 打开应用设置页面
    static func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

// 需要导入
import UserNotifications

