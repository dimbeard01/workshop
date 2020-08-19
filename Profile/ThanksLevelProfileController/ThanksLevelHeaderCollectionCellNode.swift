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
    private let levelTextNode = ASTextNode()
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
            track.strokeColor = Styles.Colors.Palette.gray3.cgColor
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
    
    private let levelIconWrapperNode: ASDisplayNode = {
        let wrapper = ASDisplayNode()
        wrapper.style.height = ASDimensionMake(24)
        return wrapper
    }()
    
    private let userPhotoNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 129,
                                          height: 129)
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    private let levelIconNode: ASImageNode = {
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
        updateThanksCount()
        updateUserPhotNode()
        updateThanksText()
        updateRemainedThanksCount()
        updateRemainedText()
        updateLevelText()
        updateLevelIcon()
    }
    
    // MARK: - Layout

    override func layoutDidFinish() {
        setupGradientNode()
        userPhotoNode.cornerRadius = userPhotoNode.style.height.value / 2
        animateRoundNode()
        updateWrapperColor()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        func makeRoundGradientSpec() -> ASOverlayLayoutSpec {
            return ASOverlayLayoutSpec(child: roundNode, overlay: gradientNode)
        }
        
        func makeProgressSpec() -> ASBackgroundLayoutSpec {
            return ASBackgroundLayoutSpec(child: makeRoundGradientSpec(), background: trackNode )
        }
        
        func makeMainProgressSpec() -> ASBackgroundLayoutSpec {
            let insets = UIEdgeInsets(
                top: Styles.Sizes.VPaddingMedium,
                left: Styles.Sizes.HPaddingMedium,
                bottom: Styles.Sizes.VPaddingMedium,
                right: Styles.Sizes.HPaddingMedium
            )
            
            let userPhotoInsetSpec = ASInsetLayoutSpec(insets: insets, child: userPhotoNode)
            return ASBackgroundLayoutSpec(child: makeProgressSpec(), background: userPhotoInsetSpec)
        }
        
        func makeLevelVStackInsetSpec() -> ASInsetLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(thanksLevelCountNode)
            children.append(thanksLevelTextNode)
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 0
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            vStack.style.flexShrink = 0
            
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
        
        func makeRamainedLevelVStackInsetSpec() -> ASInsetLayoutSpec {
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
                    right: 4
                ),
                child: makeMainProgressSpec()
            )
            
            var children = [ASLayoutElement]()
            children.append(makeLevelVStackInsetSpec())
            children.append(circleProgressInsetSpec)
            children.append(makeRamainedLevelVStackInsetSpec())
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = 0
            hStack.justifyContent = .center
            hStack.alignItems = .start
            hStack.children = children
            
            return hStack
        }
        
        func makeWrapperHStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            
            if levelIconNode.image != nil {
                children.append(levelIconNode)
                children.append(levelTextNode)
            } else {
                children.append(levelTextNode)
            }
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = 5
            hStack.justifyContent = .center
            hStack.alignItems = .center
            hStack.children = children
            
            hStack.style.height = ASDimensionMake(24)
            
            return hStack
        }
        
        func makeWrapperBackgroundInsetSpec() -> ASBackgroundLayoutSpec {
            var leftOffset: CGFloat {
                if levelIconNode.image == nil {
                    return 8
                } else {
                    return 3
                }
            }
            
            let levelTextInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: leftOffset, bottom: 0, right: 8), child: makeWrapperHStackInsetSpec())
            
            return ASBackgroundLayoutSpec(child: levelTextInset, background: levelIconWrapperNode)
        }
        
        func makeMainVStackInsetSpec() -> ASStackLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(makeMainHStackInsetSpec())
            children.append(makeWrapperBackgroundInsetSpec())
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 8
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            
            return vStack
        }
        
        let insets = UIEdgeInsets(
            top: 24,
            left: 0,
            bottom: 0,
            right: 0
        )
        return ASInsetLayoutSpec(insets: insets, child: makeMainVStackInsetSpec())
    }
    
    // MARK: - Helpers
    
    private func animateRoundNode() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = thanksLevel
        basicAnimation.duration = 0.7
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        roundNode.value?.add(basicAnimation, forKey: "urSoBasic")
    }
    
    private func setupGradientNode() {
        gradientNode.value?.startPoint = CGPoint(x: 0.485, y: 0.5)
        gradientNode.value?.endPoint = CGPoint(x: 0.5, y: -1)
        gradientNode.value?.colors = model.level.colors.map { $0.cgColor }
        gradientNode.layer.frame = view.frame
        gradientNode.layer.mask = roundNode.layer
    }
    
    private func updateUserPhotNode() {
        userPhotoNode.image = model.image
    }
    
    private func updateThanksCount() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.white0)
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
            return $0.foreground(color: Styles.Colors.Palette.white0)
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
    
    private func updateLevelText() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.white0)
                .font(Styles.Fonts.Caption1)
                .alignment(.center)
        }
        levelTextNode.attributedText = NSAttributedString(string: model.level.title, attributes: attributes.dictionary)
    }
    
    private func updateWrapperColor() {
        let startPoint = CGPoint(x: 1, y: 1)
        let endPoint = CGPoint(x: 0, y: 1)
        
        levelIconWrapperNode.alpha = 1
        levelIconWrapperNode.addGradient(colors: model.level.colors, locations: [0, 1], startPoint: startPoint, endPoint: endPoint)
        levelIconWrapperNode.cornerRadius = 12
        levelIconWrapperNode.clipsToBounds = true
    }
    
    private func updateLevelIcon() {
        levelIconNode.image = model.level.iconImage
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

