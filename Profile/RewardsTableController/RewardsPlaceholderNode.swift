//
//  RewardsPlaceholderNode.swift
//  Alerts
//
//  Created by Dima on 24.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class RewardsPlaceholderNode: ASDisplayNode {
    
    // MARK: - Properties

    private let placeholderImageNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 160,
                                          height: 160)
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    private let placholderTitleNode = ASTextNode()
    private let placholderDescriptionNode = ASTextNode()
    
    // MARK: - Init

    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        updateTitle()
        updateDescription()
        updateImage()
        
        ThemeManager.add(self)
    }
    
    // MARK: - Layout

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeMainHStacInsetSpec() -> ASStackLayoutSpec {
            let imageInsetSpec = ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: 0,
                                     left: 0,
                                     bottom: 11,
                                     right: 0),
                child: placeholderImageNode)
            
            var children = [ASLayoutElement]()
            children.append(imageInsetSpec)
            children.append(placholderTitleNode)
            children.append(placholderDescriptionNode)
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 5
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            
            vStack.style.width = ASDimensionMake(263)
            return vStack
        }
        
        func center() -> ASCenterLayoutSpec {
            return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: makeMainHStacInsetSpec())
        }
        
        return center()
    }
    
    private func updateTitle() {
        let attributes = Attributes {
            return $0.foreground(color: titleColor)
                .font(Styles.Fonts.Body1)
                .alignment(.center)
        }
        
        placholderTitleNode.attributedText = NSAttributedString(string: "Пусто", attributes: attributes.dictionary)
    }
    
    private func updateDescription() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.gray4)
                .font(Styles.Fonts.Caption2)
                .alignment(.center)
        }
        
        placholderDescriptionNode.attributedText = NSAttributedString(string: "Вы еще не получали наград. Создавайте контент и делитесь своими мыслями для получения наград.", attributes: attributes.dictionary)
    }
}

    // MARK: - Themeable

extension RewardsPlaceholderNode: Themeable {
    func updateTheme() {
        switch theme {
        case .light:
            backgroundColor = Styles.Colors.Palette.white0
        case .dark:
            backgroundColor = Styles.Colors.Palette.gray2
        }
    }
    
    func updateImage() {
        switch theme {
        case .light:
            placeholderImageNode.image = Styles.Images.rewardLightPlaceholder
        case .dark:
            placeholderImageNode.image = Styles.Images.rewardDarkPlaceholder
        }
    }
    
    var titleColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.gray3
        case .dark:
            return Styles.Colors.Palette.white0
        }
    }
}
