//
//  BoostNode.swift
//  AsyncDK
//
//  Created by Dima on 05.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class BoostNode: ASDisplayNode {
    
    // MARK: - Properties

    private let boostTitle = ASTextNode()
    private let boostDescription = ASTextNode()
    private let boostImage = ASImageNode()
    private let boostIndicatorImage = ASImageNode()
    private let type: BoostAlertType
    private let baseGradient: [UIColor]
    private let theme: Theme

    private lazy var boostButton: BaseNodeViewBox<BaseTextButton> = {
        let boxNode = BaseNodeViewBox<BaseTextButton> { () -> UIView in
            let button = BaseTextButton()
                .setTitle(title: "BOOST")
                .setTextColor(color: Styles.Colors.Palette.white)
                .setTitleFont(font: Styles.Fonts.Tagline2)
            button.action = {
                print("boost")
            }
            return button
        }
        
        switch type {
        case .activeBoost, .gradientBoost:
            boxNode.borderWidth = 2
            boxNode.borderColor = UIColor.white.cgColor
        default:
            break
        }
     
        boxNode.style.preferredSize = CGSize(width: 78, height: 32)
        return boxNode
    }()
    
    private lazy var infoboostButton: BaseNodeViewBox<BaseIconButton> = {
        let color = iconColor()
        let boxNode = BaseNodeViewBox<BaseIconButton> { () -> UIView in
            let button = BaseIconButton()
                .setImage(image: UIImage(named: "out")!)
                .setIconColor(color: color)
            return button
        }
        
        boxNode.style.preferredSize = CGSize(width: 16, height: 16)
        return boxNode
    }()
    
    // MARK: - Init

    init(type: BoostAlertType, gradient: [UIColor], theme: Theme) {
        self.type = type
        self.baseGradient = gradient
        self.theme = theme
        super.init()
        
        automaticallyManagesSubnodes = true
        setupView()
    }
    
    // MARK: - Support
    
    private func titleTextColor() -> UIColor {
        switch type {
        case .baseBoost:
            return theme == Theme.dark ? Styles.Colors.Palette.white0 : Styles.Colors.Palette.gray3
        default:
            return Styles.Colors.Palette.white
        }
    }
    
    private func descriptionTextColor() -> UIColor {
        switch type {
        case .baseBoost:
            return theme == Theme.dark ? Styles.Colors.Palette.gray4 : Styles.Colors.Palette.gray5
        default:
            return Styles.Colors.Palette.white
        }
    }
    
    private func iconColor() -> UIColor {
        switch type {
        case .baseBoost:
            return theme == Theme.dark ? Styles.Colors.Palette.gray4 : Styles.Colors.Palette.gray5
        default:
            return Styles.Colors.Palette.white
        }
    }
    
    // MARK: - Layout

    private func setupView() {
        let titleAttribute: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : Styles.Fonts.Subhead1,                                                                     NSAttributedString.Key.foregroundColor : titleTextColor()]
        
        let descriptionAttribute: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font :  Styles.Fonts.Caption1,                                                               NSAttributedString.Key.foregroundColor : descriptionTextColor()]
        
        boostTitle.attributedText = NSAttributedString(string: type.title, attributes: titleAttribute)
        boostDescription.attributedText = NSAttributedString(string: type.description, attributes: descriptionAttribute)
        
        switch type {
        case .activeBoost:
            boostIndicatorImage.image = UIImage(named: type.imageName)
            boostIndicatorImage.contentMode = .scaleAspectFit
            boostIndicatorImage.style.preferredSize = CGSize(width: 47, height: 47)
            
        case .baseBoost, .gradientBoost:
            boostImage.image = UIImage(named: type.imageName)
            boostImage.contentMode = .scaleAspectFit
            boostImage.style.preferredSize = CGSize(width: 24, height: 24)
        }
    }
    
    override func layoutDidFinish() {
        super.layoutDidFinish()
        
        switch type {
        case .activeBoost, .gradientBoost:
            addGradient(colors: baseGradient, locations: [0.0,1.0], startPoint: CGPoint(x: 1, y: 0), endPoint: CGPoint(x: 0, y: 1))
        case .baseBoost:
            boostButton.addGradient(colors: baseGradient, locations: [0.0,1.0], startPoint: CGPoint(x: 1, y: 0), endPoint: CGPoint(x: 0, y: 1))
            backgroundColor = theme == Theme.dark ? Styles.Colors.Palette.gray2 : Styles.Colors.Palette.white
        }
        
        boostButton.cornerRadius = boostButton.bounds.height / 2
        cornerRadius = 14
        clipsToBounds = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var titileStackChildren = [ASLayoutElement]()
        var titileDescriptionStackChildren = [ASLayoutElement]()
        var boostStackChildren = [ASLayoutElement]()
        
        switch type {
        case .activeBoost:
            titileStackChildren.append(boostTitle)
            titileStackChildren.append(infoboostButton)
        case .baseBoost, .gradientBoost:
            titileStackChildren.append(boostImage)
            titileStackChildren.append(boostTitle)
            titileStackChildren.append(infoboostButton)
        }
        
        let hStack = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 8,
                                       justifyContent: .start,
                                       alignItems: .center,
                                       children: titileStackChildren)
        let descriptionInsetSpec = ASInsetLayoutSpec(insets: .zero, child: boostDescription)
        
        titileDescriptionStackChildren.append(hStack)
        titileDescriptionStackChildren.append(descriptionInsetSpec)
        
        let vStack = ASStackLayoutSpec(direction: .vertical,
                                       spacing: 5,
                                       justifyContent: .start,
                                       alignItems: .start,
                                       children: titileDescriptionStackChildren)
        let hBoostStack = ASStackLayoutSpec.horizontal()

        switch type {
        case .activeBoost:
            boostStackChildren.append(boostIndicatorImage)
            boostStackChildren.append(vStack)
            
            hBoostStack.justifyContent = .start
            hBoostStack.alignItems = .center
            hBoostStack.spacing = 12
            hBoostStack.children = boostStackChildren
            
        case .baseBoost, .gradientBoost:
            boostStackChildren.append(vStack)
            boostStackChildren.append(boostButton)
            
            hBoostStack.justifyContent = .spaceBetween
            hBoostStack.alignItems = .center
            hBoostStack.children = boostStackChildren
        }
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16), child: hBoostStack)

