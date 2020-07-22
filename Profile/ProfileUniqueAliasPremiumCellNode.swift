//
//  ProfileUniqueAliasPremiumCellNode.swift
//  Alerts
//
//  Created by Dima on 20.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//


import AsyncDisplayKit

final class ProfileUniqueAliasPremiumCellNode: ASCellNode {
    
    // MARK: - Properties
    
    var onTapEnded: (() -> Void)?

    private var cellViewModel: PremiumAliasPriceCellViewModel
    private let titleNode = ASTextNode()
    private let additionalTitleNode = ASTextNode()
    private let priceInfoNode = ASTextNode()
    private let infoText = ASTextNode()
    
    private let rubleSymbol: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.positiveFormat = "0.00 ¤"
        formatter.currencySymbol = "\u{20BD}"
        return formatter
    }()
    
    private let premiumImageNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: Styles.Sizes.buttonExtraSmall,
                                          height: Styles.Sizes.buttonExtraSmall)
        node.contentMode = .scaleAspectFit
        return node
    }()
    
    private let premiumArrowIconNode: ASImageNode = {
          let node = ASImageNode()
          node.style.preferredSize = CGSize(width: Styles.Sizes.buttonExtraSmall,
                                            height: Styles.Sizes.buttonExtraSmall)
          node.contentMode = .scaleAspectFit
          return node
      }()
        
    // MARK: - Life cycle
    
    init(model: PremiumAliasPriceCellViewModel) {
        self.cellViewModel = model
        super.init()
        
        automaticallyManagesSubnodes = true
        updateTitle()
        updateAdditionalTitle()
        updateInfo()
        updatePriceInfo()
        updateImage()
        backgroundColor = Styles.Colors.Palette.gray2
    }
    
    override func layoutDidFinish() {
        cornerRadius = Styles.Sizes.cornerRadiusMedium
    }
    
    // MARK: - Layout
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeHorizontalInsetSpec() -> ASStackLayoutSpec {
            let iconInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: premiumImageNode)
            let titleInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: titleNode)
            
            var children = [ASLayoutElement]()
            children.append(iconInsetSpec)
            children.append(titleInsetSpec)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = Styles.Sizes.VPaddingMedium
            hStack.justifyContent = .start
            hStack.alignItems = .center
            hStack.children = children
            
            return hStack
        }
        
        func makeHorizontalPriceInsetSpec() -> ASStackLayoutSpec {
            let priceInfoInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: priceInfoNode)
            let infoInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: infoText)
            
            var children = [ASLayoutElement]()
            children.append(priceInfoInsetSpec)
            children.append(infoInsetSpec)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = Styles.Sizes.HPaddingSmall
            hStack.justifyContent = .start
            hStack.alignItems = .center
            hStack.children = children
            
            return hStack
        }
        
        func makeVerticalInsetSpec() -> ASStackLayoutSpec {
            let additionalTitleInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: additionalTitleNode)
            
            var children = [ASLayoutElement]()
            children.append(makeHorizontalInsetSpec())
            children.append(additionalTitleInsetSpec)
            children.append(makeHorizontalPriceInsetSpec())
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = Styles.Sizes.VPaddingMedium
            vStack.justifyContent = .start
            vStack.alignItems = .start
            vStack.children = children
            
            return vStack
        }
        
        func makeMainHorizontalInsetSpec() -> ASStackLayoutSpec {
            let spacer = ASLayoutSpec()
            spacer.style.flexShrink = 1
            
            var children = [ASLayoutElement]()
            children.append(makeVerticalInsetSpec())
            children.append(spacer)
            children.append(premiumArrowIconNode)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = Styles.Sizes.VPaddingMedium
            hStack.justifyContent = .spaceBetween
            hStack.alignItems = .center
            hStack.children = children
            
            return hStack
        }
        
        let inset = UIEdgeInsets(
            top: Styles.Sizes.VPaddingMedium,
            left: Styles.Sizes.HPaddingBase,
            bottom: Styles.Sizes.VPaddingMedium,
            right: Styles.Sizes.HPaddingBase)
        
        return ASInsetLayoutSpec(insets: inset, child: makeMainHorizontalInsetSpec())
    }
    
    // MARK: - Helpers
    
    private func updateTitle() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.white0)
                .font(Styles.Fonts.Subhead1)
                .alignment(.left)
        }
        titleNode.attributedText = NSAttributedString(string: cellViewModel.title, attributes: attributes.dictionary)
    }
    
    private func updateAdditionalTitle() {
        let attributes = Attributes {
            return $0.foreground(color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
                .font(Font.semibold(11))
                .alignment(.left)
        }
        additionalTitleNode.attributedText = NSAttributedString(string: cellViewModel.additionalTitle.uppercased(), attributes: attributes.dictionary)
    }
    
    private func updatePriceInfo() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.white0)
                .font(Styles.Fonts.Subhead1)
                .alignment(.left)
        }
        guard let priceInfo = rubleSymbol.string(from: NSNumber(value: cellViewModel.priceInfo)) else { return }
        priceInfoNode.attributedText = NSAttributedString(string: "\(priceInfo) ", attributes: attributes.dictionary)
    }
    
    private func updateInfo() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.gray4)
                .font(Font.semibold(11))
                .alignment(.left)
        }
        infoText.attributedText = NSAttributedString(string: "/ в месяц", attributes: attributes.dictionary)
    }

    private func updateImage() {
        premiumImageNode.image = cellViewModel.image
        premiumArrowIconNode.image = Styles.Images.premiumArrowIcon
    }
}



