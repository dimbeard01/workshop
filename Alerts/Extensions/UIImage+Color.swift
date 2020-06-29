//
//  UIImage+Color.swift
//  Alerts
//
//  Created by Dima on 29.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

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
