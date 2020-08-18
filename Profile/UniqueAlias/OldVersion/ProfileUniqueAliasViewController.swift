//
//  ProfileUniqueAliasDisplayNode.swift
//  Alerts
//
//  Created by Dima on 30.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import TinyConstraints

final class ProfileUniqueAliasViewController: UIViewController {
    
    private let premiumViewModel = PremiumAliasPriceCellModel(image: Styles.Images.premiumIcon,
                                                                  title: "Anonym Premium",
                                                                  additionalTitle: "Входит в подписку",
                                                                  priceInfo: 499.0)
    
    private var model: UniqueAliasUserModel
    
    private var anonymPremiumNode: ProfileUniqueAliasPremiumCellNode!
    private var userInfoNode: ProfileUniqueAliasUserInfoNode!
    
    private let aliasHeaderNode = ProfileUniqueAliasHeaderCellNode()
    private let subscriptionPriceNode = ASTextNode()
    private let subscriptionInfoNode = ASTextNode()
    private let activeSubscriptionNode = ASTextNode()
    
    
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
        return boxNode
    }()
    
    private let uniqueAliasBackgroundNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFit
        return node
    }()
    
    init(model: UniqueAliasUserModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
        anonymPremiumNode = ProfileUniqueAliasPremiumCellNode(model: premiumViewModel)
        userInfoNode = ProfileUniqueAliasUserInfoNode(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ThemeManager.add(self)
        
        view.addSubnode(uniqueAliasBackgroundNode)
        view.addSubnode(aliasHeaderNode)
        view.addSubnode(userInfoNode)
        view.addSubnode(subscriptionPriceNode)
        view.addSubnode(subscribingButtonNode)
        view.addSubnode(anonymPremiumNode)
        view.addSubnode(subscriptionInfoNode)
        view.addSubnode(activeSubscriptionNode)
        
        updateBack()
        updatePrice()
        updateInfo()
        updateActiveSubscriptionInfo()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateActiveButtonColor()
    }
    
    // MARK: - Helpers
    
    private func setupViews(){
        
        let width = UIScreen.main.bounds.width
        let backSizeRange = uniqueAliasBackgroundNode.calculateLayoutThatFits(
            ASSizeRange(min: .zero, max: CGSize(width: width, height: CGFloat.infinity))
        )
        
        uniqueAliasBackgroundNode.view.topToSuperview()
        uniqueAliasBackgroundNode.view.leftToSuperview()
        uniqueAliasBackgroundNode.view.rightToSuperview()
        uniqueAliasBackgroundNode.view.height(backSizeRange.size.height)
        
        let headerSizeRange = aliasHeaderNode.calculateLayoutThatFits(
            ASSizeRange(min: .zero, max: CGSize(width: width, height: CGFloat.infinity))
        )
        aliasHeaderNode.view.topToSuperview(offset: 66)
        aliasHeaderNode.view.leftToSuperview()
        aliasHeaderNode.view.rightToSuperview()
        aliasHeaderNode.view.height(headerSizeRange.size.height)
        
        let userInfoSizeRange = userInfoNode.calculateLayoutThatFits(
            ASSizeRange(min: .zero, max: CGSize(width: width, height: CGFloat.infinity))
        )
        userInfoNode.view.topToBottom(of: aliasHeaderNode.view, offset: 32)
        userInfoNode.view.height(userInfoSizeRange.size.height)
        userInfoNode.view.centerXToSuperview()
        
        
        subscriptionPriceNode.view.topToBottom(of: userInfoNode.view, offset: 24)
        subscriptionPriceNode.view.height(22)
        subscriptionPriceNode.view.leftToSuperview()
        subscriptionPriceNode.view.rightToSuperview()
        
        subscribingButtonNode.view.topToBottom(of: subscriptionPriceNode.view, offset: 16)
        subscribingButtonNode.view.height(44)
        subscribingButtonNode.view.leftToSuperview(offset: 12)
        subscribingButtonNode.view.rightToSuperview(offset: -12)
        
        if model.state {
            activeSubscriptionNode.view.topToBottom(of: subscribingButtonNode.view, offset: 16)
            activeSubscriptionNode.view.height(13)
            activeSubscriptionNode.view.leftToSuperview()
            activeSubscriptionNode.view.rightToSuperview()
            
            subscriptionInfoNode.view.topToBottom(of: activeSubscriptionNode.view, offset: 24)
            subscriptionInfoNode.view.height(123)
            subscriptionInfoNode.view.leftToSuperview(offset: 13)
            subscriptionInfoNode.view.rightToSuperview(offset: -19)
        } else {
            let anonymPremiumSizeRange = anonymPremiumNode.calculateLayoutThatFits(
                ASSizeRange(min: .zero, max: CGSize(width: width, height: CGFloat.infinity))
            )
            anonymPremiumNode.view.topToBottom(of: subscribingButtonNode.view, offset: 24)
            anonymPremiumNode.view.leftToSuperview(offset: 12)
            anonymPremiumNode.view.height(anonymPremiumSizeRange.size.height)
            anonymPremiumNode.view.rightToSuperview(offset: -12)
            
            subscriptionInfoNode.view.topToBottom(of: anonymPremiumNode.view, offset: 24)
            subscriptionInfoNode.view.height(123)
            subscriptionInfoNode.view.leftToSuperview(offset: 13)
            subscriptionInfoNode.view.rightToSuperview(offset: -19)
        }
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
    
    private func updateInfo() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.gray5)
                .font(Styles.Fonts.Caption3)
                .alignment(.left)
        }
        
        let attributesLink = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.primary2)
                .font(Styles.Fonts.Caption3)
                .alignment(.left)
        }
        
        subscriptionInfoNode.attributedText =
            NSAttributedString(string: "Подписка автоматически продлевается каждый месяц, начиная со дня начала подписки.\n\nОтменить подписку можно в течении всего активного периода подписки, но не позже чем за 24 часа до продления подписки.\n\nПользуясь услугами Anonym вы принимаете условия ", attributes: attributes.dictionary) +
            NSAttributedString(string: "Пользовательского соглашения", attributes: attributesLink.dictionary) +
            NSAttributedString(string: " и ", attributes: attributes.dictionary) +
            NSAttributedString(string: "Правила пользования", attributes: attributesLink.dictionary)
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
    
    private func updateBack(){
        uniqueAliasBackgroundNode.image = Styles.Images.premiumBackgroundImage
    }
}

extension ProfileUniqueAliasViewController: Themeable {
    func updateTheme() {
        switch theme {
        case .light:
            view.backgroundColor = Styles.Colors.Palette.white0
        case .dark:
            view.backgroundColor = Styles.Colors.Palette.bgDark
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
