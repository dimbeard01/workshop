//
//  ShortProfilePresentationViewController.swift
//  Alerts
//
//  Created by Dima on 30.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

class ShortProfilePresentationViewController: UIViewController {
    
    // MARK: - Init
    var userAlert: ShortProfilePresentationView!
    let userPhoto: UIImage
    
//    init(userPhoto: UIImage, timeWasOnline: String, profileInfo: [String : String]) {
//        super.init(nibName: nil, bundle: nil)
//    }
    init(userPhoto: UIImage) {
        self.userPhoto = userPhoto
           super.init(nibName: nil, bundle: nil)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userAlert = ShortProfilePresentationView(userPhoto: userPhoto, buttonTypes: [ButtonType.coloredBase("Салам", Styles.Colors.Palette.orange1, {
            print("UHUUU")
        })], theme: .light, userInfo: ["ffdsd","dfsd"])
        
        view.addSubview(userAlert)
        userAlert.alpha = 1
    }
}
