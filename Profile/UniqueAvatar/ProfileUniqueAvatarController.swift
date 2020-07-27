//
//  ProfileUniqueAvatarController.swift
//  Alerts
//
//  Created by Dima on 23.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class ProfileUniqueAvatarController: UIViewController {
    let node = ProfileUniqueAvatarNode(model: [UniqueAvatarCircleNodeModel(circleColor: .red, internalCircleColor: .red)])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubnode(node)
        
        view.alpha = 1
        view.backgroundColor = .darkGray
        node.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 100)
        node.alpha = 1
        
    }
    

}
