//
//  ThanksLevelHeaderCollectionCellNode.swift
//  Alerts
//
//  Created by Dima on 14.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

enum ProfileLevelIcon: Int {
    case zero = 0
    case first
    case second
    case third
    case fourth
    case fifth
    case sixth
    case seventh
    case eighth
    
    var iconImage: UIImage? {
        switch self {
        case .fourth:
            return Styles.Images.fourthThankslevelImage
        case .fifth:
            return Styles.Images.fifthThankslevelImage
        case .sixth:
            return Styles.Images.sixthThankslevelImage
        case .seventh:
            return Styles.Images.seventhThankslevelImage
        case .eighth:
            return Styles.Images.eighthThankslevelImage
        default:
            return nil
        }
    }
    
    var title: String {
        return "LVL \(self.rawValue)"
    }
    
    var colors: [UIColor] {
        switch self {
        case .fourth:
            return Styles.Colors.Gradients.fourthLevelColors
        case .fifth:
            return Styles.Colors.Gradients.fifthLevelColors
        case .sixth:
            return Styles.Colors.Gradients.sixthLevelColors
        case .seventh:
            return Styles.Colors.Gradients.seventhLevelColors
        case .eighth:
            return Styles.Colors.Gradients.eighthLevelColors
        default:
            return [Styles.Colors.Palette.gray3, Styles.Colors.Palette.gray3]
        }
    }
}

import AsyncDisplayKit

final class ThanksLevelHeaderCollectionCellNode: ASCellNode {
    
    // MARK: - Properties
    
    private let thanksLevelCountNode = ASTextNode()
    private let thanksLevelTextNode = ASTextNode()
    private let remaindedLevelCountNode = ASTextNode()
    private let remaindedLevelTextNode = ASTextNode()
    private let levelIconTextNode = ASTextNode()
    private let levelIconWrapperNode = ASDisplayNode()
    private let levelInfoOffset: CGFloat = 25
    
    private let trackNode: ShapeNode<CAShapeLayer> = {
        let shapeNodeBox = ShapeNode<CAShapeLayer> { () -> CAShapeLayer in
            let track = CAShapeLayer()
            let trackPath = UIBezierPath(
                arcCenter: CGPoint(x: 72.5, y: 72.5),
                radius: 72.5,
                startAngle: 0,
                endAngle: CGFloat.pi * 2,
                clockwise: true
            )
            track.path = trackPath.cgPath
            track.lineWidth = 2
            track.lineCap = .round
            track.fillColor = UIColor.clear.cgColor
            track.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
            
            let count: CGFloat = 32
            let relativeDashLength: CGFloat = 0.25
            let dashLength = CGFloat((2 * .pi * 72.5) / count)
            track.lineDashPattern = [dashLength * relativeDashLength, dashLength * (1 - relativeDashLength)] as [NSNumber]
            return track
        }
        shapeNodeBox.style.preferredSize = CGSize(width: 145, height: 145)
        return shapeNodeBox
    }()
    
    private let roundNode: ShapeNode<CAShapeLayer> = {
        let shapeNodeBox = ShapeNode<CAShapeLayer> { () -> CAShapeLayer in
            let shape = CAShapeLayer()
            let circlularPath = UIBezierPath(
                arcCenter: CGPoint(x: 72.5, y: 72.5),
                radius: 72.5,
                startAngle: 0,
                endAngle:  CGFloat.pi * 2,
                clockwise: true
            )
            shape.path = circlularPath.cgPath
            shape.strokeColor = UIColor.blue.cgColor
            shape.lineWidth = 8
            shape.fillColor = UIColor.clear.cgColor
            shape.strokeEnd = 0
            shape.lineCap = .round
            shape.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
            return shape
        }
        
        shapeNodeBox.style.preferredSize = CGSize(width: 145, height: 145)
        return shapeNodeBox
    }()
    
    private let gradientNode: GradientNode<CAGradientLayer> = {
        let gradientNodeBox = GradientNode<CAGradientLayer> { () -> CAGradientLayer in
            let gradientLayer = CAGradientLayer()
            gradientLayer.type = .conic
            return gradientLayer
        }
        return gradientNodeBox
    }()
    
