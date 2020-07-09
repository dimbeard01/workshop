//
//  Images+Defaults.swift
//  Alerts
//
//  Created by Dima on 09.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

extension Styles.Images {
    static var defaultAvatarImage: UIImage {
        return getDefaultAvatarImage(ThemeManager.themeStyle)
    }
    
    static func getDefaultAvatarImage(_ theme: ThemeStyle, logoColor: UIColor = Styles.Colors.Palette.gray4) -> UIImage {
        var image = Styles.Images.logoMini
        image = image.imageWithSize(scale: 0.85)
        image = image.imageWithColor(tintColor: logoColor.withAlphaComponent(0.5))
        
        switch theme {
        case .light:
            image = image.imageWithBackgroundColor(color: Styles.Colors.Palette.gray4.withAlphaComponent(0.15))
            
        case .dark:
            image = image.imageWithBackgroundColor(color: Styles.Colors.Palette.gray5.withAlphaComponent(0.15))
        }
        
        return image
    }
}

extension UIImage {
    func imageWithSize(scale: CGFloat) -> UIImage {
        guard scale > 0 else { return self }
        
        let width = self.size.width * scale
        let height = self.size.height * scale
        
        let x = self.size.width/2 - width/2
        let y = self.size.height/2 - height/2
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let rect = CGRect(x: x, y: y, width: width, height: height)
        draw(in: rect)
        
        let resultingImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resultingImage ?? self
    }
    
    func imageWithSize(size: CGSize) -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
//        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
//        draw(in: rect)
//
//        let resultingImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return resultingImage
        
        var scaledImageRect = CGRect.zero
        
        let aspectWidth:CGFloat = size.width / self.size.width
        let aspectHeight:CGFloat = size.height / self.size.height
        let aspectRatio:CGFloat = min(aspectWidth, aspectHeight)
        
        scaledImageRect.size.width = self.size.width * aspectRatio
        scaledImageRect.size.height = self.size.height * aspectRatio
        scaledImageRect.origin.x = (size.width - scaledImageRect.size.width) / 2.0
        scaledImageRect.origin.y = (size.height - scaledImageRect.size.height) / 2.0
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        self.draw(in: scaledImageRect)
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    func imageWithSize(size: CGSize, extraMargin: CGFloat) -> UIImage? {
        guard let image = self.imageWithSize(size: size) else { return nil }
        
        return image.imageWithMargins(extraMargin: extraMargin)
    }
    
    func imageWithSize(size: CGSize, roundedRadius radius: CGFloat) -> UIImage? {
        guard let image = self.imageWithSize(size: size) else { return nil }
        
        return image.imageWithRounded(roundedRadius: radius)
    }
}

private extension UIImage {
    func imageWithRounded(roundedRadius radius: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        if let currentContext = UIGraphicsGetCurrentContext() {
            let rect = CGRect(origin: .zero, size: size)
            currentContext.addPath(UIBezierPath(roundedRect: rect,
                                                byRoundingCorners: .allCorners,
                                                cornerRadii: CGSize(width: radius, height: radius)).cgPath)
            currentContext.clip()
            
            //Don't use CGContextDrawImage, coordinate system origin in UIKit and Core Graphics are vertical oppsite.
            draw(in: rect)
            currentContext.drawPath(using: .fillStroke)
            let roundedCornerImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return roundedCornerImage
        }
        return nil
    }
    
    func imageWithMargins(extraMargin: CGFloat) -> UIImage? {
        let imageSize = CGSize(width: size.width + extraMargin * 2, height: size.height + extraMargin * 2)
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        let drawingRect = CGRect(x: extraMargin, y: extraMargin, width: size.width, height: size.height)
        draw(in: drawingRect)
        
        let resultingImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resultingImage
    }
}

extension UIImage {
    func imageWithBlur(blurAmount: CGFloat) -> UIImage? {
        guard let ciImage = CIImage(image: self) else {
            return nil
        }
        
        let blurFilter = CIFilter(name: "CIGaussianBlur" )
        blurFilter?.setValue(ciImage, forKey: kCIInputImageKey )
        blurFilter?.setValue(blurAmount, forKey: kCIInputRadiusKey )
        
        guard let outputImage = blurFilter?.outputImage else {
            return nil
        }
        
        return UIImage(ciImage: outputImage)
    }
    
    func imageWithBackgroundColor(color: UIColor, opaque: Bool = false) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return self }
        defer { UIGraphicsEndImageContext() }
        
        let rect = CGRect(origin: .zero, size: size)
        ctx.setFillColor(color.cgColor)
        ctx.fill(rect)
        ctx.concatenate(CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height))
        ctx.draw(cgImage!, in: rect)
        
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
    
    func imageWithColor(tintColor: UIColor, opaque: Bool = false) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, opaque, self.scale)
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return self }
        defer { UIGraphicsEndImageContext() }
        
        ctx.translateBy(x: 0, y: size.height)
        ctx.scaleBy(x: 1, y: -1)
        ctx.setBlendMode(.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        ctx.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        ctx.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext() ?? self
        
        return newImage
    }
}
