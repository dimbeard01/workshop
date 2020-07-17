//
//  BlurTest.swift
//  Alerts
//
//  Created by Dima on 16.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

class BlurViewController: UIViewController {
    private let blurEffect = (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type).init()

    override func viewDidLoad() {
        super.viewDidLoad()
        let blurView = UIVisualEffectView(frame: UIScreen.main.bounds)
        let i = UIImageView(image:  UIImage(named: "photo2"))
        view.addSubview(i)

        blurEffect.setValue(3, forKeyPath: "blurRadius")
        blurView.effect = blurEffect
        view.addSubview(blurView)
    }
}