    private let userPhotoNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 129,
                                          height: 129)
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    private let levelIconImageNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 18,
                                          height: 18)
        node.contentMode = .scaleAspectFit
        return node
    }()
    
    private lazy var thanksLevel: CGFloat = {
        return model.thanksCount / 9000
    }()
    
    private lazy var remainedLevel: CGFloat = {
        return (9000 - model.thanksCount)
    }()
    
    private let model: UserThanksLevelModel
    
    // MARK: - Init
    
    init(model: UserThanksLevelModel) {
        self.model = model
        super.init()
        
        automaticallyManagesSubnodes = true
        updateTrackNode()
        updateThanksCount()
        updateUserPhotoNode()
        updateThanksText()
        updateRemainedThanksCount()
        updateRemainedText()
        updateLevelIconText()
        updateLevelIconImage()
        
        ThemeManager.add(self)
    }
    
    // MARK: - Layout
    
    override func layoutDidFinish() {
        setupGradientNode()
        userPhotoNode.cornerRadius = userPhotoNode.style.height.value / 2
        animateRoundNode()
        updateLevelIconWrapperColor()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeRoundGradientOverlaySpec() -> ASOverlayLayoutSpec {
            return ASOverlayLayoutSpec(child: roundNode, overlay: gradientNode)
        }
        
        func makeRoundProgressOverlaySpec() -> ASOverlayLayoutSpec {
            return ASOverlayLayoutSpec(child: trackNode, overlay: makeRoundGradientOverlaySpec())
        }
        
        func makeUserProgressBackgroundSpec() -> ASOverlayLayoutSpec {
            let userPhotoInsetSpec = ASInsetLayoutSpec(
                insets: .allInfinity(),
                child: userPhotoNode)
            
            return ASOverlayLayoutSpec(child: makeRoundProgressOverlaySpec(), overlay: userPhotoInsetSpec)
        }
        
        func makeUserLevelInfoVStackInsetSpec() -> ASInsetLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(thanksLevelCountNode)
            children.append(thanksLevelTextNode)
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 0
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            
            let vStackWidth = (UIScreen.main.bounds.width - roundNode.style.width.value) / 2
            vStack.style.width = ASDimensionMake(vStackWidth - (Styles.Sizes.HPaddingBase * 2))
            
            let topOffset = (roundNode.style.height.value / 2) - levelInfoOffset
            let insets = UIEdgeInsets(
                top: topOffset,
                left: Styles.Sizes.HPaddingBase,
                bottom: 0,
                right: Styles.Sizes.HPaddingBase
            )
            
            return ASInsetLayoutSpec(insets: insets, child: vStack)
        }
        
        func makeUserRamainedLevelInfoVStackInsetSpec() -> ASInsetLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(remaindedLevelCountNode)
            children.append(remaindedLevelTextNode)
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 0
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            
            let vStackWidth = (UIScreen.main.bounds.width - roundNode.style.width.value) / 2
            vStack.style.width = ASDimensionMake(vStackWidth - (Styles.Sizes.HPaddingBase * 2))
            
            let topOffset = (roundNode.style.height.value / 2) - levelInfoOffset
            let insets = UIEdgeInsets(
                top: topOffset,
                left: Styles.Sizes.HPaddingBase,
                bottom: 0,
                right: Styles.Sizes.HPaddingBase
            )
            
            return ASInsetLayoutSpec(insets: insets, child: vStack)
        }
        
        func makeMainHStackInsetSpec() -> ASStackLayoutSpec {
            let circleProgressInsetSpec = ASInsetLayoutSpec(
                insets: UIEdgeInsets(
                    top: 4,
                    left: 4,
                    bottom: 4,
                    right: 4),
                child: makeUserProgressBackgroundSpec()
            )
            
            var children = [ASLayoutElement]()
            children.append(makeUserLevelInfoVStackInsetSpec())
            children.append(circleProgressInsetSpec)
            children.append(makeUserRamainedLevelInfoVStackInsetSpec())
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = 0
            hStack.justifyContent = .center
            hStack.alignItems = .start
            hStack.children = children
            
            return hStack
        }
        
        func makeLevelIconHStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            
            if levelIconImageNode.image != nil { children.append(levelIconImageNode) }
            children.append(levelIconTextNode)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = 5
            hStack.justifyContent = .center
            hStack.alignItems = .center
            hStack.children = children
            
            hStack.style.height = ASDimensionMake(24)
            
            return hStack
        }
        
        func makeLevelIconBackgroundInsetSpec() -> ASBackgroundLayoutSpec {
            let leftOffset: CGFloat = levelIconImageNode.image == nil ? Styles.Sizes.HPaddingMedium : Styles.Sizes.HPaddingVerySmall
            let levelTextInset = ASInsetLayoutSpec(
                insets: UIEdgeInsets(
                    top: 0,
                    left: leftOffset,
                    bottom: 0,
                    right: Styles.Sizes.HPaddingMedium),
                child: makeLevelIconHStackInsetSpec()
            )
            
            return ASBackgroundLayoutSpec(child: levelTextInset, background: levelIconWrapperNode)
        }
        
        func makeMainVStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(makeMainHStackInsetSpec())
            children.append(makeLevelIconBackgroundInsetSpec())
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 8
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            
            return vStack
        }
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets.top(24), child: makeMainVStackInsetSpec())
    }
    
    // MARK: - Helpers
    
    private func updateTrackNode() {
        trackNode.value?.strokeColor = trackColor
    }
    
    private func animateRoundNode() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = thanksLevel
        basicAnimation.duration = 0.7
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        roundNode.value?.add(basicAnimation, forKey: nil)
    }
    
    private func setupGradientNode() {
        gradientNode.value?.startPoint = CGPoint(x: 0.482, y: 0.5)
        gradientNode.value?.endPoint = CGPoint(x: 0.5, y: -1)
        gradientNode.value?.colors = model.level.colors.map { $0.cgColor }
        gradientNode.layer.frame = view.frame
        gradientNode.layer.mask = roundNode.layer
    }
    
    private func updateUserPhotoNode() {
        userPhotoNode.image = model.image
    }
    
    private func updateThanksCount() {
        let attributes = Attributes {
            return $0.foreground(color: thanksCountColor)
                .font(Styles.Fonts.Title)
                .alignment(.center)
        }
        thanksLevelCountNode.attributedText = NSAttributedString(string: "\(Int(thanksLevel * 9000))", attributes: attributes.dictionary)
    }
    
    private func updateThanksText() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.gray4)
                .font(Styles.Fonts.Tagline2)
                .alignment(.center)
        }
        thanksLevelTextNode.maximumNumberOfLines = 0
        thanksLevelTextNode.attributedText = NSAttributedString(string: "Получено баллов", attributes: attributes.dictionary)
    }
    
    private func updateRemainedThanksCount() {
        let attributes = Attributes {
            return $0.foreground(color: thanksCountColor)
                .font(Styles.Fonts.Title)
                .alignment(.center)
        }
        remaindedLevelCountNode.attributedText = NSAttributedString(string: "\(Int(remainedLevel))", attributes: attributes.dictionary)
    }
    
    private func updateRemainedText() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.gray4)
                .font(Styles.Fonts.Tagline2)
                .alignment(.center)
        }
        remaindedLevelTextNode.maximumNumberOfLines = 0
        remaindedLevelTextNode.attributedText = NSAttributedString(string: "Осталось получить", attributes: attributes.dictionary)
    }
    
    private func updateLevelIconText() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.white)
                .font(Styles.Fonts.Caption1)
                .alignment(.center)
        }
        levelIconTextNode.attributedText = NSAttributedString(string: model.level.title, attributes: attributes.dictionary)
    }
    
    private func updateLevelIconWrapperColor() {
        let startPoint = CGPoint(x: 1, y: 1)
        let endPoint = CGPoint(x: 0, y: 1)
        
        levelIconWrapperNode.addGradient(colors: model.level.colors, locations: [0, 1], startPoint: startPoint, endPoint: endPoint)
        levelIconWrapperNode.cornerRadius = 12
        levelIconWrapperNode.clipsToBounds = true
    }
    
    private func updateLevelIconImage() {
        levelIconImageNode.image = model.level.iconImage
    }
}

    // MARK: - Themeable

extension ThanksLevelHeaderCollectionCellNode: Themeable {
    func updateTheme() {
        backgroundColor = UIColor.clear
    }
    
    var thanksCountColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.gray3
        case .dark:
            return Styles.Colors.Palette.white0
        }
    }
    
    var trackColor: CGColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.white0.cgColor
        case .dark:
            return Styles.Colors.Palette.gray3.cgColor
        }
    }
}

class ShapeNode<T: CAShapeLayer>: ASDisplayNode {
    weak var value : T? {
        return self.layer as? T
    }
}

class GradientNode<T: CAGradientLayer>: ASDisplayNode {
    weak var value : T? {
        return self.layer as? T
    }
}
