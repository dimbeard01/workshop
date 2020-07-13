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
    
    //let boostNode = FindsEditProfileBoostNode(boostState: .noFindsPlus)
    let boostNode = FindsProfileInactiveBoostNode()
    
    var onAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        view.addSubnode(boostNode)
        
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
