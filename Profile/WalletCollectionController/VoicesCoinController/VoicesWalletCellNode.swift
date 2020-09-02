//
//  VoicesWalletCellNode.swift
//  Alerts
//
//  Created by Dima on 02.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class VoicesWalletCellNode: ASCellNode {
    // MARK: - Properties
    private let wrapperNode_1: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.height = ASDimensionMake(32)
        node.cornerRadius = node.style.height.value / 2
        return node
    }()
    
    private let wrapperNode_2: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width - 24,
                                          height: 32)
        node.cornerRadius = node.style.height.value / 2
        return node
    }()
    
    private let wrapperNode_3: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.height = ASDimensionMake(46)
        node.cornerRadius = 14

        return node
    }()
    
    private let wrapperNode_4: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.preferredSize = CGSize(width: 122,
                                          height: 46)
        node.cornerRadius = 14
        return node
    }()
    
    private let wrapperNode_5: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.height = ASDimensionMake(44)
        node.cornerRadius = 22

        return node
    }()
    
    private let wrapperNode_6: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.height = ASDimensionMake(46)
        node.cornerRadius = 14
        return node
    }()
    
    
    // MARK: - Init
    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
    }
    
    // MARK: - Layout
    override func layoutDidFinish() {
        updateWrapperNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeBackgroundSpec() -> ASBackgroundLayoutSpec {
            let wrapperInsetSpec = ASInsetLayoutSpec(
                insets: .init(
                    top: .zero,
                    left: .zero,
                    bottom: .zero,
                    right: wrapperNode_2.style.width.value / 2),
                child: wrapperNode_1)
            
            return ASBackgroundLayoutSpec(child: wrapperInsetSpec, background: wrapperNode_2)
        }
        
        func makeMainVStakInsetSpec() -> ASStackLayoutSpec {
            let wrapperInsetSpec3 = ASInsetLayoutSpec(
                insets: .init(
                    top: 39,
                    left: .zero,
                    bottom: .zero,
                    right: .zero),
                child: wrapperNode_3)
            
            let wrapperInsetSpec4 = ASInsetLayoutSpec(
                insets: .init(
                    top: 42,
                    left: .zero,
                    bottom: .zero,
                    right: .zero),
                child: wrapperNode_4)
            
            let wrapperInsetSpec5 = ASInsetLayoutSpec(
                insets: .init(
                    top: 25,
                    left: .zero,
                    bottom: .zero,
                    right: .zero),
                child: wrapperNode_5)
            
            let wrapperInsetSpec6 = ASInsetLayoutSpec(
                insets: .init(
                    top: 16,
                    left: .zero,
                    bottom: .zero,
                    right: .zero),
                child: wrapperNode_6)
            
            var children = [ASLayoutElement]()
            children.append(makeBackgroundSpec())
            children.append(wrapperInsetSpec3)
            children.append(wrapperInsetSpec4)
            children.append(wrapperInsetSpec5)
            children.append(wrapperInsetSpec6)
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 0
            vStack.justifyContent = .center
            vStack.alignItems = .start
            vStack.children = children
            
            return vStack
        }
        
        let insets = UIEdgeInsets(
            top: .zero,
            left: Styles.Sizes.HPaddingBase,
            bottom: .zero,
            right: Styles.Sizes.HPaddingBase)
        
        return ASInsetLayoutSpec(insets: insets, child: makeMainVStakInsetSpec())
    }
    
    // MARK: - Helpers
    private func updateWrapperNodes() {
        let startPoint = CGPoint(x: 0, y: 1)
        let endPoint = CGPoint(x: 1, y: 0)
        
        let mutedColors = [UIColor(red: 0.204, green: 0.71, blue: 0.375, alpha: 0.1),
                      UIColor(red: 0.198, green: 0.88, blue: 0.76, alpha: 0.1)]
        
        let brightColors =  [UIColor(red: 0.204, green: 0.71, blue: 0.375, alpha: 0.5),
                        UIColor(red: 0.198, green: 0.88, blue: 0.76, alpha: 0.5)]
        
        [wrapperNode_1, wrapperNode_5].forEach { node in
            node.addGradient(colors: brightColors,
                             locations: [0, 1],
                             startPoint: startPoint,
                             endPoint: endPoint)
            node.clipsToBounds = true
        }
        
        [wrapperNode_2, wrapperNode_3, wrapperNode_4, wrapperNode_6].forEach { node in
            node.addGradient(colors: mutedColors,
                             locations: [0, 1],
                             startPoint: startPoint,
                             endPoint: endPoint)
            node.clipsToBounds = true
        }
    }
}
