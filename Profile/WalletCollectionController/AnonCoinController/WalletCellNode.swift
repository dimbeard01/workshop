//
//  WalletCellNode.swift
//  Alerts
//
//  Created by Dima on 31.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class WalletCellNode: ASCellNode {
    // MARK: - Properties
    var onTapEnded: (() -> Void)?
    
    private let anonCoinsPriceNode = ASTextNode()
    private let anonCoinsAmountNode = ASTextNode()
    private let backlightImageNode = ASImageNode()
    
    private let anonCoinsImageNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 96,
                                          height: 96)
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    private let cellWrapperNode = ASDisplayNode()
    private let priceWrapperNode = ASDisplayNode()
    private let model: AnonCoins
    
    // MARK: - Init
    init(model: AnonCoins) {
        self.model = model
        super.init()
        
        automaticallyManagesSubnodes = true
        
        updatePriceNode()
        updateAmountNode()
        updateAnonCoinsImageNode()
        
        ThemeManager.add(self)
    }
    
    // MARK: - Life cycle
    override func layoutDidFinish() {
        super.layoutDidFinish()

        updateCellWrapperNode()
        updateBacklightImageNode()
        updatePriceWrapperBackgroundColor()
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makePriceBackgroundLayoutSpec() -> ASBackgroundLayoutSpec {
            let priceInsetSpec = ASInsetLayoutSpec(
                insets: .init(
                    top: 5.5,
                    left: Styles.Sizes.HPaddingMedium,
                    bottom: 5.5,
                    right: Styles.Sizes.HPaddingMedium),
                child: anonCoinsPriceNode)
            
            return ASBackgroundLayoutSpec(child: priceInsetSpec, background: priceWrapperNode)
        }
        
        func makeVStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(makePriceBackgroundLayoutSpec())
            children.append(anonCoinsAmountNode)
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = Styles.Sizes.VPaddingMedium
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            
            return vStack
        }
        
        func makeMainVStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(anonCoinsImageNode)
            children.append(makeVStackInsetSpec())
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 0
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            
            return vStack
        }
        
        func makeBacklightBackgroundLayoutSpec() -> ASBackgroundLayoutSpec {
            return ASBackgroundLayoutSpec(child: backlightImageNode, background: cellWrapperNode)
        }
        
        func makeMainBackgroundInsetSpec() -> ASBackgroundLayoutSpec {
            let mainWrapperInsetSpec = ASInsetLayoutSpec(
                insets: .init(
                    top: anonCoinsImageNode.style.height.value / 2,
                    left: .zero,
                    bottom: .zero,
                    right: .zero),
                child: makeBacklightBackgroundLayoutSpec())
            
            let mainVStackInsetSpec = ASInsetLayoutSpec(
                insets: .init(
                    top: .zero,
                    left: Styles.Sizes.HPaddingMedium,
                    bottom: Styles.Sizes.VPaddingMedium,
                    right: Styles.Sizes.HPaddingMedium),
                child: makeMainVStackInsetSpec())

            return ASBackgroundLayoutSpec(child: mainVStackInsetSpec, background: mainWrapperInsetSpec)
        }
        
        return makeMainBackgroundInsetSpec()
    }
    
    // MARK: - Helpers
    private func updatePriceNode() {
        let attributes = Attributes {
            return $0.foreground(color: priceTextColor)
                .font(Styles.Fonts.Tagline3)
                .alignment(.center)
        }
        
        guard let price = String(model.price).asDecimalPrice else  { return }
        anonCoinsPriceNode.attributedText = NSAttributedString(string: "\(price)", attributes: attributes.dictionary)
    }
    
    private func updateAmountNode() {
        let attributes = Attributes {
            return $0.foreground(color: amountTextColor)
                .font(Styles.Fonts.Subhead1)
                .alignment(.center)
        }
        
        anonCoinsAmountNode.attributedText = NSAttributedString(string: "\(model.amount) Монет", attributes: attributes.dictionary)
    }
    
    private func updatePriceWrapperBackgroundColor() {
        priceWrapperNode.backgroundColor = priceWrapperBacgroundColor
        priceWrapperNode.cornerRadius = 12
        priceWrapperNode.clipsToBounds = true
    }
    
    private func updateCellWrapperNode() {
        cellWrapperNode.cornerRadius = Styles.Sizes.cornerRadiusMedium
        cellWrapperNode.clipsToBounds = true
    }
    
    private func updateBacklightImageNode() {
        backlightImageNode.image = backlightImage
        backlightImageNode.cornerRadius = Styles.Sizes.cornerRadiusMedium
        backlightImageNode.clipsToBounds = true
    }
    
    private func updateAnonCoinsImageNode() {
        anonCoinsImageNode.image = model.image
    }
}

//MARK: - Themeable
extension WalletCellNode: Themeable {
    func updateTheme() {
        switch theme {
        case .light:
            cellWrapperNode.backgroundColor = Styles.Colors.Palette.white0
        case .dark:
            cellWrapperNode.backgroundColor = Styles.Colors.Palette.gray2
        }
    }
    
    var backlightImage: UIImage {
        switch theme {
        case .light:
            return Styles.Images.walletCellBacklightLight
        case .dark:
            return Styles.Images.walletCellBacklightDark
        }
    }
    
    var priceTextColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.gray4
        case .dark:
            return Styles.Colors.Palette.white0
        }
    }
    
    var amountTextColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.gray3
        case .dark:
            return Styles.Colors.Palette.white0
        }
    }
    
    var priceWrapperBacgroundColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.white
        case .dark:
            return Styles.Colors.Palette.gray3
        }
    }
}
