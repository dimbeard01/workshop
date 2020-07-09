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
  
    // MARK: - Properties

    var onTapAction: (() -> Void)?
    var onTapInAction: (() -> Void)?

    private lazy var activateBoostButtonNode: BaseNodeViewBox<BaseTextButton> = {
        let boxNode = BaseNodeViewBox<BaseTextButton> { () -> UIView in
            let button = BaseTextButton()
                .setTitle(title: "Активировать".uppercased())
                .setTitleFont(font: Styles.Fonts.Tagline2)
                .setTextColor(color: Styles.Colors.Palette.white)
            button.action = self.onTapAction
            button.insets = .zero
            return button
        }
        
        boxNode.style.preferredSize = CGSize(
            width: UIScreen.main.bounds.width * 0.94, // find a way to change to .infinity
            height: Styles.Sizes.buttonSmall
        )
        return boxNode
    }()
    
    private lazy var inActivateBoostButtonNode: BaseNodeViewBox<BaseTextButton> = {
        let boxNode = BaseNodeViewBox<BaseTextButton> { () -> UIView in
            let button = BaseTextButton()
                .setTitle(title: "Деактивировать".uppercased())
                .setTitleFont(font: Styles.Fonts.Tagline2)
                .setTextColor(color: Styles.Colors.Palette.white)
            button.action = self.onTapInAction
            button.insets = .zero
            return button
        }
        
        boxNode.style.preferredSize = CGSize(
            width: UIScreen.main.bounds.width * 0.94, // find a way to change to .infinity
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
    
    private let wrapperNode = ASDisplayNode()
    
    // MARK: - Init

    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        updateTitle()
        updateDescription()
        updateImages()
        
        ThemeManager.add(self)
    }
    
    // MARK: - Layout

    override func layoutDidFinish() {
        super.layoutDidFinish()
        
        updateActiveButtonColor()
        wrapperNode.cornerRadius = Styles.Sizes.cornerRadiusMedium
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeHorizontalInfoSpec() -> ASStackLayoutSpec {
            let infoTitleInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: infoTitleNode)

            var children = [ASLayoutElement]()
            children.append(arrowImageNode)
            children.append(infoTitleInsetSpec)

            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = Styles.Sizes.HPaddingMedium
            hStack.justifyContent = .center
            hStack.alignItems = .center
            hStack.children = children

            return hStack
        }
        
        func makeVerticalInfoSpec() -> ASInsetLayoutSpec {
            let hInfoStack = makeHorizontalInfoSpec()
            
            let infoDescriptionInsetSpec = ASInsetLayoutSpec(insets: .zero, child: infoDescriptionNode)
            
            var children = [ASLayoutElement]()
            children.append(hInfoStack)
            children.append(infoDescriptionInsetSpec)
            children.append(activateBoostButtonNode)
            children.append(inActivateBoostButtonNode)

            let vInfoStack = ASStackLayoutSpec.vertical()
            vInfoStack.spacing = Styles.Sizes.VPaddingMedium
            vInfoStack.alignItems = .center
            vInfoStack.justifyContent = .center
            vInfoStack.children = children
            
            let insets = UIEdgeInsets(
                top: Styles.Sizes.VPaddingMedium + Styles.Sizes.VPaddingBase,
                left: Styles.Sizes.HPaddingMedium + Styles.Sizes.HPaddingBase,
                bottom: Styles.Sizes.HPaddingMedium + Styles.Sizes.HPaddingBase,
                right: Styles.Sizes.VPaddingMedium + Styles.Sizes.VPaddingBase
            )
            
            return ASInsetLayoutSpec(insets: insets, child: vInfoStack)
        }
        
        func makeWrapperBackgroundInsetSpec() -> ASBackgroundLayoutSpec {
            let hMainStack = makeVerticalInfoSpec()
            
            let insetSpec = ASInsetLayoutSpec(
                           insets: .init(
                               top: Styles.Sizes.VPaddingMedium,
                               left: Styles.Sizes.HPaddingMedium,
                               bottom: Styles.Sizes.HPaddingMedium,
                               right: Styles.Sizes.VPaddingMedium),
                           child: wrapperNode
                       )
            return ASBackgroundLayoutSpec(child: hMainStack, background: insetSpec)
        }
        
        return ASInsetLayoutSpec(insets: .zero, child: makeWrapperBackgroundInsetSpec())
    }
    
    // MARK: - Helpers
    
    private func updateTitle() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Gradients.findsBoostGradientColors.last!)
                .font(Styles.Fonts.Body1)
                .alignment(.center)
        }
        
        infoTitleNode.attributedText = NSAttributedString(string: "Finds+", attributes: attributes.dictionary)
    }
    
    private func updateDescription() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.gray4)
                .font(Styles.Fonts.Subhead2)
                .alignment(.center)
        }
        
        
        infoDescriptionNode.maximumNumberOfLines = 0
        infoDescriptionNode.attributedText = NSAttributedString(string: "Получи доступ к возможностям Finds+, чтобы встретить новых друзей и в полной мере насладиться общением.", attributes: attributes.dictionary)
    }
    
    private func updateImages() {
        arrowImageNode.image = #imageLiteral(resourceName: "gradientFinds+")
    }
    
    private func updateActiveButtonColor() {
        let gradientColors = Styles.Colors.Gradients.findsBoostGradientColors
        let startPoint = CGPoint(x: 0, y: 1)
        let endPoint = CGPoint(x: 1, y: 0)
        
        activateBoostButtonNode.addGradient(colors: gradientColors, locations: [0, 1], startPoint: startPoint, endPoint: endPoint)
        activateBoostButtonNode.cornerRadius = Styles.Sizes.cornerRadiusLarge
    }
}

    // MARK: - Themeable

extension FindsProfileInactiveBoostNode: Themeable {
    func updateTheme() {
        switch theme {
        case .light:
            wrapperNode.backgroundColor = Styles.Colors.Palette.white
        case .dark:
            wrapperNode.backgroundColor = Styles.Colors.Palette.gray2
        }
    }
}
