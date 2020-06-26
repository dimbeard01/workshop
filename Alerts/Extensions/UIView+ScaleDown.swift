//
//  UIView+ScaleDown.swift
//  Alerts
//
//  Created by Dima on 26.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

extension UIView {
    func scaleDown(_ active: Bool = true, scale: CGFloat = 0.95, alpha: CGFloat = 0.8) {
        let _isScale = (self.layer.transform.m11 == CATransform3DMakeScale(scale, scale, scale).m11)
        guard active != _isScale else { return }
        
        UIView.animate(withDuration: Styles.Constants.animationDurationSmall) {
            if active {
                self.layer.transform = CATransform3DMakeScale(scale, scale, scale)
                self.alpha = alpha
            } else {
                self.layer.transform = CATransform3DMakeScale(1, 1, 1)
                self.alpha = 1
            }
        }
    }
}
