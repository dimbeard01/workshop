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
//        hideAlert()
    }
    
    // MARK: - Support
    
    private func showAlert() {
        UIView.animate(withDuration: 1) {
            self.alertView.alpha = 1
        }
    }
    
    private func hideAlert() {
        UIView.animate(withDuration: 1, animations: {
            self.alertView.alpha = 0
        }, completion: { _ in
            self.alertView.removeFromSuperview()
        })
    }
}
