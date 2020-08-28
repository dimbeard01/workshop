//
//  ProfileUniqueAliasCellNode.swift
//  Alerts
//
//  Created by Dima on 20.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class ProfileUniqueAliasCellNode: ASCellNode {
    
    enum State {
        case noneSelected
        case selected
    }
    
    // MARK: - Properties
    
    var onTapEnded: (() -> Void)?
    
    private var model: AliasPriceCellModel
    
    private let titleNode = ASTextNode()
    private let additionalTitleNode = ASTextNode()
    private let priceInfoNode = ASTextNode()
    private let priceNode = ASTextNode()
    
    var state: State = .noneSelected {
        didSet {
            updateCellState()
        }
    }
    
    // MARK: - Init
    
    init(model: AliasPriceCellModel) {
        self.model = model
        super.init()
        
        automaticallyManagesSubnodes = true
        updateTitle()
        updateAdditionalTitle()
        updatePriceInfo()
        updatePrice()
        ThemeManager.add(self)
    }
    
    // MARK: - Life cycle
    
    override func layoutDidFinish() {
        cornerRadius = Styles.Sizes.cornerRadiusMedium
        handleTapEnded()
    }
    
    // MARK: - Layout
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeMainVerticalInsetSpec() -> ASStackLayoutSpec {
            let titleInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: titleNode)
            let additionalTitleInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: additionalTitleNode)
            let priceInfoInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: priceInfoNode)
            let priceInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: priceNode)
            
            var children = [ASLayoutElement]()
            children.append(titleInsetSpec)
            children.append(additionalTitleInsetSpec)
            children.append(priceInfoInsetSpec)
            children.append(priceInsetSpec)
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = Styles.Sizes.VPaddingMedium
            vStack.justifyContent = .start
            vStack.alignItems = .start
            vStack.children = children
            
            return vStack
        }
        
        let insets = UIEdgeInsets(
            top: Styles.Sizes.VPaddingMedium,
            left: Styles.Sizes.HPaddingBase,
            bottom: Styles.Sizes.VPaddingMedium,
            right: Styles.Sizes.HPaddingBase)
        
        return ASInsetLayoutSpec(insets: insets, child: makeMainVerticalInsetSpec())
    }
    
    // MARK: - Helpers
    
    private func handleTapEnded() {
        onTapEnded = {
            print("tap ended")
        }
    }
    
    private func updateCellState() {
        switch state {
        case .noneSelected:
            backgroundColor = Styles.Colors.Palette.gray2
            borderWidth = 0
        case .selected:
            backgroundColor = .clear
            borderColor = Styles.Colors.Palette.primary2.cgColor
            borderWidth = 2
        }
    }
    
    private func updateTitle() {
        let attributes = Attributes {
            return $0.foreground(color: titleColor)
                .font(Styles.Fonts.Caption1)
                .alignment(.left)
        }
        titleNode.attributedText = NSAttributedString(string: model.title, attributes: attributes.dictionary)
    }
    
    private func updateAdditionalTitle() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.primary2)
                .font(Styles.Fonts.Tagline3)
                .alignment(.left)
        }
        additionalTitleNode.attributedText = NSAttributedString(string: model.additionalTitle.uppercased(), attributes: attributes.dictionary)
    }
    
    private func updatePriceInfo() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.gray4)
                .font(Styles.Fonts.Tagline3)
                .alignment(.left)
        }
        guard let price = String(model.priceInfo).asDecimalPrice else  { return }
        priceInfoNode.attributedText = NSAttributedString(string: "\(price)/ в месяц", attributes: attributes.dictionary)
    }
    
    private func updatePrice() {
        let attributes = Attributes {
            return $0.foreground(color: priceColor)
                .font(Styles.Fonts.Subhead1)
                .alignment(.left)
        }
        guard let price = String(model.price).asDecimalPrice else  { return }
        priceNode.attributedText = NSAttributedString(string: price, attributes: attributes.dictionary)
    }
}

    // MARK: - Themeable

extension ProfileUniqueAliasCellNode: Themeable {
    func updateTheme() {
        switch theme {
        case .light:
            backgroundColor = Styles.Colors.Palette.white0
        case .dark:
            backgroundColor = Styles.Colors.Palette.gray2
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
    
    var priceColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.gray3
        case .dark:
            return Styles.Colors.Palette.white0
        }
    }
}
