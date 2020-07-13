//
//  BoostViewController.swift
//  AsyncDK
//
//  Created by Dima on 05.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit
import AsyncDisplayKit

final class BoostViewController: UIViewController {
    
    //let boostNode = FindsFeedBoostNode(boostState: .noFindsPlus)
    let boostNode = FindsFeedInactiveBoostNode()
    let placholderNode = FindsFeedPlaceholderNode(type: .noRequestAndLike)
    
    var onAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Styles.Colors.Palette.gray1
        view.addSubnode(boostNode)
        view.addSubnode(placholderNode)

        let width = UIScreen.main.bounds.width
        let sizeRange = boostNode.calculateLayoutThatFits(
            ASSizeRange(min: .zero, max: CGSize(width: width, height: CGFloat.infinity))
        )
        
        boostNode.view.topToSuperview(view.safeAreaLayoutGuide.topAnchor, offset: 24)
        boostNode.view.centerXToSuperview()
        boostNode.view.height(sizeRange.size.height)
        boostNode.view.width(view.frame.width)
        
        boostNode.onActivate = { [weak self] in
            self?.onAction?()
        }
        
        let placholderSizeRange = placholderNode.calculateLayoutThatFits(
            ASSizeRange(min: .zero, max: CGSize(width: width, height: CGFloat.infinity))
        )
        
        placholderNode.view.topToBottom(of: boostNode.view)
        placholderNode.view.centerXToSuperview()
        placholderNode.view.height(placholderSizeRange.size.height)
        placholderNode.view.width(view.frame.width)
        
        
//        boostNode.onTapAction = { [weak self] action in
//            self?.onAction?()
//        }
    }
}

class BaseNodeViewBox<T: UIView>: ASDisplayNode {
    weak var value : T? {
        return self.view as? T
    }
}
