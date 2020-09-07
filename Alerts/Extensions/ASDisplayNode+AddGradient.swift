//
//  ASDisplayNode+AddGradient.swift
//  Alerts
//
//  Created by Dima on 06.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//
import AsyncDisplayKit

extension ASDisplayNode {
    @discardableResult
    func addGradient(colors: [UIColor] = [Styles.Colors.Palette.black.withAlphaComponent(0.5),
                                          Styles.Colors.Palette.black.withAlphaComponent(0)],
                     locations: [NSNumber] = [0, 0.33],
                     startPoint: CGPoint = .zero,
                     endPoint: CGPoint = CGPoint(x: 0.0, y: 1.0)) -> CAGradientLayer {
        let gradientLayer: CAGradientLayer
        
        if let layer = self.layer.sublayers?.first(where: { $0 is CAGradientLayer}) as? CAGradientLayer {
            gradientLayer = layer
        } else {
            gradientLayer = CAGradientLayer()
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
        
        gradientLayer.colors = colors.compactMap({ $0.cgColor })
        gradientLayer.locations = locations
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = self.bounds
        
        return gradientLayer
    }
}
