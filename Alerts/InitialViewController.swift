//
//  InitialViewController.swift
//  Alerts
//
//  Created by Dima on 30.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 88, y: 200, width: 200, height: 55)
        button.setTitle("Show Alert", for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        view.backgroundColor = .white
        view.addSubview(button)
    }
    
    @objc private func showAlert() {
        
        let imageUser = UIImage(named: "userPhoto")
        let userAlertVC = ShortProfilePresentationViewController(userPhoto: imageUser!)
        userAlertVC.modalPresentationStyle = .overCurrentContext
             userAlertVC.modalTransitionStyle = .crossDissolve
        
        let alertVC = AlertViewController(type: .hiddenProfile, theme: Theme.dark)
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.modalTransitionStyle = .crossDissolve
        
        alertVC.onAction = { [weak self] actionType in
            switch actionType {
            case .detailed :
                print("Detailed")
            case .activated:
                print("Activated")
            case .done:
                self?.dismiss(animated: true, completion: nil)
                print("Done")
            case .boostDetailed:
                print("See more about Boost")
            case .openProfile:
                self?.dismiss(animated: true, completion: nil)
                print("Open Profile")
            case .createProfile:
                print("Create Profile")
            case .exitAndHide:
                print("Exit and Hide")
            case .hide:
                print("Hide")
            case .remove:
                print("Remove")
            case .cancel(let string):
                print(string)
            }
        }
        
        present(userAlertVC, animated: true, completion: nil)
    }
}
