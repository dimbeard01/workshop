//
//  AwardLevelsAlertNode.swift
//  Alerts
//
//  Created by Dima on 04.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

enum AwardLevelsAlertModel: Int, CaseIterable {
    case level_2 = 2, level_3, level_4, level_5, level_6, level_7, level_8
    
    var backgroundImage: UIImage? {
        switch self {
        case .level_4:
            return Styles.Images.backLevelImage_4
        case .level_5:
            return Styles.Images.backLevelImage_5
        case .level_6:
            return Styles.Images.backLevelImage_6
        case .level_7:
            return Styles.Images.backLevelImage_7
        case .level_8:
            return Styles.Images.backLevelImage_8
        default:
            return nil
        }
    }
    
    var title: String {
        return "\(self.rawValue)"
    }
    
    var colors: [UIColor] {
        switch self {
        case .level_4:
            return Styles.Colors.Gradients.levelColors_4
        case .level_5:
            return Styles.Colors.Gradients.levelColors_5
        case .level_6:
            return Styles.Colors.Gradients.levelColors_6
        case .level_7:
            return Styles.Colors.Gradients.levelColors_7
        case .level_8:
            return Styles.Colors.Gradients.levelColors_8
        default:
            return [Styles.Colors.Palette.gray3, Styles.Colors.Palette.gray3]
        }
    }
    
    var profits: [String] {
        switch self {
        case .level_2:
            return ["• Публикация контента без модерации",
                    "• Доступ к публикации коротких видео и ссылок",
                    "• Создание прямых трансляций"]
        case .level_3:
            return ["• Комментарии без ограничений по времени",
                    "• Бесплатный доступ к просмотру лайков"]
        case .level_4:
            return ["• +1000 Anon Coin единоразово"]
        case .level_5:
            return ["• +1000 Anon Coin единоразово",
                    "• Эксклюзивный аватар 5 Уровня",
                    "• Специальные маски AR"]
        case .level_6:
            return ["• +2000 Anon Coin единоразово",
                    "• +100 Anon Coin ежемесячно",
                    "• Эксклюзивный аватар 6 Уровня",
                    "• Специальные маски AR"]
        case .level_7:
            return ["• +1000 Anon Coin единоразово",
                    "• Эксклюзивный аватар 5 Уровня",
                    "• Специальные маски AR"]
        case .level_8:
            return ["• +2000 Anon Coin единоразово",
                    "• +100 Anon Coin ежемесячно",
                    "• Открываются все возможности сети"]
        default:
            print("Unset title for level: \(self)")
            return []
        }
    }
}

final class AwardLevelsAlertNode: ASDisplayNode {
    //MARK: - Properties
    var onDone: (() -> Void)?
    
    private let levelValueTitleNode = ASTextNode()
    private let levelTitleNode = ASTextNode()
    private let profitsTitle = ASTextNode()
    private let wrapperNode = ASDisplayNode()
    private let transparentWrapperNode = ASDisplayNode()
    