//        switch type {
//        case .activeBoost:
//            titileStackChildren.append(boostTitle)
//            titileStackChildren.append(infoboostButton)
//            let hStack = ASStackLayoutSpec(direction: .horizontal,
//                                           spacing: 8,
//                                           justifyContent: .start,
//                                           alignItems: .center,
//                                           children: titileStackChildren)
//
//            let descriptionInsetSpec = ASInsetLayoutSpec(insets: .zero, child: boostDescription)
//
//            titileDescriptionStackChildren.append(hStack)
//            titileDescriptionStackChildren.append(descriptionInsetSpec)
//
//            let vStack = ASStackLayoutSpec(direction: .vertical,
//                                           spacing: 5,
//                                           justifyContent: .start,
//                                           alignItems: .start,
//                                           children: titileDescriptionStackChildren)
//
//
//            boostStackChildren.append(boostIndicatorImage)
//            boostStackChildren.append(vStack)
//            let hBoostStack = ASStackLayoutSpec.horizontal()
//
//            hBoostStack.justifyContent = .start
//            hBoostStack.alignItems = .center
//            hBoostStack.spacing = 12
//            hBoostStack.children = boostStackChildren
//
//            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16), child: hBoostStack)
//
//        case .baseBoost, .gradientBoost:
//            titileStackChildren.append(boostImage)
//            titileStackChildren.append(boostTitle)
//            titileStackChildren.append(infoboostButton)
//            let hStack = ASStackLayoutSpec(direction: .horizontal,
//                                           spacing: 8,
//                                           justifyContent: .start,
//                                           alignItems: .center,
//                                           children: titileStackChildren)
//
//            hStack.style.flexShrink = 1
//            hStack.style.flexGrow = 1
//
//            let descriptionInsetSpec = ASInsetLayoutSpec(insets: .zero, child: boostDescription)
//
//            titileDescriptionStackChildren.append(hStack)
//            titileDescriptionStackChildren.append(descriptionInsetSpec)
//
//            let vStack = ASStackLayoutSpec(direction: .vertical,
//                                           spacing: 5,
//                                           justifyContent: .start,
//                                           alignItems: .start,
//                                           children: titileDescriptionStackChildren)
//            boostStackChildren.append(vStack)
//            boostStackChildren.append(boostButton)
//            let hBoostStack = ASStackLayoutSpec.horizontal()
//
//            hBoostStack.justifyContent = .spaceBetween
//            hBoostStack.alignItems = .center
//            hBoostStack.children = boostStackChildren
//            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16), child: hBoostStack)
//        }
    }
    
    @objc private func pressedInfo() {
        print("info")
    }
}

