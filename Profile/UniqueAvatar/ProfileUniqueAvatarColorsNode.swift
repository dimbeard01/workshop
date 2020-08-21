//
//  ProfileUniqueAvatarColorsNode.swift
//  Alerts
//
//  Created by Dima on 20.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class ProfileUniqueAvatarColorsNode: ASDisplayNode {
    let node1 = ProfileUniqueAvatarNode(model: UniqueAvatarCircleNodeModel(circleColor: Styles.Colors.Palette.avatarPurple1,
                                                                           internalCircleColor: Styles.Colors.Palette.avatarOrange1))
    let node2 = ProfileUniqueAvatarNode(model: UniqueAvatarCircleNodeModel(circleColor: Styles.Colors.Palette.avatarPurple2,
                                                                           internalCircleColor: Styles.Colors.Palette.avatarPink1))
    let node3 = ProfileUniqueAvatarNode(model: UniqueAvatarCircleNodeModel(circleColor: Styles.Colors.Palette.avatarPurple1,
                                                                           internalCircleColor: Styles.Colors.Palette.avatarYellow1))
    let node4 = ProfileUniqueAvatarNode(model: UniqueAvatarCircleNodeModel(circleColor: Styles.Colors.Palette.avatarBlue1,
                                                                           internalCircleColor: Styles.Colors.Palette.avatarGreen1))
    let node5 = ProfileUniqueAvatarNode(model: UniqueAvatarCircleNodeModel(circleColor: Styles.Colors.Palette.avatarPink2,
                                                                           internalCircleColor: Styles.Colors.Palette.avatarOrange1))
    let node6 = ProfileUniqueAvatarNode(model: UniqueAvatarCircleNodeModel(circleColor: Styles.Colors.Palette.avatarGreen2,
                                                                           internalCircleColor: Styles.Colors.Palette.avatarGreen3))
    let node7 = ProfileUniqueAvatarNode(model: UniqueAvatarCircleNodeModel(circleColor: Styles.Colors.Palette.avatarGreen4,
                                                                           internalCircleColor: Styles.Colors.Palette.avatarGreen5))
    
    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeTopHStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(node1)
            children.append(node2)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = 16
            hStack.justifyContent = .center
            hStack.alignItems = .center
            hStack.children = children
            
            return hStack
        }
        
        func makeMiddleHStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(node3)
            children.append(node4)
            children.append(node5)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = 16
            hStack.justifyContent = .center
            hStack.alignItems = .center
            hStack.children = children
            
            return hStack
        }
        
        func makeBottomHStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(node6)
            children.append(node7)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = 16
            hStack.justifyContent = .center
            hStack.alignItems = .center
            hStack.children = children
            
            return hStack
        }
        
        func makeMainVStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(makeTopHStackInsetSpec())
            children.append(makeMiddleHStackInsetSpec())
            children.append(makeBottomHStackInsetSpec())

            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 9
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            
            return vStack
        }
        
        return makeMainVStackInsetSpec()
    }
    
}
