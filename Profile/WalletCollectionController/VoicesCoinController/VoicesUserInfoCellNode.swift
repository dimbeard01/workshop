//
//  VoicesUserInfoCellNode.swift
//  Alerts
//
//  Created by Dima on 02.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class VoicesUserInfoCellNode: ASCellNode {
    // MARK: - Properties
    private let titleNode = ASTextNode()
    private let descriptionNode = ASTextNode()
    
    private let voicesCoinImageNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 72,
                                          height: 72)
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    
    // MARK: - Init
    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        
        updateTitleNode()
        updateAnonCoinCountNode()
        updateAnonCoinImageNode()
        
        ThemeManager.add(self)
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeVStackLayoutSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(titleNode)
            children.append(descriptionNode)
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 0
            vStack.justifyContent = .start
            vStack.alignItems = .start
            vStack.children = children
            
            return vStack
        }
        
        func makeMainHStackLayoutSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            let spacer = ASLayoutSpec()
            spacer.style.flexShrink = 1
            
            children.append(makeVStackLayoutSpec())
            children.append(spacer)
            children.append(voicesCoinImageNode)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = 0
            hStack.justifyContent = .spaceBetween
            hStack.alignItems = .center
            hStack.children = children
            
            return hStack
        }
        
        return makeMainHStackLayoutSpec()
    }
    
    // MARK: - Helpers
    private func updateTitleNode() {
        let attributes = Attributes {
            return $0.foreground(color: titleTextColor)
                .font(Styles.Fonts.Subhead1)
                .alignment(.left)
        }
        
        titleNode.attributedText = NSAttributedString(string: "Voices", attributes: attributes.dictionary)
    }
    
    private func updateAnonCoinCountNode() {
        let attributes = Attributes {
            return $0.foreground(color: countTextColor)
                .font(Styles.Fonts.LargeTitle)
                .alignment(.left)
        }
        
        descriptionNode.attributedText = NSAttributedString(string: "Soon".uppercased(), attributes: attributes.dictionary)
    }
    
    private func updateAnonCoinImageNode() {
        voicesCoinImageNode.image = Styles.Images.voicesCoinImage
    }
}

// MARK: - Themeable
extension VoicesUserInfoCellNode: Themeable {
    func updateTheme() {
        backgroundColor = .clear
    }
    
    var titleTextColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.gray4
        case .dark:
            return Styles.Colors.Palette.gray5
        }
    }
    
    var countTextColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.gray3
        case .dark:
            return Styles.Colors.Palette.white0
        }
    }
}
