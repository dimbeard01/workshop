//
//  Header.swift
//  Alerts
//
//  Created by Dima on 14.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

class Header: ASCellNode {
     var a = ASDisplayNode()
    
    init(type: ASDisplayNode) {
        super.init()
        a = type
        addSubnode(a)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero, child: a)
    }
}
