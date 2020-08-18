//
//  ThanksLevelHeaderCollectionCellNode.swift
//  Alerts
//
//  Created by Dima on 14.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class ThanksLevelHeaderCollectionCellNode: ASCellNode {
    
    private let thanksLevelCountNode = ASTextNode()
    private let thanksLevelTextNode = ASTextNode()
    private let remaindedLevelCountNode = ASTextNode()
    private let remaindedLevelTextNode = ASTextNode()
    
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
            track.strokeColor = Styles.Colors.Palette.gray6.cgColor
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
    
    private lazy var roundNode: ShapeNode<CAShapeLayer> = {
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
            shape.strokeEnd = self.thanksLevel
            shape.lineCap = .round
            shape.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
            return shape
        }
        
        shapeNodeBox.style.preferredSize = CGSize(width: 145, height: 145)
        return shapeNodeBox
    }()
    
    private lazy var gradientNode: GradientNode<CAGradientLayer> = {
        let shapeNodeBox = GradientNode<CAGradientLayer> { () -> CAGradientLayer in
            let gradientLayer = CAGradientLayer()
            gradientLayer.type = .conic
            gradientLayer.colors = self.gradientColorss
            return gradientLayer
        }
        return shapeNodeBox
    }()
    
   private let wrapperNode: ASDisplayNode = {
       let wrapper = ASDisplayNode()
        wrapper.backgroundColor = .blue
        wrapper.style.preferredSize = CGSize(width: 375, height: 229)
        return wrapper
    }()
    
    private let userPhotoNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 129,
                                          height: 129)
        node.image = UIImage(named: "photo2")
        node.contentMode = .scaleAspectFill
        return node
    }()

   
    private var thanksLevel: CGFloat  
    private var remainedLevel: CGFloat
    private var gradientColors: [CGColor]
    private var gradientColorss: [CGColor] = [UIColor.red.cgColor, UIColor.blue.cgColor]
    
    init(thanksLevel: CGFloat, remainedLevel: CGFloat, gradientColors: [CGColor]) {
        self.thanksLevel = thanksLevel
        self.remainedLevel = remainedLevel
        self.gradientColors = gradientColors
        super.init()
        
        automaticallyManagesSubnodes = true
        updateThanksCount()
        updateThanksText()
        updateRemainedThanksCount()
        updateRemainedText()
    }
    
    override func layoutDidFinish() {
        setupGradientNode()
        userPhotoNode.cornerRadius = userPhotoNode.style.height.value / 2
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeRoundGradientSpec() -> ASOverlayLayoutSpec {

            return ASOverlayLayoutSpec(child: roundNode, overlay: gradientNode)
        }
        
        func makeMainProgressSpec() -> ASBackgroundLayoutSpec {
            return ASBackgroundLayoutSpec(child: makeRoundGradientSpec(), background: trackNode )
        }
            
        func makeMainUserProgressSpec() -> ASBackgroundLayoutSpec {
            let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), child: userPhotoNode)

            return ASBackgroundLayoutSpec(child: makeMainProgressSpec(), background: insetSpec)
        }
        
        func makeVerticalLevelInsetSpec() -> ASInsetLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(thanksLevelCountNode)
            children.append(thanksLevelTextNode)
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 0
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            //vStack.style.width = ASDimensionMake(100)
            
            return ASInsetLayoutSpec(insets: .zero, child: vStack)
        }
        
        func makeVerticalRamainedLevelInsetSpec() -> ASInsetLayoutSpec {
            var children = [ASLayoutElement]()
            children.append(remaindedLevelCountNode)
            children.append(remaindedLevelTextNode)
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = 0
            vStack.justifyContent = .center
            vStack.alignItems = .center
            vStack.children = children
            //vStack.style.width = ASDimensionMake(100)

            return ASInsetLayoutSpec(insets: .zero, child: vStack)
        }
        
//        func cent() -> ASCenterLayoutSpec {
//              return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: makeMainUserProgressSpec())
//          }
//        
        func makeMainHorizontalInsetSpec() -> ASStackLayoutSpec {
            let circleProgressInset = ASInsetLayoutSpec(insets:
                      UIEdgeInsets(top: 4,
                                   left: 4,
                                   bottom: 4,
                                   right: 4), child: makeMainUserProgressSpec())
            
            let inset1 = ASInsetLayoutSpec(insets:.zero, child: makeVerticalLevelInsetSpec())
            
            let inset2 = ASInsetLayoutSpec(insets:.zero, child: makeVerticalRamainedLevelInsetSpec())
            
            var children = [ASLayoutElement]()
            children.append(inset1)
            children.append(circleProgressInset)
            children.append(inset2)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = 0
            hStack.justifyContent = .center
            hStack.alignItems = .center
            hStack.children = children
            return hStack
        }
        
        func cent() -> ASCenterLayoutSpec {
               return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: makeMainHorizontalInsetSpec())
           }
        let inset = ASInsetLayoutSpec(insets:
            UIEdgeInsets(top: 10,
                         left: 10,
                         bottom: 10,
                         right: 10), child: cent())
        
        return cent()
        return ASInsetLayoutSpec(insets:  .zero, child: makeMainProgressSpec())
    }
    
    // MARK: - Helpers
    private func setupGradientNode() {
        gradientNode.value?.startPoint = CGPoint(x: 0.485, y: 0.5)
        gradientNode.value?.endPoint = CGPoint(x: 0.5, y: -1)
        gradientNode.layer.frame = self.view.frame
        gradientNode.layer.mask = roundNode.layer
    }
    
    private func updateThanksCount() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.primary2)
                .font(Styles.Fonts.Tagline1)
                .alignment(.center)
        }
        thanksLevelCountNode.attributedText = NSAttributedString(string: "\(Int(thanksLevel * 9000))", attributes: attributes.dictionary)
    }
    
    private func updateThanksText() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.primary2)
                .font(Styles.Fonts.Tagline3)
                .alignment(.center)
        }
        thanksLevelTextNode.maximumNumberOfLines = 0
        thanksLevelTextNode.attributedText = NSAttributedString(string: "Получено баллeceececeecов", attributes: attributes.dictionary)
    }
    
    private func updateRemainedThanksCount() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.primary2)
                .font(Styles.Fonts.Tagline1)
                .alignment(.center)
        }
        remaindedLevelCountNode.attributedText = NSAttributedString(string: "\(Int(remainedLevel))", attributes: attributes.dictionary)
    }
    private func updateRemainedText() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.primary2)
                .font(Styles.Fonts.Tagline3)
                .alignment(.center)
        }
        remaindedLevelTextNode.maximumNumberOfLines = 0
        remaindedLevelTextNode.attributedText = NSAttributedString(string: "Осталось получfrfrить", attributes: attributes.dictionary)
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
