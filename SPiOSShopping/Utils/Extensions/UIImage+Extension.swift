//
//  UIImage+Extension.swift
//  SPiOSShopping
//
//  Created by AI Assistant
//

import UIKit

// MARK: - UIImage 常用扩展
extension UIImage {
    
    // MARK: - 创建图片
    
    /// 通过颜色创建图片
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 尺寸
    /// - Returns: 图片
    static func fromColor(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(origin: .zero, size: size))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    // MARK: - 图片缩放
    
    /// 缩放图片
    /// - Parameters:
    ///   - size: 目标尺寸
    ///   - mode: 缩放模式
    /// - Returns: 缩放后的图片
    func resize(to size: CGSize, mode: ContentMode = .scaleAspectFit) -> UIImage? {
        let rect: CGRect
        switch mode {
        case .scaleAspectFit:
            let ratio = min(size.width / self.size.width, size.height / self.size.height)
            let newSize = CGSize(width: self.size.width * ratio, height: self.size.height * ratio)
            rect = CGRect(origin: .zero, size: newSize)
        case .scaleAspectFill:
            let ratio = max(size.width / self.size.width, size.height / self.size.height)
            let newSize = CGSize(width: self.size.width * ratio, height: self.size.height * ratio)
            rect = CGRect(x: (size.width - newSize.width) / 2,
                         y: (size.height - newSize.height) / 2,
                         width: newSize.width,
                         height: newSize.height)
        case .scaleToFill:
            rect = CGRect(origin: .zero, size: size)
        @unknown default:
            rect = CGRect(origin: .zero, size: size)
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// 按比例缩放
    /// - Parameter scale: 缩放比例
    /// - Returns: 缩放后的图片
    func scale(by scale: CGFloat) -> UIImage? {
        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
        return resize(to: newSize)
    }
    
    // MARK: - 图片裁剪
    
    /// 裁剪图片
    /// - Parameter rect: 裁剪区域
    /// - Returns: 裁剪后的图片
    func crop(to rect: CGRect) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        guard let croppedCGImage = cgImage.cropping(to: rect) else { return nil }
        return UIImage(cgImage: croppedCGImage, scale: scale, orientation: imageOrientation)
    }
    
    /// 裁剪为圆形
    /// - Returns: 圆形图片
    func circular() -> UIImage? {
        let minSize = min(size.width, size.height)
        let squareSize = CGSize(width: minSize, height: minSize)
        
        UIGraphicsBeginImageContextWithOptions(squareSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        let rect = CGRect(origin: .zero, size: squareSize)
        context.addEllipse(in: rect)
        context.clip()
        
        draw(in: rect)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    // MARK: - 图片压缩
    
    /// 压缩图片
    /// - Parameter maxSize: 最大文件大小（字节）
    /// - Returns: 压缩后的图片数据
    func compress(maxSize: Int) -> Data? {
        var compression: CGFloat = 1.0
        var imageData = jpegData(compressionQuality: compression)
        
        while let data = imageData, data.count > maxSize && compression > 0.1 {
            compression -= 0.1
            imageData = jpegData(compressionQuality: compression)
        }
        
        return imageData
    }
    
    /// 压缩图片到指定质量
    /// - Parameter quality: 质量（0.0-1.0）
    /// - Returns: 压缩后的图片数据
    func compress(quality: CGFloat) -> Data? {
        return jpegData(compressionQuality: quality)
    }
    
    // MARK: - 图片旋转
    
    /// 旋转图片
    /// - Parameter degrees: 角度
    /// - Returns: 旋转后的图片
    func rotate(degrees: CGFloat) -> UIImage? {
        let radians = degrees * .pi / 180
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: radians))
            .integral.size
        
        UIGraphicsBeginImageContextWithOptions(rotatedSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        context.rotate(by: radians)
        draw(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    // MARK: - 图片效果
    
    /// 添加圆角
    /// - Parameter radius: 圆角半径
    /// - Returns: 带圆角的图片
    func rounded(radius: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let rect = CGRect(origin: .zero, size: size)
        
        context.addPath(UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath)
        context.clip()
        
        draw(in: rect)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// 添加边框
    /// - Parameters:
    ///   - width: 边框宽度
    ///   - color: 边框颜色
    /// - Returns: 带边框的图片
    func addBorder(width: CGFloat, color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let rect = CGRect(origin: .zero, size: size)
        
        draw(in: rect)
        
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(width)
        context.stroke(rect)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// 转换为灰度图片
    /// - Returns: 灰度图片
    func toGrayscale() -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = cgImage.width
        let height = cgImage.height
        let bitsPerComponent = 8
        let bytesPerPixel = 1
        let bytesPerRow = bytesPerPixel * width
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        
        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: bitmapInfo.rawValue
        ) else { return nil }
        
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        guard let grayImage = context.makeImage() else { return nil }
        
        return UIImage(cgImage: grayImage)
    }
}

