//
//  WalletErrorAlertNode.swift
//  Alerts
//
//  Created by Dima on 02.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class WalletErrorAlertNode: ASDisplayNode {
    //MARK: - Properties
    var onCancel: (() -> Void)?
    var onRepeat: (() -> Void)?
    
    private let titleNode = ASTextNode()
    private let descriptionNode = ASTextNode()
    private let wrapperNode = ASDisplayNode()
    
    private lazy var repeatButtonNode: BaseNodeViewBox<BaseTextButton> = {
        let boxNode = BaseNodeViewBox<BaseTextButton> { () -> UIView in
            let button = BaseTextButton()
                .setTitle(title: "Повторить".uppercased())
                .setTextColor(color: Styles.Colors.Palette.white)
                .setButtonColor(color: Styles.Colors.Palette.primary1)
                .setTitleFont(font: Styles.Fonts.Tagline1)
            button.action = self.onRepeat
            
            return button
        }
        
        boxNode.style.height = ASDimensionMake(Styles.Sizes.buttonMedium)
        return boxNode
    }()
    
    private lazy var cancelButtonNode: BaseNodeViewBox<BaseTextButton> = {
        let boxNode = BaseNodeViewBox<BaseTextButton> { () -> UIView in
            let button = BaseTextButton()
                .setTitle(title: "Отмена".uppercased())
                .setTextColor(color: self.buttonTextColor)
                .setButtonColor(color: self.buttonColor)
                .setTitleFont(font: Styles.Fonts.Tagline1)
            button.action = self.onCancel
            
            return button
        }
        
        boxNode.style.height = ASDimensionMake(Styles.Sizes.buttonMedium)
        return boxNode
    }()
    
    // MARK: - Init
    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        
        updateTitleNode()
        updateDescriptionNode()
        
        ThemeManager.add(self)
    }
    
    // MARK: - Life cycle
    override func layoutDidFinish() {
        super.layoutDidFinish()

        updateWrapperNode()
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeVStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(titleNode)
            children.append(descriptionNode)
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = Styles.Sizes.VPaddingMedium
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            
            return vStack
        }
        
        func makebuttonVStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(repeatButtonNode)
            children.append(cancelButtonNode)
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = Styles.Sizes.VPaddingMedium
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            
            return vStack
        }
        
        func makeMainVStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(makeVStackInsetSpec())
            children.append(makebuttonVStackInsetSpec())
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 16
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            
            return vStack
        }
        
        func makeMainBackgroundInsetSpec() -> ASBackgroundLayoutSpec {
            let mainVStackInsetSpec = ASInsetLayoutSpec(
                insets: .init(
                    top: Styles.Sizes.VPaddingBase,
                    left: Styles.Sizes.HPaddingBase,
                    bottom: Styles.Sizes.VPaddingBase,
                    right: Styles.Sizes.HPaddingBase),
                child: makeMainVStackInsetSpec())
            
            return ASBackgroundLayoutSpec(child: mainVStackInsetSpec, background: wrapperNode)
        }
        
        let insets = UIEdgeInsets(
            top: .zero,
            left: 24,
            bottom: .zero,
            right: 24)
        
        return ASInsetLayoutSpec(insets: insets, child: makeMainBackgroundInsetSpec())
    }
    
    // MARK: - Helpers
    private func updateTitleNode() {
        let attributes = Attributes {
            return $0.foreground(color: titleColor)
                .font(Styles.Fonts.Body1)
                .alignment(.center)
        }
        
        titleNode.attributedText = NSAttributedString(string: "Произошла ошибка", attributes: attributes.dictionary)
    }
    
    private func updateDescriptionNode() {
        let attributes = Attributes {
            return $0.foreground(color: descriptionTitleColor)
                .font(Styles.Fonts.Subhead1)
                .alignment(.center)
        }
        
        descriptionNode.attributedText = NSAttributedString(string: "При оплате произошла ошибка, попробуйте снова.", attributes: attributes.dictionary)
    }
    
    private func updateWrapperNode() {
        wrapperNode.cornerRadius = Styles.Sizes.cornerRadiusBase
        wrapperNode.clipsToBounds = true
    }
}

// MARK: - Themeable
extension WalletErrorAlertNode: Themeable {
    func updateTheme() {
        switch theme {
        case .light:
            wrapperNode.backgroundColor = Styles.Colors.Palette.white
        case .dark:
            wrapperNode.backgroundColor = Styles.Colors.Palette.gray1
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
    
    var descriptionTitleColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.gray5
        case .dark:
            return Styles.Colors.Palette.gray4
        }
    }
    
    var buttonColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.white0
        case .dark:
            return Styles.Colors.Palette.gray2
        }
    }
    
    var buttonTextColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.gray4
        case .dark:
            return Styles.Colors.Palette.white0
        }
    }
}
