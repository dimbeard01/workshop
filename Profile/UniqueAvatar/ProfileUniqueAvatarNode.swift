//
//  ProfileUniqueAvatarNode.swift
//  Alerts
//
//  Created by Dima on 23.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class ProfileUniqueAvatarNode: ASDisplayNode {
    private let circleNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.preferredSize = CGSize(width: 52,
                                          height: 52)
        node.backgroundColor = .red
        
        return node
    }()
    
    private let internalCircleNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.preferredSize = CGSize(width: 28,
                                          height: 28)
        node.backgroundColor = .blue
        
        return node
    }()
    
    private var model: UniqueAvatarCircleNodeModel
    
    init(model: UniqueAvatarCircleNodeModel) {
        self.model = model
        super.init()
        
        automaticallyManagesSubnodes = true
        
        updateCircleNode()
    }
    
    override func layoutDidFinish() {
        super.layoutDidFinish()
        internalCircleNode.cornerRadius = 14
        circleNode.cornerRadius = 26
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeMainWrapperBackgroundInsetSpec() -> ASBackgroundLayoutSpec {
            let circleNodeSpec =  ASInsetLayoutSpec(insets: .zero, child: circleNode)
            let internalCircleNodeSpec =  ASInsetLayoutSpec(
                insets: UIEdgeInsets(
                    top: 12,
                    left: 12,
                    bottom: 12,
                    right: 12),
                child: internalCircleNode)
            
            return ASBackgroundLayoutSpec(child: internalCircleNodeSpec, background: circleNodeSpec)
        }
        
        func makeHorizontalInsetSpec() -> ASStackLayoutSpec {
            let circleNodeSpec =  ASInsetLayoutSpec(insets: .zero, child: circleNode)
            let internalCircleNodeSpec =  ASInsetLayoutSpec(insets: .zero, child: internalCircleNode)
            
            var children = [ASLayoutElement]()
            children.append(makeMainWrapperBackgroundInsetSpec())
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = 16
            hStack.justifyContent = .center
            hStack.alignItems = .center
            hStack.children = children
            
            return hStack
        }
        
        return  makeHorizontalInsetSpec()
    }
    
    private func updateCircleNode() {
        circleNode.backgroundColor = model.circleColor
        internalCircleNode.backgroundColor = model.internalCircleColor
    }
}
