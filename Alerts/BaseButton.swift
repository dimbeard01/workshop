//	Created by boris on 05/08/2019.
//	Copyright © 2019 Anonym. All rights reserved.

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
    
    @objc func makeRound(multiplier: CGFloat = 0.5) {
        let height: CGFloat
        
        //if #available(iOS 11.0, *) {
        //  height = self.safeAreaLayoutGuide.layoutFrame.height
        //}
        
        height = self.bounds.size.height
        
        let radius = height * multiplier
        
        setCornerRadius(radius: radius)
    }
    
    func setCornerRadius(radius: CGFloat){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
}

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

extension UIEdgeInsets {
    func inverted() -> UIEdgeInsets {
        return UIEdgeInsets(top: -top,
                            left: -left,
                            bottom: -bottom,
                            right: -right)
    }
}
