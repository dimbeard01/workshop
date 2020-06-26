//
//  UIEdgeInsets+Inverted.swift
//  Alerts
//
//  Created by Dima on 25.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    func inverted() -> UIEdgeInsets {
        return UIEdgeInsets(top: -top,
                            left: -left,
                            bottom: -bottom,
                            right: -right)
    }
}
