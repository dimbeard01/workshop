//
//  AlertViewController.swift
//  Alerts
//
//  Created by Dima on 25.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit
import TinyConstraints

final class AlertViewController: UIViewController {
    
   // MARK: - Properties
    
    private let alertView = AlertView()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(alertView)
        alertView.edgesToSuperview()
        alertView.show()
    }
    
    // MARK: - Support

}
