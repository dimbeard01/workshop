
import UIKit

class BaseButton: ViewWithTouchArea, BaseButtonActionProtocol {
    enum ButtonStatus {
        case busy
        case normal
        case deactive
    }
    
    var action: (() -> Void)?
    
    var needAnimationTap: Bool = true
    
    private var _startFrame: CGRect = .zero
    
}

extension BaseButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if needAnimationTap {
            scaleDown()
        }
        
        _startFrame = self.frame
        
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if needAnimationTap {
            scaleDown(false)
        }
        
        super.touchesCancelled(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self.superview)
            
            if _startFrame.hitFrame(touchAreaInsets).contains(touchLocation) {
                if needAnimationTap {
                    scaleDown()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + Styles.Constants.animationDurationSmall) { [weak self] in
                        self?.sendAction()
                        self?.scaleDown(false)
                    }
                } else {
                    sendAction()
                }
            }
        }
        
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if needAnimationTap {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self.superview)
                
                if _startFrame.hitFrame(touchAreaInsets).contains(touchLocation) {
                    scaleDown(true)
                } else {
                    scaleDown(false)
                }
            }
        }
        
        super.touchesMoved(touches, with: event)
    }
}
