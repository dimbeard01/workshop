//
//  FindsFeedPlaceholderNode.swift
//  Alerts
//
//  Created by Dima on 13.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

enum PlaceholderType {
    case noSuggestion
    case noRequestAndLike
}

final class FindsFeedPlaceholderNode: ASDisplayNode {
    
    // MARK: - Properties
    
    private let doubleIconImageNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(
            width: 64,
            height: 64
        )
        return node
    }()
    
    private let infoTitleNode = ASTextNode()
    private let infoDescriptionNode = ASTextNode()
    private let type: PlaceholderType
    
    // MARK: - Init
    
    init(type: PlaceholderType) {
        self.type = type
        super.init()
        
        automaticallyManagesSubnodes = true
        updateTitle()
        updateDescription()
        updateImages()
    }
    
    // MARK: - Layout
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeVerticalInfoSpec() -> ASStackLayoutSpec {
            let infoTitleInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: infoTitleNode)
            let infoDescriptionInsetSpec = ASInsetLayoutSpec(insets: .zero, child: infoDescriptionNode)
            
            var children = [ASLayoutElement]()
            children.append(infoTitleInsetSpec)
            children.append(infoDescriptionInsetSpec)
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = Styles.Sizes.VPaddingSmall
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            
            return vStack
        }
        
        func makeMainVerticalInfoSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(doubleIconImageNode)
            children.append(makeVerticalInfoSpec())
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 16
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            
            return vStack
        }
        
        let insets = UIEdgeInsets(
            top: Styles.Sizes.VPaddingBase,
            left: Styles.Sizes.HPaddingBase * 3,
            bottom: Styles.Sizes.VPaddingBase,
            right: Styles.Sizes.HPaddingBase * 3
        )
        
        return ASInsetLayoutSpec(insets:insets, child: makeMainVerticalInfoSpec())
    }
    
    // MARK: - Helpers
    
    private func updateTitle() {
        var textTitle: String {
            switch type {
            case .noSuggestion:
                return "У вас еще не было совпадений"
            case .noRequestAndLike:
                return "У вас еще не было запросов или лайков"
            }
        }
        
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.gray4)
                .font(Styles.Fonts.Subhead1)
                .alignment(.center)
        }
        infoTitleNode.attributedText = NSAttributedString(string: textTitle, attributes: attributes.dictionary)
    }
    
    private func updateDescription() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.gray4)
                .font(Styles.Fonts.Caption2)
                .alignment(.center)
        }
        infoDescriptionNode.maximumNumberOfLines = 0
        infoDescriptionNode.attributedText = NSAttributedString(string: "Но не стоит унывать, попробуй поставить лайк", attributes: attributes.dictionary)
    }
    
    private func updateImages() {
        var image: UIImage {
            switch type {
            case .noSuggestion:
                return #imageLiteral(resourceName: "doubleStar")
            case .noRequestAndLike:
                return #imageLiteral(resourceName: "double")
            }
        }
        doubleIconImageNode.image = image
    }
}
