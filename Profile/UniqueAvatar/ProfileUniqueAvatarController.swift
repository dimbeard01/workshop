//
//  ProfileUniqueAvatarController.swift
//  Alerts
//
//  Created by Dima on 23.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class ProfileUniqueAvatarController: UIViewController {
    let node1 = ProfileUniqueAvatarNode(model: UniqueAvatarCircleNodeModel(circleColor: .red, internalCircleColor: .green))
    let node2 = ProfileUniqueAvatarNode(model: UniqueAvatarCircleNodeModel(circleColor: .blue, internalCircleColor: .yellow))
    let node3 = ProfileUniqueAvatarNode(model: UniqueAvatarCircleNodeModel(circleColor: .white, internalCircleColor: .blue))
    let node4 = ProfileUniqueAvatarNode(model: UniqueAvatarCircleNodeModel(circleColor: .black, internalCircleColor: .green))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainNode = ProfileUniqueAvatarColorsNode()
        view.addSubnode(mainNode)
        mainNode.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: view.bounds.height)
        view.backgroundColor = Styles.Colors.Palette.bgDark
    }
}
