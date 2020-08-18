//
//  ProfileUniqueAliasUserInfoNode.swift
//  Alerts
//
//  Created by Dima on 30.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class ProfileUniqueAliasUserInfoNode: ASDisplayNode {
    
    private let userNickname = ASTextNode()
    
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
    
    var model: UniqueAliasUserModel
    
    init(model: UniqueAliasUserModel) {
        self.model = model
        super.init()
        
        automaticallyManagesSubnodes = true
        updateTitle()
        updateImage()
        
        ThemeManager.add(self)
    }
    
    override func layoutDidFinish() {
        super.layoutDidFinish()
        
        userPhotoNode.cornerRadius = userPhotoNode.style.height.value / 2
        
    }
    
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
        
        return ASInsetLayoutSpec(insets: .zero, child: makeMainHorizontalInsetSpec())
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
}

extension ProfileUniqueAliasUserInfoNode: Themeable {
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
