//
//  WalletHeaderCellNode.swift
//  Alerts
//
//  Created by Dima on 01.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class WalletHeaderCellNode: ASCellNode {
    // MARK: - Properties
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
    
    // MARK: - Helpers
    private func updateTitleNode() {
        let attributes = Attributes {
            return $0.foreground(color: titleTextColor)
                .font(Styles.Fonts.Body1)
                .alignment(.center)
        }
        
        titleNode.attributedText = NSAttributedString(string: "Пополнить", attributes: attributes.dictionary)
    }
}

// MARK: - Themeable
extension WalletHeaderCellNode: Themeable {
    func updateTheme() {
        backgroundColor = .clear
    }
    
    var titleTextColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.gray3
        case .dark:
            return Styles.Colors.Palette.white
        }
    }
}
