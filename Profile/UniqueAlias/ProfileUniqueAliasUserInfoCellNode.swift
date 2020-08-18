//
//  ProfileUniqueAliasUserInfoCellNode.swift
//  Alerts
//
//  Created by Dima on 04.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class ProfileUniqueAliasUserInfoCellNode: ASCellNode {
    
    // MARK: - Properties
    
    private var model: UniqueAliasUserModel
    private let userNickname = ASTextNode()
    private let subscriptionPriceNode = ASTextNode()
    private let activeSubscriptionNode = ASTextNode()
    
    private let userPhotoNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 48,
                                          height: 48)
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    private let uniqueAliasIconNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 20,
                                          height: 20)
        node.contentMode = .scaleAspectFit
        return node
    }()
    
    private lazy var subscribingButtonNode: BaseNodeViewBox<BaseTextButton> = {
        let boxNode = BaseNodeViewBox<BaseTextButton> { () -> UIView in
            let button = BaseTextButton()
                .setTitle(title: "Оформить подписку".uppercased())
                .setTitleFont(font: Styles.Fonts.Tagline2)
                .setTextColor(color: Styles.Colors.Palette.white)
            //button.action = self.onActivate
            button.insets = .zero
            return button
        }
        boxNode.style.preferredSize = CGSize(width: UIScreen.main.bounds.width * 0.94,
                                             height: 44)
        return boxNode
    }()
        
    // MARK: - Init
    
    init(model: UniqueAliasUserModel) {
        self.model = model
        super.init()
        
        automaticallyManagesSubnodes = true
        updateTitle()
        updateImage()
        updatePrice()
        updateActiveSubscriptionInfo()
        
        ThemeManager.add(self)
    }
    
    // MARK: - Life cycle
    
    override func layoutDidFinish() {
        super.layoutDidFinish()
        
        userPhotoNode.cornerRadius = userPhotoNode.style.height.value / 2
        updateActiveButtonColor()
    }
    
    // MARK: - Layout

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeHorizontalInsetSpec() -> ASStackLayoutSpec {
            let userPhotoInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: userPhotoNode)
            let userNickNameInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: userNickname)
            
            var children = [ASLayoutElement]()
            children.append(userPhotoInsetSpec)
            children.append(userNickNameInsetSpec)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = 16
            hStack.justifyContent = .center
            hStack.alignItems = .center
            hStack.children = children
            
            return hStack
        }
        
        func makeMainHorizontalInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(makeHorizontalInsetSpec())
            children.append(uniqueAliasIconNode)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = 7
            hStack.justifyContent = .center
            hStack.alignItems = .center
            hStack.children = children
            
            return hStack
        }
        
        func makeVerticalInsetSpec() -> ASStackLayoutSpec {
            let priceInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: subscriptionPriceNode)
            let buttonInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: subscribingButtonNode)

            var children = [ASLayoutElement]()
            children.append(priceInsetSpec)
            children.append(buttonInsetSpec)

            if model.state {
                children.append(activeSubscriptionNode)
            }
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 16
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            
            return vStack
        }
        
        func makeMainVerticalInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(makeMainHorizontalInsetSpec())
            children.append(makeVerticalInsetSpec())
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 24
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            
            return vStack
        }
    
        return ASInsetLayoutSpec(insets: .zero, child: makeMainVerticalInsetSpec())
    }
    
    // MARK: - Helpers
    
    private func updateTitle() {
        let attributes = Attributes {
            return $0.foreground(color: titleColor)
                .font(Styles.Fonts.Headline1)
                .lineBreakMode(.byTruncatingTail)
                .alignment(.left)
        }
        userNickname.attributedText = NSAttributedString(string: model.userName, attributes: attributes.dictionary)
    }
    
    private func updateImage() {
        userPhotoNode.image = model.userPhoto
        uniqueAliasIconNode.image = Styles.Images.premiumAliasIcon
    }
    
    private func updatePrice() {
           let attributes = Attributes {
               return $0.foreground(color: Styles.Colors.Palette.primary2)
                   .font(Styles.Fonts.Subhead2)
                   .alignment(.center)
           }
           guard let price = String(199).asDecimalPrice else  { return }
           subscriptionPriceNode.attributedText = NSAttributedString(string: "\(price) / в месяц", attributes: attributes.dictionary)
       }
    
    private func updateActiveSubscriptionInfo() {
           let attributes = Attributes {
               return $0.foreground(color: titleColor)
                   .font(Styles.Fonts.Tagline3)
                   .alignment(.center)
           }
           activeSubscriptionNode.attributedText = NSAttributedString(string: "У вас уже есть активная подписка Anonym Premium", attributes: attributes.dictionary)
       }
    
    private func updateActiveButtonColor() {
        let gradientColors = Styles.Colors.Gradients.addButtonGradientColors
        let startPoint = CGPoint(x: 0, y: 1)
        let endPoint = CGPoint(x: 1, y: 0)
        
        if model.state {
            subscribingButtonNode.alpha = 0.5
            subscribingButtonNode.view.isUserInteractionEnabled = false
        } else {
            subscribingButtonNode.alpha = 1
        }
        subscribingButtonNode.addGradient(colors: gradientColors, locations: [0, 1], startPoint: startPoint, endPoint: endPoint)
        subscribingButtonNode.cornerRadius = Styles.Sizes.cornerRadiusLarge
    }
}

    // MARK: - Themable

extension ProfileUniqueAliasUserInfoCellNode: Themeable {
    func updateTheme() {
        backgroundColor = .clear
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