    private let backgroundImageNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 256,
                                          height: 256)
        return node
    }()
    
    private lazy var doneButtonNode: BaseNodeViewBox<BaseTextButton> = {
        let boxNode = BaseNodeViewBox<BaseTextButton> { () -> UIView in
            let button = BaseTextButton()
                .setTitle(title: "Готово".uppercased())
                .setTextColor(color: Styles.Colors.Palette.white)
                .setTitleFont(font: Styles.Fonts.Tagline1)
            button.action = self.onDone
            
            return button
        }
        
        boxNode.style.height = ASDimensionMake(Styles.Sizes.buttonMedium)
        return boxNode
    }()
    
    let model: AwardLevelsAlertModel
    
    // MARK: - Init
    init(model: AwardLevelsAlertModel) {
        self.model = model
        super.init()
        
        automaticallyManagesSubnodes = true
        
        updateLevelCountNode()
        updateLevelNode()
        updateProfitsTitleNode()
        updateBackgroundImageNode()
        updateButtonColor()
        ThemeManager.add(self)
    }
    
    // MARK: - Life cycle
    override func layoutDidFinish() {
        super.layoutDidFinish()
        
        updateWrapperNode()
        updateButtonColor()
        updateTransparentWrapperNode()
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func setupProfitsVStackSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            
            model.profits.forEach { (profit) in
                let profitNode = ASTextNode()
                profitNode.attributedText = updateProfitsNode(text: profit)
                               
                children.append(ASInsetLayoutSpec(insets: .zero, child: profitNode))
            }
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 0
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            
            return vStack
        }
        
        func makeMainVStackInsetSpec() -> ASStackLayoutSpec {
            let levelValueInsetSpec = ASInsetLayoutSpec(insets: .zero, child: levelValueTitleNode)
            let levelTitleInsetSpec = ASInsetLayoutSpec(insets: .zero, child: levelTitleNode)
            
            var children = [ASLayoutElement]()
            children.append(levelValueInsetSpec)
            children.append(levelTitleInsetSpec)
            children.append(profitsTitle)
            children.append(setupProfitsVStackSpec())
            children.append(doneButtonNode)
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = Styles.Sizes.VPaddingMedium
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            
            return vStack
        }
        
        func makeWrapperBackgroundInsetSpec() -> ASBackgroundLayoutSpec {
            return ASBackgroundLayoutSpec(child: backgroundImageNode, background: wrapperNode)
        }
        
        func makeMainWrapperBackgroundInsetSpec() -> ASBackgroundLayoutSpec {
            return ASBackgroundLayoutSpec(child: transparentWrapperNode, background: makeWrapperBackgroundInsetSpec())
        }
        
        func makeMainBackgroundInsetSpec() -> ASBackgroundLayoutSpec {
            let mainVStackInsetSpec = ASInsetLayoutSpec(
                insets: .init(
                    top: Styles.Sizes.VPaddingBase,
                    left: Styles.Sizes.HPaddingBase,
                    bottom: Styles.Sizes.VPaddingBase,
                    right: Styles.Sizes.HPaddingBase),
                child: makeMainVStackInsetSpec())
            
            return ASBackgroundLayoutSpec(child: mainVStackInsetSpec, background: makeMainWrapperBackgroundInsetSpec())
        }
             
        return ASInsetLayoutSpec(insets: .zero, child: makeMainBackgroundInsetSpec())
    }
    
    // MARK: - Helpers
    private func updateLevelCountNode() {
        let attributes = Attributes {
            return $0.foreground(color: titleColor)
                .font(Styles.Fonts.LargeTitle)
                .alignment(.center)
        }
        
        levelValueTitleNode.attributedText = NSAttributedString(string: "\(model.title)", attributes: attributes.dictionary)
    }
    
    private func updateLevelNode() {
        let attributes = Attributes {
            return $0.foreground(color: titleColor)
                .font(Styles.Fonts.Body1)
                .alignment(.center)
        }
        
        levelTitleNode.attributedText = NSAttributedString(string: "Уровень", attributes: attributes.dictionary)
    }
    
    private func updateProfitsTitleNode() {
        let attributes = Attributes {
            return $0.foreground(color: titleColor)
                .font(Styles.Fonts.Subhead2)
                .alignment(.center)
        }
        
        profitsTitle.attributedText = NSAttributedString(string: "Поздравляем, вы получаете:", attributes: attributes.dictionary)
    }
    
    private func updateProfitsNode(text: String) -> NSAttributedString {
        let attributes = Attributes {
            return $0.foreground(color: profitsColor)
                .font(Styles.Fonts.Subhead2)
                .alignment(.center)
        }
        
        return NSAttributedString(string: text, attributes: attributes.dictionary)
    }
    
    private func updateTransparentWrapperNode() {
        let startPoint = CGPoint(x: 0.5, y: 0)
        let endPoint = CGPoint(x: 0.5, y: 1)
        
        transparentWrapperNode.addGradient(colors: [backColor.withAlphaComponent(0), backColor.withAlphaComponent(1)],
                                           locations: [0,1],
                                           startPoint: startPoint,
                                           endPoint: endPoint)
        
        transparentWrapperNode.cornerRadius = Styles.Sizes.cornerRadiusBase
        transparentWrapperNode.clipsToBounds = true
    }
    
    private func updateWrapperNode() {
        wrapperNode.cornerRadius = Styles.Sizes.cornerRadiusBase
        wrapperNode.clipsToBounds = true
    }
    
    private func updateButtonColor() {
        let startPoint = CGPoint(x: 1, y: 0)
        let endPoint = CGPoint(x: 0, y: 1)
        
        doneButtonNode.addGradient(colors: model.colors,
                                   locations: [0, 1],
                                   startPoint: startPoint,
                                   endPoint: endPoint)
        
        doneButtonNode.cornerRadius = Styles.Sizes.cornerRadiusBase
        doneButtonNode.clipsToBounds = true
    }
    
    private func updateBackgroundImageNode() {
        backgroundImageNode.image = model.backgroundImage
        backgroundImageNode.layer.opacity = 0.3
        backgroundImageNode.cropRect = CGRect(x: 0, y: 0, width: 0.0, height: 0.0)
    }
}

// MARK: - Themeable
extension AwardLevelsAlertNode: Themeable {
    func updateTheme() {
        switch theme {
        case .light:
            wrapperNode.backgroundColor = Styles.Colors.Palette.white
        case .dark:
            wrapperNode.backgroundColor = Styles.Colors.Palette.gray2
        }
    }
    
    var titleColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.gray3
        case .dark:
            return Styles.Colors.Palette.white
        }
    }
    
    var profitsColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.gray4
        case .dark:
            return Styles.Colors.Palette.gray5
        }
    }
    
    var backColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.white
        case .dark:
            return Styles.Colors.Palette.gray2
        }
    }
}
