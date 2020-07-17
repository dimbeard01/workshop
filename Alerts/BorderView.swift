//
//  BorderView.swift
//  Alerts
//
//  Created by Dima on 07.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//
import UIKit
import TinyConstraints

class BorderView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
    
        self.roundCorners(corners: [.topLeft, .topRight], radius: Styles.Sizes.cornerRadiusBase)
    }
}
