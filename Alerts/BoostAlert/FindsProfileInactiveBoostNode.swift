//
//  FindsProfileInactiveBoostNode.swift
//  Alerts
//
//  Created by Dima on 09.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit
import AsyncDisplayKit

final class FindsProfileInactiveBoostNode: ASDisplayNode {
    
    var onTapAction: ((ActionType) -> Void)?
    
    private lazy var activateBoostButtonNode: BaseNodeViewBox<BaseTextButton> = {
        let boxNode = BaseNodeViewBox<BaseTextButton> { () -> UIView in
            let button = BaseTextButton()
                .setTitle(title: "Boost".uppercased())
                .setTitleFont(font: Styles.Fonts.Tagline2)
                .setTextColor(color: Styles.Colors.Palette.white)
            button.insets = .zero
            button.action = { [weak self] in
                
            }
            return button
        }
        
        boxNode.style.preferredSize = CGSize(
            width: 335, // find a way to change to .infinity
            height: Styles.Sizes.buttonSmall
        )
        return boxNode
    }()
    
    private let infoTitleNode = ASTextNode()
    private let infoDescriptionNode = ASTextNode()
    
    private let arrowImageNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(
            width: Styles.Sizes.avatarSmall,
            height: Styles.Sizes.avatarSmall
        )
        return node
    }()
    
    init(boostState: BoostState) {
        super.init()
        
        automaticallyManagesSubnodes = true
        updateTitle()
        updateDescription()
        updateImages()
        
        ThemeManager.add(self)
    }
    
    override func layoutDidFinish() {
        super.layoutDidFinish()
        
        cornerRadius = Styles.Sizes.cornerRadiusMedium
    }
    
//    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
//        func makeHorizontalInfoStack() -> ASStackLayoutSpec {
//            let infoTitleInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: infoTitleNode)
//
//            var children = [ASLayoutElement]()
//            if boostState != .active { children.append(arrowImageNode) }
//            children.append(infoTitleInsetSpec)
//            children.append(infoButtonNode)
//
//            let hStack = ASStackLayoutSpec.horizontal()
//            hStack.spacing = Styles.Sizes.HPaddingMedium
//            hStack.alignItems = .center
//            hStack.children = children
//
//            return hStack
//        }
//    }
    
    func updateTitle() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Gradients.findsBoostGradientColors.last!)
                .font(Styles.Fonts.Body1)
                .alignment(.center)
        }
        
        infoTitleNode.attributedText = NSAttributedString(string: "Finds+", attributes: attributes.dictionary)
    }
    
    func updateDescription() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.gray4)
                .font(Styles.Fonts.Subhead2)
                .alignment(.left)
        }
        
        
        infoDescriptionNode.maximumNumberOfLines = 0
        infoDescriptionNode.attributedText = NSAttributedString(string: "Получи доступ к возможностям Finds+, чтобы встретить новых друзей и в полной мере насладиться общением.", attributes: attributes.dictionary)
    }
    
    func updateImages() {
        arrowImageNode.image = #imageLiteral(resourceName: "finds")
    }
}

extension FindsProfileInactiveBoostNode: Themeable {
    func updateTheme() {
        switch theme {
        case .light:
            backgroundColor = Styles.Colors.Palette.white
        case .dark:
            backgroundColor = Styles.Colors.Palette.gray2
        }
    }
}
