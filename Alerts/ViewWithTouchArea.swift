//	Created by boris on 27.01.2020.
//	Copyright © 2020 Anonym. All rights reserved.

import UIKit

class ViewWithTouchArea: UIView {
    var touchAreaInsets: UIEdgeInsets = UIEdgeInsets(top: Styles.Sizes.VPaddingMedium,
                                                       left: Styles.Sizes.HPaddingMedium,
                                                       bottom: Styles.Sizes.VPaddingMedium,
                                                       right: Styles.Sizes.HPaddingMedium)
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = bounds.inset(by: touchAreaInsets.inverted())
        return rect.contains(point)
        
        //return super.point(inside: point, with: event)
    }
}
