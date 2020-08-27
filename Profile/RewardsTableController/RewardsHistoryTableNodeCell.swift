//
//  RewardsHistoryTableNodeCell.swift
//  Alerts
//
//  Created by Dima on 21.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

enum Reward {
    case brainExplosion
    case superLike
    case platinum
    case gold
    case silver
    case epicFail
    case sorry
    case top
    case bravo
    
    var title: String {
        switch self {
        case .brainExplosion:
            return "Взрыв мозга".uppercased()
        case .superLike:
            return "Супер лайк".uppercased()
        case .platinum:
            return "Платина".uppercased()
        case .gold:
            return "Золото".uppercased()
        case .silver:
            return "Серебро".uppercased()
        case .epicFail:
            return "Эпик фейл".uppercased()
        case .sorry:
            return "Сочувствую".uppercased()
        case .top:
            return "Это топ".uppercased()
        case .bravo:
            return "Браво".uppercased()
        }
    }
    
    var image: UIImage {
        switch self {
        case .brainExplosion:
            return Styles.Images.brainExplosion
        case .superLike:
            return Styles.Images.superLike
        case .platinum:
            return Styles.Images.platinum
        case .gold:
            return Styles.Images.gold
        case .silver:
            return Styles.Images.silver
        case .epicFail:
            return Styles.Images.epicFail
        case .sorry:
            return Styles.Images.sorry
        case .top:
            return Styles.Images.top
        case .bravo:
            return Styles.Images.bravo
        }
    }
    
    var rewardCoins: [RewardCoins] {
        switch self {
        case .brainExplosion:
            return [RewardCoins(image: Styles.Images.rewardLikeIcon, count: 40000),
                    RewardCoins(image: Styles.Images.rewardVoiceIcon, count: 3000),
                    RewardCoins(image: Styles.Images.rewardLikeIcon, count: 4000),
                    RewardCoins(image: Styles.Images.rewardVoiceIcon, count: 3000)]
        default:
            return [RewardCoins(image: Styles.Images.rewardLikeIcon, count: 40000),
                    RewardCoins(image: Styles.Images.rewardVoiceIcon, count: 1000)]
        }
    }
}
 
struct RewardCoins {
    var image: UIImage
    var count: Int
}

enum UserEvent: String {
    case post = "Пост"
    case comment = "Комментарий"
    case live = "Прямой эфир"
    
    var localizedType: String {
        switch self {
        case .post:
            return "Посту"
        case .comment:
            return "Комментарию"
        case .live:
            return "Эфиру"
        }
    }
}

final class RewardsHistoryTableNodeCell: ASCellNode {
    
    // MARK: - Properties
    
    var onTapEnded: (() -> Void)?

    private let wrapperNode = ASDisplayNode()
    private let userNameTitleNode = ASTextNode()
    private let rewardTitleNode = ASTextNode()
    private let userDescriptionTitleNode = ASTextNode()
    private let userDescriptionTitleNode2 = ASTextNode()
    
