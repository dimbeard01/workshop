
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

extension UIEdgeInsets {
    func inverted() -> UIEdgeInsets {
        return UIEdgeInsets(top: -top,
                            left: -left,
                            bottom: -bottom,
                            right: -right)
    }
}

