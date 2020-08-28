//
//  SubscriptionsTableNodeCell.swift
//  Alerts
//
//  Created by Dima on 28.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class SubscriptionsTableNodeCell: ASCellNode {
    
    //MARK: - Properties
    
    var onDetailed: (() -> Void)?
    
    private let titleNode = ASTextNode()
    private let descriptionNode = ASTextNode()
    private let paymentTitleNode = ASTextNode()
    private let paymentDescriptionNode = ASTextNode()
    private let wrapperNode = ASDisplayNode()
    private let paymentContainerNode = ASDisplayNode()
    
    private let subscriptionImageNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: Styles.Sizes.iconBig,
                                          height: Styles.Sizes.iconBig)
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    private lazy var detailButtonNode: BaseNodeViewBox<BaseIconButton> = {
        let boxNode = BaseNodeViewBox<BaseIconButton> { () -> UIView in
            let button = BaseIconButton()
                .setImage(image: Styles.Images.subscriptionDetailedIcon)
                .setIconColor(color: self.model.colors.first!)
            button.action = self.onDetailed
            return button
        }
        
        boxNode.style.preferredSize = CGSize(width: Styles.Sizes.iconBig,
                                             height: Styles.Sizes.iconBig)
        return boxNode
    }()
    
    private lazy var subscribingButtonNode: BaseNodeViewBox<BaseTextButton> = {
        let boxNode = BaseNodeViewBox<BaseTextButton> { () -> UIView in
            let button = BaseTextButton()
                .setTitle(title: "Подробнее".uppercased())
                .setTitleFont(font: Styles.Fonts.Tagline1)
                .setButtonColor(color: Styles.Colors.Palette.white)
                .setTextColor(color: self.model.colors.first!)
            //button.action = self.onActivate
            
            return button
        }
        
        boxNode.style.preferredSize = CGSize(width: UIScreen.main.bounds.width * 0.94,
                                             height: 44)
        return boxNode
    }()
    
    private var model: Subscriptions
    
    // MARK: - Init
    
    init(model: Subscriptions) {
        self.model = model
        super.init()
        
        automaticallyManagesSubnodes = true
        backgroundColor = .clear
        
        updateTitleNode()
        updateDescriptionNode()
        updatePaymentTitleNode()
        updatePaymentDescriprionNode()
        updateImageNode()
    }
    
    // MARK: - Layout
    
    override func layoutDidFinish() {
        updateWrapperNode()
        updatePaymentContainerNode()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makePaymentVStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(paymentTitleNode)
            children.append(paymentDescriptionNode)
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 3
            vStack.justifyContent = .center
            vStack.alignItems = .start
            vStack.children = children
            vStack.style.flexShrink = 0.1
            return vStack
        }
        
        func makePaymentHStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(makePaymentVStackInsetSpec())
            children.append(detailButtonNode)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = 43
            hStack.justifyContent = .center
            hStack.alignItems = .center
            hStack.children = children
            
            return hStack
        }
        
        func paymentBackgroundLayoutSpec() -> ASBackgroundLayoutSpec {
            let paymentInsetSpec = ASInsetLayoutSpec(
                insets: .init(
                    top: Styles.Sizes.VPaddingMedium,
                    left: Styles.Sizes.HPaddingBase,
                    bottom: Styles.Sizes.VPaddingMedium,
                    right: Styles.Sizes.HPaddingMedium),
                child: makePaymentHStackInsetSpec())
            
            return ASBackgroundLayoutSpec(child: paymentInsetSpec, background: paymentContainerNode)
        }
        
        func makeHStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(subscriptionImageNode)
            children.append(titleNode)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = 8
            hStack.justifyContent = .center
            hStack.alignItems = .center
            hStack.children = children
            
            return hStack
        }
        
        func makeMainVStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(makeHStackInsetSpec())
            children.append(descriptionNode)
            
            switch model {
            case .findsPlus(isActive: true), .premium(isActive: true), .uniqueAlias(isActive: true):
                children.append(paymentBackgroundLayoutSpec())
            default:
                children.append(subscribingButtonNode)
            }
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 11
            vStack.justifyContent = .center
            vStack.alignItems = .start
            vStack.children = children
            
            return vStack
        }
        
        func mainBackgroundLayoutSpec() -> ASBackgroundLayoutSpec {
            let mainVStacInsetSpec = ASInsetLayoutSpec(
                insets: .init(
                    top: Styles.Sizes.VPaddingBase,
                    left: Styles.Sizes.HPaddingBase,
                    bottom: Styles.Sizes.VPaddingBase,
                    right: Styles.Sizes.HPaddingBase),
                child: makeMainVStackInsetSpec())
            
            return ASBackgroundLayoutSpec(child: mainVStacInsetSpec, background: wrapperNode)
        }
        
        let insets = UIEdgeInsets(
            top: Styles.Sizes.VPaddingBase / 2,
            left: Styles.Sizes.HPaddingMedium,
            bottom: Styles.Sizes.VPaddingBase / 2,
            right: Styles.Sizes.HPaddingMedium
        )
        
        return ASInsetLayoutSpec(insets: insets, child: mainBackgroundLayoutSpec())
    }
    
    // MARK: - Helpers
    
    private func updateTitleNode() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.white)
                .font(Styles.Fonts.Headline1)
                .alignment(.left)
        }
        
        titleNode.attributedText = NSAttributedString(string: model.title, attributes: attributes.dictionary)
    }
    
    private func updateDescriptionNode() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.white)
                .font(Styles.Fonts.Subhead1)
                .alignment(.left)
        }
        
        descriptionNode.maximumNumberOfLines = 0
        descriptionNode.attributedText = NSAttributedString(string: model.description, attributes: attributes.dictionary)
    }
    
    private func updatePaymentTitleNode() {
        let attributes = Attributes {
            return $0.foreground(color: model.colors.first!)
                .font(Styles.Fonts.Subhead1)
                .alignment(.left)
        }
        
        paymentTitleNode.attributedText = NSAttributedString(string: "Подписка активна", attributes: attributes.dictionary)
    }
    
    private func updatePaymentDescriprionNode() {
        let attributes = Attributes {
            return $0.foreground(color: model.colors.first!)
                .font(Styles.Fonts.Caption2)
                .alignment(.left)
        }
        
        guard let price = String(model.paymentPrice).asDecimalPrice else  { return }
        
        paymentDescriptionNode.maximumNumberOfLines = 0
        paymentDescriptionNode.attributedText = NSAttributedString(string: "Следующее платеж 24 апреля, спишется \(price)", attributes: attributes.dictionary)
    }
    
    private func updateImageNode() {
        subscriptionImageNode.image = model.icon
    }
    
    private func updateWrapperNode() {
        let startPoint = CGPoint(x: 1, y: 0)
        let endPoint = CGPoint(x: 0, y: 1)
        
        wrapperNode.addGradient(colors: model.colors, locations: [0, 1], startPoint: startPoint, endPoint: endPoint)
        wrapperNode.cornerRadius = Styles.Sizes.cornerRadiusBase
        wrapperNode.clipsToBounds = true
    }
    
    private func updatePaymentContainerNode() {
        paymentContainerNode.backgroundColor = Styles.Colors.Palette.white
        paymentContainerNode.cornerRadius = Styles.Sizes.cornerRadiusMedium
        paymentContainerNode.clipsToBounds = true
    }
}
