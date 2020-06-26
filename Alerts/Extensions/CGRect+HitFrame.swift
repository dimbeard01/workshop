//
//  CGRect+HitFrame.swift
//  Alerts
//
//  Created by Dima on 25.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

extension CGRect {
    func hitFrame(_ insets: UIEdgeInsets = UIEdgeInsets(top: 10,
                                                        left: 10,
                                                        bottom: 10,
                                                        right: 10)) -> CGRect {
        let extendedEdges = insets
        let hitFrame = CGRect(x: self.minX  - extendedEdges.left, y: self.minY - extendedEdges.top, width: self.width + extendedEdges.left + extendedEdges.right, height: self.height + extendedEdges.top + extendedEdges.bottom)
        return hitFrame
    }
}
