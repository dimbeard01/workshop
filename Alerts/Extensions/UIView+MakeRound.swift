//
//  UIView+MakeRound.swift
//  Alerts
//
//  Created by Dima on 26.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

extension UIView {
    @objc func makeRound(multiplier: CGFloat = 0.5) {
        let height: CGFloat
        
        //if #available(iOS 11.0, *) {
        //  height = self.safeAreaLayoutGuide.layoutFrame.height
        //}
        
        height = self.bounds.size.height
        
        let radius = height * multiplier
        
        setCornerRadius(radius: radius)
    }
}
