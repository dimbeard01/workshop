//
//  FindsEditProfileBoostNode.swift
//  
//
//  Created by Dima on 09.07.2020.
//

import AsyncDisplayKit

enum BoostState {
    case noFindsPlus
    case inactive
    case active
}

final class FindsFeedBoostNode: ASDisplayNode {
    enum ActionType {
        case showInfo
        case buyFindsPlus
        case activateBoost
    }
    
    var onTapAction: ((ActionType) -> Void)?
    
    private lazy var activateBoostButtonNode: BaseNodeViewBox<BaseTextButton> = {
        let boxNode = BaseNodeViewBox<BaseTextButton> { () -> UIView in
            let button = BaseTextButton()
                .setTitle(title: "Boost".uppercased())
                .setTitleFont(font: Styles.Fonts.Tagline2)
                .setTextColor(color: Styles.Colors.Palette.white)
            button.insets = .zero
            button.action = { [weak self] in
                
            }
    
            return button
        }
        
        boxNode.style.preferredSize = CGSize(
            width: 80, // find a way to change to .infinity
            height: Styles.Sizes.buttonSmall
        )
        return boxNode
    }()
    
    private let infoTitleNode = ASTextNode()
    private let infoDescriptionNode = ASTextNode()
    
    private let arrowImageNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(
            width: Styles.Sizes.iconBase,
            height: Styles.Sizes.iconBase
        )
        return node
    }()
    
    private lazy var infoButtonNode: BaseNodeViewBox<BaseIconButton> = {
        let boxNode = BaseNodeViewBox<BaseIconButton> { () -> UIView in
            let button = BaseIconButton()
                .setButtonSize(height: Styles.Sizes.iconBase)
                .setIconSize(height: Styles.Sizes.iconSmall)
            button.action = { [weak self] in
                self?.onTapAction?(.showInfo)
            }
            return button
        }
        
        boxNode.style.preferredSize = CGSize(
            width: Styles.Sizes.iconBase,
            height: Styles.Sizes.iconBase
        )
        return boxNode
    }()

    let progressImageNode: ASImageNode = {
        let node = ASImageNode()
        node.image = Styles.Images.findsBoostIcon
        node.style.preferredSize = CGSize(width: 47, height: 47)
        return node
    }()
    
    private lazy var borderNode: BaseNodeViewBox<BorderView> = {
        let boxNode = BaseNodeViewBox<BorderView> { () -> UIView in
            let borderView = BorderView()
            return borderView
        }
        return boxNode
    }()
    
    private let roundedWrapperNode = ASDisplayNode()
    
    private let boostState: BoostState
    
    init(boostState: BoostState) {
        self.boostState = boostState
        super.init()
        
        automaticallyManagesSubnodes = true
        updateTitle()
        updateDescription()
        updateImages()
        
        ThemeManager.add(self)
    }
    
    override func layoutDidFinish() {
        super.layoutDidFinish()
        
        updateUI()
    }
    
    private func updateUI() {
        let gradientColors = Styles.Colors.Gradients.findsBoostGradientColors
        let startPoint = CGPoint(x: 0, y: 1)
        let endPoint = CGPoint(x: 1, y: 0)
        
        switch boostState {
        case .noFindsPlus:
            activateBoostButtonNode
                .addGradient(colors: gradientColors, locations: [0, 1], startPoint: startPoint, endPoint: endPoint)
        case .active:
            roundedWrapperNode
                .addGradient(colors: gradientColors, locations: [0, 1], startPoint: startPoint, endPoint: endPoint)
        case .inactive:
            roundedWrapperNode
                .addGradient(colors: gradientColors, locations: [0, 1], startPoint: startPoint, endPoint: endPoint)
        }
        
        roundedWrapperNode.cornerRadius = Styles.Sizes.cornerRadiusMedium
        roundedWrapperNode.clipsToBounds = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeHorizontalInfoStack() -> ASStackLayoutSpec {
            let infoTitleInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: infoTitleNode)
            
            var children = [ASLayoutElement]()
            if boostState != .active { children.append(arrowImageNode) }
            children.append(infoTitleInsetSpec)
            children.append(infoButtonNode)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = Styles.Sizes.HPaddingMedium
            hStack.alignItems = .center
            hStack.children = children
            
            return hStack
        }
        
        func makeVerticalStackInfoInsetSpec() -> ASInsetLayoutSpec {
            let hInfoStack = makeHorizontalInfoStack()

            let infoDescriptionInsetSpec = ASInsetLayoutSpec(insets: .zero, child: infoDescriptionNode)
            
            var children = [ASLayoutElement]()
            children.append(hInfoStack)
            children.append(infoDescriptionInsetSpec)
            
            let vInfoStack = ASStackLayoutSpec.vertical()
            vInfoStack.spacing = Styles.Sizes.VPaddingSmall
            vInfoStack.alignItems = .start
            vInfoStack.justifyContent = .start
            vInfoStack.children = children
            
            let insetScpec = ASInsetLayoutSpec(insets: .zero, child: vInfoStack)
            insetScpec.style.flexShrink = 1
            
            return insetScpec
        }
        
        func makeMainHorizontaStacklInsetSpec() -> ASInsetLayoutSpec {
            let vStackInsetSpec = makeVerticalStackInfoInsetSpec()
 
            var children = [ASLayoutElement]()
            
            switch boostState {
            case .noFindsPlus, .inactive:
                let spacer = ASLayoutSpec()
                spacer.style.flexGrow = 1
                
                children.append(vStackInsetSpec)
                children.append(spacer)
                children.append(activateBoostButtonNode)
            case .active:
                children.append(progressImageNode)
                children.append(vStackInsetSpec)
            }
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = Styles.Sizes.HPaddingBase
            hStack.justifyContent = .start
            hStack.alignItems = .center
            hStack.children = children
            
            let insets = UIEdgeInsets(
                top: Styles.Sizes.VPaddingBase + Styles.Sizes.VPaddingMedium,
                left: Styles.Sizes.HPaddingBase * 2,
                bottom: Styles.Sizes.VPaddingBase + Styles.Sizes.VPaddingMedium,
                right: Styles.Sizes.HPaddingBase * 2
            )
            
            return ASInsetLayoutSpec(insets: insets, child: hStack)
        }
        
        func roundedBackgroundInsetSpec() -> ASBackgroundLayoutSpec {
            let hMainStack = makeMainHorizontaStacklInsetSpec()
            
            let insetSpec = ASInsetLayoutSpec(
                insets: .init(
                    top: Styles.Sizes.VPaddingMedium,
                    left: Styles.Sizes.HPaddingMedium,
                    bottom: Styles.Sizes.HPaddingMedium,
                    right: Styles.Sizes.VPaddingMedium),
                child: roundedWrapperNode
            )
         
            return ASBackgroundLayoutSpec(child: hMainStack, background: insetSpec)
        }
        
        return ASBackgroundLayoutSpec(child: roundedBackgroundInsetSpec(), background: borderNode)
    }
    
    func updateTitle() {
        let attributes = Attributes {
            return $0.foreground(color: infoTitleColor)
                .font(Styles.Fonts.Subhead1)
                .alignment(.center)
        }
            
        infoTitleNode.attributedText = NSAttributedString(string: "Finds+Boost", attributes: attributes.dictionary)
    }
    
    func updateDescription() {
        let attributes = Attributes {
            return $0.foreground(color: infoContentColor)
                .font(Styles.Fonts.Caption2)
                .alignment(.left)
        }
           
        
        infoDescriptionNode.maximumNumberOfLines = 0
        infoDescriptionNode.attributedText = NSAttributedString(string: "Подними анкету в ленте", attributes: attributes.dictionary)
    }
    
    func updateImages() {
        progressImageNode.image = #imageLiteral(resourceName: "boostActive")
    }
}

