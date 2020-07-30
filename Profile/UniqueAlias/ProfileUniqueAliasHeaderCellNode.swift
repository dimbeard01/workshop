//
//  ProfileUniqueAliasHeaderCellNode.swift
//  Alerts
//
//  Created by Dima on 22.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class ProfileUniqueAliasHeaderCellNode: ASDisplayNode {
    
    // MARK: - Properties
    
    private let titleNode = ASTextNode()
    private let descriptionTitleNode = ASTextNode()
    
    private let uniqueAliasIconNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 73,
                                          height: 73)
        node.contentMode = .scaleAspectFit
        return node
    }()
    
    private let uniqueAliasBackgroundNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: UIScreen.main.bounds.width,
                                          height: 187.5)
        node.contentMode = .scaleAspectFit
        return node
    }()
    
    // MARK: - Init
    
    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        updateTitle()
        updateDescriptionTitle()
        updateImage()
    }
    
    // MARK: - Layout
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeVerticalInsetSpec() -> ASStackLayoutSpec {
            let titleInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: titleNode)
            let descriptionTitleInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: descriptionTitleNode)
            let uniqueAliasIconInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: uniqueAliasIconNode)
            
            var children = [ASLayoutElement]()
            children.append(uniqueAliasIconInsetSpec)
            children.append(titleInsetSpec)
            children.append(descriptionTitleInsetSpec)
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 16
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            
            return vStack
        }
        
        func makeMainWrapperBackgroundInsetSpec() -> ASBackgroundLayoutSpec {
            let childInsetSpec = ASInsetLayoutSpec(
                insets: .init(top: 66,
                              left: 24,
                              bottom: .zero,
                              right: 24),
                child: makeVerticalInsetSpec())
            
            let backgroundInsetsSpec = ASInsetLayoutSpec(
                           insets: .init(top:0,
                                         left: 0,
                                         bottom: 66,
                                         right: 0),
                           child: uniqueAliasBackgroundNode)
            
            return ASBackgroundLayoutSpec(child: childInsetSpec, background: backgroundInsetsSpec)
        }
        
        return ASInsetLayoutSpec(insets: .init(top: 0,
        left: 24,
        bottom: 0,
        right: 24), child: makeVerticalInsetSpec())
    }
    
    // MARK: - Helpers
    
    private func updateTitle() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.primary2)
                .font(Styles.Fonts.Headline1)
                .alignment(.center)
        }
        titleNode.attributedText = NSAttributedString(string: "Уникальный псевдоним", attributes: attributes.dictionary)
    }
    
    private func updateDescriptionTitle() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.primary2)
                .font(Styles.Fonts.Subhead2)
                .alignment(.center)
        }
        descriptionTitleNode.attributedText = NSAttributedString(string: "Текст про уникальный псевдоним.Текст про уникальный псевдоним.Текст про уникальный псевдоним.", attributes: attributes.dictionary)
    }
    
    private func updateImage() {
        uniqueAliasIconNode.image = Styles.Images.premiumAliasIcon
        uniqueAliasBackgroundNode.image = Styles.Images.premiumBackgroundImage
    }
}
