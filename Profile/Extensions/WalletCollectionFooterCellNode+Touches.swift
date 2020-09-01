//
//  WalletCollectionFooterCellNode+Touches.swift
//  Alerts
//
//  Created by Dima on 01.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

extension WalletFooterCellNode {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touchToContent(touches) {
            
            view.scaleDown()
        }
        
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        view.scaleDown(false)
        
        super.touchesCancelled(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touchToContent(touches) {
            view.scaleDown(true)
        } else {
            view.scaleDown(false)
        }
        
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        func action() {
            onTapEnded?()
            //viewModel?.tapSetting()
        }
        
        if touchToContent(touches) {
            view.scaleDown()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Styles.Constants.animationDurationSmall) { [weak self] in
                action()
                self?.view.scaleDown(false)
            }
        } else {
            view.scaleDown(false)
        }
        
        super.touchesEnded(touches, with: event)
    }
    
    private func touchToContent(_ touches: Set<UITouch>) -> Bool {
        if let touch = touches.first {
            let touchLocation = touch.location(in: view.superview )
            
            return true
        }
        
        return false
    }
}