extension FindsFeedBoostNode: Themeable {
    func updateTheme() {
        switch theme {
        case .light:
            borderNode.backgroundColor = Styles.Colors.Palette.white
        case .dark:
            borderNode.backgroundColor = Styles.Colors.Palette.bgDark
        }
        
        infoButtonNode.value?.setImage(image: Styles.Images.findsInfoIcon.imageWithColor(tintColor: infoContentColor))
        
        updateUIColors()
    }
    
    func updateUIColors() {
        switch boostState {
        case .noFindsPlus:
            switch theme {
            case .light:
                roundedWrapperNode.backgroundColor = Styles.Colors.Palette.white0
            case .dark:
                roundedWrapperNode.backgroundColor = Styles.Colors.Palette.gray2
            }
            arrowImageNode.image = Styles.Images.findsBoostIcon
            
        case .inactive:
            arrowImageNode.image = Styles.Images.findsBoostIcon.imageWithColor(tintColor: Styles.Colors.Palette.white)
            activateBoostButtonNode.borderWidth = 2
            activateBoostButtonNode.borderColor = Styles.Colors.Palette.white.cgColor
        case .active:
            arrowImageNode.image = Styles.Images.findsBoostIcon.imageWithColor(tintColor: Styles.Colors.Palette.white)
        }
    }
    
    var infoTitleColor: UIColor {
        switch boostState {
        case .noFindsPlus:
            switch theme {
            case .light:
                return Styles.Colors.Palette.gray3
            case .dark:
                return Styles.Colors.Palette.white0
            }
        case .inactive, .active:
            return Styles.Colors.Palette.white
        }
    }
    
    var infoContentColor: UIColor {
        switch boostState {
        case .noFindsPlus:
            switch theme {
            case .light:
                return Styles.Colors.Palette.gray5
            case .dark:
                return Styles.Colors.Palette.gray4
            }
        case .inactive, .active:
            return Styles.Colors.Palette.white
        }
    }
}
