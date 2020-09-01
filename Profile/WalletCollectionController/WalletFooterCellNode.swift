//
//  WalletFooterCellNode.swift
//  Alerts
//
//  Created by Dima on 01.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation

import AsyncDisplayKit

final class WalletFooterCellNode: ASCellNode {
    
    // MARK: - Properties
    
    var onTapEnded: (() -> Void)?
    
    private let titleNode = ASTextNode()
    
    // MARK: - Init
    
    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        updateTitleNode()
        
        ThemeManager.add(self)
    }
    
    // MARK: - Layout
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        func makeCenterLayoutSpec() -> ASCenterLayoutSpec {
            return ASCenterLayoutSpec(centeringOptions: .X, sizingOptions: [], child: titleNode)
        }
        
        return makeCenterLayoutSpec()
    }
    
    private func updateTitleNode() {
        let attributes = Attributes {
            return $0.foreground(color: titleTextColor)
                .font(Styles.Fonts.Tagline3)
                .alignment(.center)
        }
        
        titleNode.attributedText = NSAttributedString(string: "Условия обслуживания", attributes: attributes.dictionary)
    }
}

    // MARK: - Themeable

extension WalletFooterCellNode: Themeable {
    func updateTheme() {
        backgroundColor = .clear
    }
    
    var titleTextColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.gray5
        case .dark:
            return Styles.Colors.Palette.gray4
        }
    }
}
