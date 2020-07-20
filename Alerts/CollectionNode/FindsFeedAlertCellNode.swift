//
//  FindsFeedAlertCellNode.swift
//  Alerts
//
//  Created by Dima on 15.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class FindsFeedAlertCellNode: ASCellNode {
    
    var alertNode = ASDisplayNode()
    
    init(node: ASDisplayNode) {
        super.init()
        
        alertNode = node
        addSubnode(alertNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero, child: alertNode)
    }
}
