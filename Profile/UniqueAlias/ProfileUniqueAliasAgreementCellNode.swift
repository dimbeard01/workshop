//
//  ProfileUniqueAliasAgreementCellNode.swift
//  Alerts
//
//  Created by Dima on 04.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class ProfileUniqueAliasAgreementCellNode: ASCellNode {
    
    // MARK: - Properties

    private let subscriptionInfoNode = ASTextNode()
    private let unsubscribingInfoNode = ASTextNode()
    private let agreementInfoNode = ASTextNode()
    
    // MARK: - Init

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        updateInfo()
    }
    
    // MARK: - Layout

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeVerticalInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(subscriptionInfoNode)
            children.append(unsubscribingInfoNode)
            children.append(agreementInfoNode)
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 16
            vStack.justifyContent = .start
            vStack.alignItems = .start
            vStack.children = children
            
            return vStack
        }
        return ASInsetLayoutSpec(insets: .zero, child: makeVerticalInsetSpec())
    }
    
    // MARK: - Helpers

    private func updateInfo() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.gray5)
                .font(Styles.Fonts.Caption3)
                .alignment(.left)
        }
        
        let attributeRulesLink = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.primary2)
                .font(Styles.Fonts.Caption3)
                .alignment(.left)
        }
        
        let attributeAgreementLink = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.primary2)
                .font(Styles.Fonts.Caption3)
                .alignment(.left)
        }
        
        subscriptionInfoNode.attributedText = NSAttributedString(string: "Подписка автоматически продлевается каждый месяц, начиная со дня начала подписки.", attributes: attributes.dictionary)
        
        unsubscribingInfoNode.attributedText = NSAttributedString(string: "Отменить подписку можно в течении всего активного периода подписки, но не позже чем за 24 часа до продления подписки.", attributes: attributes.dictionary)
        
        agreementInfoNode.attributedText =
            NSAttributedString(string: "Пользуясь услугами Anonym вы принимаете условия ", attributes: attributes.dictionary) +
            NSAttributedString(string: "Пользовательского соглашения", attributes: attributeAgreementLink.dictionary) +
            NSAttributedString(string: " и ", attributes: attributes.dictionary) +
            NSAttributedString(string: "Правила пользования", attributes: attributeRulesLink.dictionary)
    }
}
