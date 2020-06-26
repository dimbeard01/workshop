//
//  UIView+SetCornerRadius.swift
//  Alerts
//
//  Created by Dima on 25.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

extension UIView {
    func setCornerRadius(radius: CGFloat){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
}
