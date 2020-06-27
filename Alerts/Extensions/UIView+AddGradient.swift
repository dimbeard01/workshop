//
//  UIView+AddGradient.swift
//  Alerts
//
//  Created by Dima on 27.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

extension UIView {
    @discardableResult
    func addGradient(colors: [UIColor], locations: [NSNumber], startPoint: CGPoint? = nil, endPoint: CGPoint? = nil) -> CAGradientLayer {
        let gradientLayer: CAGradientLayer
        
        if let layer = self.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer = layer
        } else {
            gradientLayer = CAGradientLayer()
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
        
        gradientLayer.colors = colors.compactMap({ $0.cgColor })
        gradientLayer.locations = locations
        
        if let startPoint = startPoint {
            gradientLayer.startPoint = startPoint
        }
        
        if let endPoint = endPoint {
            gradientLayer.endPoint = endPoint
        }
        
        gradientLayer.frame = self.bounds
        return gradientLayer
    }
}
