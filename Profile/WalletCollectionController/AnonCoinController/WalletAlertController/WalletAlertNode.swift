//
//  WalletAlertNode.swift
//  Alerts
//
//  Created by Dima on 02.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class WalletAlertNode: ASDisplayNode {
    //MARK: - Properties
    var onDone: (() -> Void)?
    
    private let titleNode = ASTextNode()
    private let paymentAmountNode = ASTextNode()
    private let wrapperNode = ASDisplayNode()
    
    private let paymentCoinImageNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: Styles.Sizes.iconBase,
                                          height: Styles.Sizes.iconBase)
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    private let successPaymentImageNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 104,
                                          height: 104)
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    private lazy var doneButtonNode: BaseNodeViewBox<BaseTextButton> = {
        let boxNode = BaseNodeViewBox<BaseTextButton> { () -> UIView in
            let button = BaseTextButton()
                .setTitle(title: "Готово".uppercased())
                .setTextColor(color: self.buttonTextColor)
                .setButtonColor(color: self.buttonColor)
                .setTitleFont(font: Styles.Fonts.Tagline1)
            button.action = self.onDone
            
            return button
        }
        
        boxNode.style.height = ASDimensionMake(Styles.Sizes.buttonMedium)
        return boxNode
    }()
    
    private var model: Int
    
    // MARK: - Init
    init(model: Int) {
        self.model = model
        super.init()
        
        automaticallyManagesSubnodes = true
        
        updateTitleNode()
        updateDescriptionNode()
        updateImages()
        
        ThemeManager.add(self)
    }
    
    // MARK: - Life cycle
    override func layoutDidFinish() {
        super.layoutDidFinish()

        updateWrapperNode()
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeHStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(paymentAmountNode)
            children.append(paymentCoinImageNode)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = 6
            hStack.justifyContent = .center
            hStack.alignItems = .center
            hStack.children = children
            
            return hStack
        }
        
        func makeVStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(titleNode)
            children.append(makeHStackInsetSpec())
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = Styles.Sizes.VPaddingMedium
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            
            return vStack
        }
        
        func makeMainVStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(successPaymentImageNode)
            children.append(makeVStackInsetSpec())
            children.append(doneButtonNode)
            
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
                    top: .zero,
                    left: Styles.Sizes.HPaddingBase,
                    bottom: Styles.Sizes.VPaddingBase,
                    right: Styles.Sizes.HPaddingBase),
                child: makeMainVStackInsetSpec())
            
            let wrapperInsetSpec = ASInsetLayoutSpec(
                insets: .init(
                    top: successPaymentImageNode.style.height.value / 2,
                    left: .zero,
                    bottom: .zero,
                    right: .zero),
                child: wrapperNode)
            
            return ASBackgroundLayoutSpec(child: mainVStackInsetSpec, background: wrapperInsetSpec)
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
        
        titleNode.attributedText = NSAttributedString(string: "Кошелек пополнен!", attributes: attributes.dictionary)
    }
    
    private func updateDescriptionNode() {
        let attributes = Attributes {
            return $0.foreground(color: descriptionTitleColor)
                .font(Styles.Fonts.Headline1)
                .alignment(.center)
        }
        
        paymentAmountNode.attributedText = NSAttributedString(string: "+\(model)", attributes: attributes.dictionary)
    }
    
    private func updateImages() {
        paymentCoinImageNode.image = Styles.Images.walletPaymentCoinImage
        successPaymentImageNode.image = Styles.Images.walletSuccessPaymentImage
    }
    
    private func updateWrapperNode() {
        wrapperNode.cornerRadius = Styles.Sizes.cornerRadiusBase
        wrapperNode.clipsToBounds = true
    }
    
}

// MARK: - Themeable
extension WalletAlertNode: Themeable {
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
