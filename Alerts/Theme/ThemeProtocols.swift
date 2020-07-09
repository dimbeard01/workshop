//
//  ThemeProtocols.swift
//  Alerts
//
//  Created by Dima on 09.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

@objc protocol Themeable: Weakable {
    @objc func updateTheme()
    
    @objc optional var statusBarStyle: UIStatusBarStyle { get set }
    @objc optional var fixTheme: ThemeStyle { get set }
    @objc optional var alternativeTheme: ThemeAlternativeStyle { get set }
}

extension Themeable {
    var theme: ThemeStyle {
        return fixTheme ?? ThemeManager.themeStyle
    }
}
