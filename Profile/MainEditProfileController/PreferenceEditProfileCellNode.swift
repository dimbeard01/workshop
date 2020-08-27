//
//  PreferenceEditProfileCellNode.swift
//  Alerts
//
//  Created by Dima on 27.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class PreferenceEditProfileCellNode: ASCellNode {
    
    // MARK: - Properties
    
    var onDetailed: (() -> Void)?
    
    private let wrapperNode = ASDisplayNode()
    private var model: PreferenceEditProfileCellViewModel
    
    private let userPhotoNode: ASImageNode = {
          let node = ASImageNode()
          node.style.preferredSize = CGSize(width: Styles.Sizes.buttonSmall,
                                            height: Styles.Sizes.buttonSmall)
          node.contentMode = .scaleAspectFill
          return node
      }()
    
    private let titleNode = ASTextNode()
    
    private lazy var detailButtonNode: BaseNodeViewBox<BaseIconButton> = {
        let boxNode = BaseNodeViewBox<BaseIconButton> { () -> UIView in
            let button = BaseIconButton()
                .setImage(image: Styles.Images.detailIcon)
            button.action = self.onDetailed
            return button
        }
        
        boxNode.style.preferredSize = CGSize(width: Styles.Sizes.buttonExtraSmall,
                                             height: Styles.Sizes.buttonExtraSmall)
        return boxNode
    }()
    
    // MARK: - Init
    
    init(model: PreferenceEditProfileCellViewModel) {
        self.model = model
        super.init()
        
        automaticallyManagesSubnodes = true
        updateTitle()
        updateImage()
        
        ThemeManager.add(self)
    }
    
    // MARK: - Life cycle
    
    override func layoutDidFinish() {
        wrapperNode.cornerRadius = Styles.Sizes.cornerRadiusMedium
        userPhotoNode.cornerRadius = userPhotoNode.style.width.value / 2
    }
    
    // MARK: - Layout
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeHorizontalInsetSpec() -> ASStackLayoutSpec {
            titleNode.style.flexShrink = 0.1

            var children = [ASLayoutElement]()
            children.append(userPhotoNode)
            children.append(titleNode)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = Styles.Sizes.HPaddingBase
            hStack.justifyContent = .center
            hStack.alignItems = .center
            hStack.children = children
            hStack.style.flexShrink = 0.1
            
            return hStack
        }
        
        func makeMainHorizontalInsetSpec() -> ASInsetLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(makeHorizontalInsetSpec())
            children.append(detailButtonNode)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = Styles.Sizes.HPaddingBase
            hStack.justifyContent = .spaceBetween
            hStack.alignItems = .center
            hStack.children = children

            let insets = UIEdgeInsets(
                top: Styles.Sizes.VPaddingMedium,
                left: Styles.Sizes.HPaddingBase,
                bottom: Styles.Sizes.VPaddingMedium,
                right: Styles.Sizes.HPaddingBase
            )
            return ASInsetLayoutSpec(insets: insets, child: hStack)
        }
        
        func makeBackgroundInsetSpec() -> ASBackgroundLayoutSpec {
            return ASBackgroundLayoutSpec(child: makeMainHorizontalInsetSpec(), background: wrapperNode)
        }
        
        let insets = UIEdgeInsets(
            top: Styles.Sizes.VPaddingSmall,
            left: Styles.Sizes.HPaddingMedium,
            bottom: Styles.Sizes.VPaddingSmall,
            right: Styles.Sizes.HPaddingMedium
        )
        return ASInsetLayoutSpec(insets: insets, child: makeBackgroundInsetSpec())
    }
    
    // MARK: - Helpers
    
    private func updateTitle() {
        let attributes = Attributes {
            return $0.foreground(color: titleColor)
                .font(Styles.Fonts.Body2)
                .lineBreakMode(.byTruncatingTail)
                .alignment(.left)
        }
        titleNode.attributedText = NSAttributedString(string: model.title, attributes: attributes.dictionary)
    }
    
    private func updateImage() {
        userPhotoNode.image = model.userPhoto
    }
}

    // MARK: - Themeable

extension PreferenceEditProfileCellNode: Themeable {
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