    private let userPhotoNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: Styles.Sizes.buttonLarge,
                                          height: Styles.Sizes.buttonLarge)
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    private let rewardImageNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: Styles.Sizes.buttonSmall,
                                          height: Styles.Sizes.buttonSmall)
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    private var model: UserRewardModel
    
    // MARK: - Init
    
    init(model: UserRewardModel) {
        self.model = model
        super.init()
        
        automaticallyManagesSubnodes = true
        updateUserNameTitle()
        updateUserDescriprionTitle()
        updateRewardTitle()
        updateImage()
        
        ThemeManager.add(self)
    }
    
    // MARK: - Layout
    
    override func layoutDidFinish() {
        wrapperNode.cornerRadius = Styles.Sizes.cornerRadiusMedium
        userPhotoNode.cornerRadius = userPhotoNode.style.width.value / 2
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeVStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(userNameTitleNode)
            children.append(userDescriptionTitleNode)
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 0
            vStack.justifyContent = .center
            vStack.alignItems = .start
            vStack.children = children
            vStack.style.flexShrink = 0.1
            
            return vStack
        }
        
        func makeHStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(userPhotoNode)
            children.append(makeVStackInsetSpec())
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = Styles.Sizes.HPaddingMedium
            hStack.justifyContent = .center
            hStack.alignItems = .center
            hStack.children = children
            hStack.style.flexShrink = 0.1
            
            return hStack
        }
        
        func makeRewardHStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(rewardTitleNode)
            children.append(rewardImageNode)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = Styles.Sizes.HPaddingMedium
            hStack.justifyContent = .center
            hStack.alignItems = .center
            hStack.children = children
            
            return hStack
        }
        
        func makeMainHStackInsetSpec() -> ASInsetLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(makeHStackInsetSpec())
            children.append(makeRewardHStackInsetSpec())
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = Styles.Sizes.HPaddingMedium
            hStack.justifyContent = .spaceBetween
            hStack.alignItems = .center
            hStack.children = children
            
            let insets = UIEdgeInsets(
                top: Styles.Sizes.VPaddingMedium,
                left: Styles.Sizes.HPaddingMedium,
                bottom: Styles.Sizes.VPaddingMedium,
                right: Styles.Sizes.HPaddingMedium
            )
            
            return ASInsetLayoutSpec(insets: insets, child: hStack)
        }
        
        func makeBackgroundInsetSpec() -> ASBackgroundLayoutSpec {
            return ASBackgroundLayoutSpec(child: makeMainHStackInsetSpec(), background: wrapperNode)
        }
        
        let insets = UIEdgeInsets(
            top: Styles.Sizes.VPaddingMedium / 2,
            left: Styles.Sizes.HPaddingMedium,
            bottom: Styles.Sizes.VPaddingMedium / 2,
            right: Styles.Sizes.HPaddingMedium
        )
        
        return ASInsetLayoutSpec(insets: insets, child: makeBackgroundInsetSpec())
    }
    
    // MARK: - Helpers
    
    private func updateUserNameTitle() {
        let attributes = Attributes {
            return $0.foreground(color: titleColor)
                .font(Styles.Fonts.Subhead1)
                .alignment(.left)
                .lineBreakMode(.byTruncatingTail)
        }
        
        userNameTitleNode.attributedText = NSAttributedString(string: model.name, attributes: attributes.dictionary)
    }
    
    private func updateUserDescriprionTitle() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.gray4)
                .font(Styles.Fonts.Caption3)
                .alignment(.left)
                .lineBreakMode(.byTruncatingTail)
        }
        
        let dotSpacerAttributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.gray4)
                .font(Styles.Fonts.Caption3)
                .alignment(.center)
        }
        
        let mutableString = NSMutableAttributedString(string: model.event.rawValue, attributes: attributes.dictionary)
        
        mutableString.append(
            NSAttributedString(
                string: " • ", // " \u{00B7} " - a possible symbol
                attributes: dotSpacerAttributes.dictionary
            )
        )
        
        let awardReceivingTime = RewardTimeFormatter().convertedDate(with: model.rewardTimeReceiving) ?? ""
        mutableString.append(
            NSAttributedString(
                string: awardReceivingTime,
                attributes: attributes.dictionary
            )
        )
        
        userDescriptionTitleNode.attributedText = mutableString
    }
    
    private func updateRewardTitle() {
        let attributes = Attributes {
            return $0.foreground(color: titleColor)
                .font(Styles.Fonts.Tagline3)
                .alignment(.left)
            }
        
        rewardTitleNode.attributedText = NSAttributedString(string: model.reward.title, attributes: attributes.dictionary)
    }
    
    private func updateImage() {
        userPhotoNode.image = model.photo
        rewardImageNode.image = model.reward.image
    }
}

    // MARK: - Themeable

extension RewardsHistoryTableNodeCell: Themeable {
    func updateTheme() {
        switch theme {
        case .light:
            wrapperNode.backgroundColor = Styles.Colors.Palette.white0
        case .dark:
            wrapperNode.backgroundColor = Styles.Colors.Palette.gray2
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
