//
//  BoostViewController.swift
//  AsyncDK
//
//  Created by Dima on 05.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit
import AsyncDisplayKit

enum BoostAlertType {
    case activeBoost
    case baseBoost
    case gradientBoost
    
    var title: String {
        switch self {
        case .activeBoost:
            return "Finds+ Boost активен"
        case .baseBoost, .gradientBoost:
            return "Finds+ Boost "
        }
    }
    
    var description: String {
        switch self {
        case .activeBoost, .baseBoost, .gradientBoost:
            return "Подними анкету в ленте"
        }
    }
    
    var imageName: String {
        switch self {
        case .activeBoost:
            return "boostActive"
        case .baseBoost:
            return "gradientBoost"
        case .gradientBoost:
            return "boost"
        }
    }
}


final class BoostViewController: UIViewController {
    private let boost: BoostNode

    init(type: BoostAlertType, gradient: [UIColor], theme: Theme) {
        self.boost = BoostNode(type: type, gradient: gradient, theme: theme)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        boost.frame = CGRect(x: 10, y: 100, width: UIScreen.main.bounds.width * 0.95, height: 71)
        view.addSubnode(boost)
    }
}
