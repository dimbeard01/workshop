//
//  PreferenceEditProfileHeaderCellNode.swift
//  Alerts
//
//  Created by Dima on 28.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class PreferenceEditProfileHeaderCellNode: ASCellNode {
    // MARK: - Properties
    var onCancel: (() -> Void)?
    
    private let wrapperNode = ASDisplayNode()
    private var countModel: Listeners
    private let titleNode = ASTextNode()
    private let counterNode = ASTextNode()
   
    private lazy var cancelButtonNode: BaseNodeViewBox<BaseIconButton> = {
        let boxNode = BaseNodeViewBox<BaseIconButton> { () -> UIView in
            let button = BaseIconButton()
                .setImage(image: Styles.Images.cancelIcon)
            button.action = self.onCancel
            
            return button
        }
        
        boxNode.style.preferredSize = CGSize(width: 22,
                                             height: 22)
        return boxNode
    }()
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
    
    // MARK: - Init
    init(countModel: Listeners) {
        self.countModel = countModel
        super.init()
        
        automaticallyManagesSubnodes = true
        updateTitle()
        updateCounter()
        
        ThemeManager.add(self)
    }
    
    // MARK: - Life cycle
    override func layoutDidFinish() {
        super.layoutDidFinish()

        wrapperNode.cornerRadius = 12
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeBackgroundInsetSpec() -> ASBackgroundLayoutSpec {
            let insets = UIEdgeInsets(
                top: Styles.Sizes.VPaddingSmall,
                left: Styles.Sizes.HPaddingMedium,
                bottom: Styles.Sizes.VPaddingSmall,
                right: Styles.Sizes.HPaddingMedium
            )
            
            let counterInsetSpec =  ASInsetLayoutSpec(insets: insets, child: counterNode)
            return ASBackgroundLayoutSpec(child: counterInsetSpec, background: wrapperNode)
        }
        
        func makeHorizontalInsetSpec() -> ASStackLayoutSpec {
            let titleInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: titleNode)
            
            var children = [ASLayoutElement]()
            children.append(titleInsetSpec)
            children.append(makeBackgroundInsetSpec())
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = Styles.Sizes.HPaddingMedium
            hStack.justifyContent = .center
            hStack.alignItems = .center
            hStack.children = children
            
            return hStack
        }
        
        func makeMainHorizontalInsetSpec() -> ASInsetLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(makeHorizontalInsetSpec())
            children.append(cancelButtonNode)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = Styles.Sizes.HPaddingMedium
            hStack.justifyContent = .spaceBetween
            hStack.alignItems = .center
            hStack.children = children
            
            let insets = UIEdgeInsets(
                top: 13,
                left: 16,
                bottom: Styles.Sizes.VPaddingMedium,
                right: 16
            )
            return ASInsetLayoutSpec(insets: insets, child: hStack)
        }
        return makeMainHorizontalInsetSpec()
    }
    
    // MARK: - Helpers
    private func updateTitle() {
        let attributes = Attributes {
            return $0.foreground(color: titleColor)
                .font(Styles.Fonts.Body1)
                .alignment(.left)
        }
        titleNode.attributedText = NSAttributedString(string: countModel.listentersName, attributes: attributes.dictionary)
    }
    
    private func updateCounter() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.gray4)
                .font(Styles.Fonts.SubCaption1)
                .alignment(.left)
        }
        guard let count = numberFormatter.string(from: NSNumber(value: countModel.count)) else { return }
        counterNode.attributedText = NSAttributedString(string: count, attributes: attributes.dictionary)
    }
}

// MARK: - Themeable
extension PreferenceEditProfileHeaderCellNode: Themeable {
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
