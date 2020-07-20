//
//  FindsFeedCellNode.swift
//  Alerts
//
//  Created by Dima on 13.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit
import CoreImage
final class FindsFeedCellNode: ASCellNode {
    
    // MARK: - Properties
    
    private let titleNode = ASTextNode()
    private let userNameNode = ASTextNode()
    private let userInfoNode = ASTextNode()
    private let arrowImageNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: Styles.Sizes.buttonExtraSmall,
                                          height: Styles.Sizes.buttonExtraSmall)
        node.contentMode = .scaleAspectFit
        return node
    }()
    
    let animator = UIViewPropertyAnimator(duration: 0, curve: .linear)
    
    private let photoImageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFit
        node.image = UIImage(named: "photo2")
        
        return node
    }()

//    private lazy var blurNode: BaseNodeViewBox<UIVisualEffectView> = {
//
//        let boxNode = BaseNodeViewBox<UIVisualEffectView> { () -> UIView in
//            let node = UIView()
//            let outUIImage: UIImage
//            let ciContext = CIContext(options: nil)
//            let image = UIImage(named: "photo2")
//
//            guard let inputImage = CIImage(image: image!),
//                let mask = CIFilter(name: "CIGaussianBlur") else { return node }
//
//            mask.setValue(inputImage, forKey: kCIInputImageKey)
//            mask.setValue(200, forKey: kCIInputRadiusKey) // Set your blur radius here
//
//            guard let output = mask.outputImage,
//                let cgImage = ciContext.createCGImage(output, from: inputImage.extent) else { return node}
//            outUIImage = UIImage(cgImage: cgImage)
//            return UIImageView(image: outUIImage)
//        }
//        return boxNode
//    }()
    
    private lazy var blurNode: BaseNodeViewBox<UIVisualEffectView> = {
        let boxNode = BaseNodeViewBox<UIVisualEffectView> { () -> UIView in
            let blurEffect = (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type).init()

            blurEffect.setValue(10, forKeyPath: "blurRadius")
            let blurView = UIVisualEffectView(effect: blurEffect)

            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            //blurView.layer.masksToBounds = true
            return blurView
        }
        return boxNode
    }()
    
//      private lazy var blurNode: BaseNodeViewBox<UIVisualEffectView> = {
//            let boxNode = BaseNodeViewBox<UIVisualEffectView> { () -> UIView in
//
//                let blurView = UIVisualEffectView(effect: nil)
//
//                blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//                blurView.layer.masksToBounds = true
//                return blurView
//            }
//            return boxNode
//        }()

    // MARK: - Init
    
    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        updateTitle()
        updateUserInfo()
        updateUserName()
        updateImage()
        backgroundColor = .black
        
    }
    
    // MARK: - Layout

    override func layoutDidFinish() {
        cornerRadius = 20
        
        //animateBlur()
    }
    
    
    func animateBlur(){
        animator.addAnimations {
            self.blurNode.value?.effect = UIBlurEffect(style: .regular)
        }
        animator.fractionComplete = 0.1
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeHorizontalInsetSpec() -> ASInsetLayoutSpec {
            let infoTitleInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: titleNode)
            let imageInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: arrowImageNode)
            
            var children = [ASLayoutElement]()
            children.append(imageInsetSpec)
            children.append(infoTitleInsetSpec)
            
            let hStack = ASStackLayoutSpec.horizontal()
            hStack.spacing = Styles.Sizes.HPaddingMedium
            hStack.justifyContent = .start
            hStack.alignItems = .center
            hStack.children = children
            
            let InsetSpec =  ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12), child: hStack)
            return InsetSpec
        }
        
        func makeVerticalInsetSpec() -> ASInsetLayoutSpec {
            let userNameInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: userNameNode)
            let userInfoInsetSpec =  ASInsetLayoutSpec(insets: .zero, child: userInfoNode)
            
            var children = [ASLayoutElement]()
            children.append(userNameInsetSpec)
            children.append(userInfoInsetSpec)
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.justifyContent = .center  
            vStack.alignItems = .start
            vStack.children = children
            
            let InsetSpec =  ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), child: vStack)
            return InsetSpec
        }
        
        func makeMainInsetSpec() -> ASStackLayoutSpec {
            
            let spacer = ASLayoutSpec()
            spacer.style.flexGrow = 1
            
            var children = [ASLayoutElement]()
            children.append(makeHorizontalInsetSpec())
            children.append(spacer)
            children.append(makeVerticalInsetSpec())
            
            let vStack = ASStackLayoutSpec.vertical()
            vStack.spacing = Styles.Sizes.HPaddingMedium
            vStack.justifyContent = .spaceBetween
            vStack.alignItems = .start
            vStack.children = children
            
            vStack.style.preferredSize.height = 240
            
            return vStack
        }
        
        func blurInsetSpec() -> ASBackgroundLayoutSpec {
            let insetSpec = ASInsetLayoutSpec(insets: .zero, child: photoImageNode)
            return ASBackgroundLayoutSpec(child: blurNode , background: insetSpec )
        }
        
        func roundedBackgroundInsetSpec() -> ASBackgroundLayoutSpec {
            let hMainStack = makeMainInsetSpec()
            
            let insetSpec = ASInsetLayoutSpec(insets: .zero, child: photoImageNode)

            return ASBackgroundLayoutSpec(child: hMainStack , background: blurInsetSpec())
        }
        
        return ASInsetLayoutSpec(insets: .zero, child: roundedBackgroundInsetSpec())
    }
    
    // MARK: - Helpers
    
    private func updateTitle() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.white)
                .font(Styles.Fonts.Subhead1)
                .alignment(.left)
        }
        titleNode.attributedText = NSAttributedString(string: "Совпадение", attributes: attributes.dictionary)
    }
    
    private func updateUserName() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.white)
                .font(Styles.Fonts.Subhead1)
                .alignment(.left)
        }
        userNameNode.attributedText = NSAttributedString(string: "Wendy Mccoy", attributes: attributes.dictionary)
    }
    
    private func updateUserInfo() {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.white)
                .font(Styles.Fonts.Caption2)
                .alignment(.left)
        }
        userInfoNode.attributedText = NSAttributedString(string: "19 лет, Москва", attributes: attributes.dictionary)
    }
    
    private func updateImage() {
        arrowImageNode.image = #imageLiteral(resourceName: "doubleStar").withTintColor(Styles.Colors.Palette.white)
    }
}

