//
//  UIButtonHitTestInset.swift
//  Alerts
//
//  Created by Dima on 09.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

class UIButtonHitTestInset: UIButton {
    var hitTestInset: UIEdgeInsets?
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let extendedEdges = hitTestInset {
            let hitFrame = CGRect(x: bounds.minX  - extendedEdges.left, y: bounds.minY - extendedEdges.top, width: bounds.width + extendedEdges.left + extendedEdges.right, height: bounds.height + extendedEdges.top + extendedEdges.bottom)
            return hitFrame.contains(point)
        } else {
            return super.point(inside: point, with: event)
        }
    }
}
