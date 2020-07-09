//
//  ThemeManager.swift
//  Alerts
//
//  Created by Dima on 09.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

class ThemeManager {
    static var themeStyle: ThemeStyle = .dark {
        didSet {
            ThemeManager.updateColorAppearance()
            ThemeManager.setBackButtonAppearance()
            ThemeManager.updateTheme()
            //ThemeManager.updateAppIcon()
        }
        willSet {
//            AppManager.shared.theme = newValue
        }
    }
    
    fileprivate static var listeners: [Weak<Themeable>] = []
    
    fileprivate static func updateTheme() {
        self.listeners = self.listeners.filter { !$0.isNil }
        for themeable in listeners {
            updateTheme(themeable.value, animation: true)
        }
    }
}

extension ThemeManager {
    fileprivate static let serialQueue = DispatchQueue(label: "ThemeManager")
    
    static func updateTheme(_ themeable: Themeable?, animation: Bool = false) {
        func updTheme() {
            guard let themeable = themeable else { return }
            
            themeable.updateTheme()
            
            if let vc = themeable as? UIViewController {
                updateNavigationBar(vc)
            }
        }
        
        if animation {
            UIView.animate(withDuration: Styles.Constants.animationDurationSmall) {
                updTheme()
            }
        } else {
            updTheme()
        }
    }
    
    static func add(_ themeable: Themeable, forceUpdate: Bool = true) {
        serialQueue.sync {
            self.listeners = self.listeners.filter { !$0.isNil }
            self.listeners.append(Weak(value: themeable))
            
            if forceUpdate {
                updateTheme(themeable)
            }
        }
    }
    
    //static func remove(_ themeable: Themeable) {
    //    self.themeables = self.themeables.filter {
    //       $0.value?.isEqual(themeable) == false
    //   }
    //}
}
