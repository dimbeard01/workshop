//
//  ThemeManager+Appearance.swift
//  Alerts
//
//  Created by Dima on 09.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

extension ThemeManager {
    static func updateNavigationBar(_ vc: UIViewController){
        guard let themeableVC = vc as? Themeable else { return }
        
        var navBarItemColor: UIColor
        var titleTextAttributesColor: UIColor
        
        switch themeableVC.theme {
        case .light:
            titleTextAttributesColor = Styles.Colors.Palette.gray3
            navBarItemColor = Styles.Colors.Palette.gray3
            
            if #available(iOS 13.0, *) {
                vc.overrideUserInterfaceStyle = .light
            }
            
        case .dark:
            titleTextAttributesColor = Styles.Colors.Palette.white0
            navBarItemColor = Styles.Colors.Palette.white0
            
            if #available(iOS 13.0, *) {
                vc.overrideUserInterfaceStyle = .dark
            }
        }
        
        if themeableVC.alternativeTheme != Optional.none {
            switch themeableVC.alternativeTheme {
            case .pink:
                titleTextAttributesColor = Styles.Colors.Palette.pink1
                navBarItemColor = Styles.Colors.Palette.pink1
            case .orange:
                titleTextAttributesColor = Styles.Colors.Palette.orange1
                navBarItemColor = Styles.Colors.Palette.orange1
            case .green:
                titleTextAttributesColor = Styles.Colors.Palette.green1
                navBarItemColor = Styles.Colors.Palette.green1
            case .purple:
                titleTextAttributesColor = Styles.Colors.Palette.purple1
                navBarItemColor = Styles.Colors.Palette.purple1
            default:
                break
            }
        }
        
        DispatchQueue.main.async {
            vc.navigationController?.navigationBar.tintColor = navBarItemColor
            vc.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: titleTextAttributesColor
            ]
        }
    }
    
    static func updateColorAppearance() {
        UIApplication.shared.keyWindow?.backgroundColor = Styles.Colors.Palette.black
        UIApplication.shared.keyWindow?.tintColor = Styles.Colors.Palette.primary1
        
        switch ThemeManager.themeStyle {
        case .light:
            if #available(iOS 13.0, *) {
                UIWindow.appearance().overrideUserInterfaceStyle = .light
                UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
                
                UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = Styles.Colors.Palette.primary1
            }
            
        case .dark:
            if #available(iOS 13.0, *) {
                UIWindow.appearance().overrideUserInterfaceStyle = .dark
                UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .dark
                
                UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = Styles.Colors.Palette.white
            }
        }
        
        //window.tintColor = .black
        //window.backgroundColor = .black
    }
    
    static func updateAppIcon() {
        switch themeStyle {
        case .dark:
            ()
//            AppIconManager.shared.setIcon(.spaceWhite)
        case .light:
            ()
//            AppIconManager.shared.setIcon(.whiteBlack)
        }
    }
}

extension ThemeManager {
    static func setBackButtonAppearance() {
        var backButtonBackgroundImage = Styles.Images.navBack
        
//        backButtonBackgroundImage = backButtonBackgroundImage.resizableImage(withCapInsets:
//                UIEdgeInsets(top: 0,
//                             left: backButtonBackgroundImage.size.width - 1,
//                             bottom: 0,
//                             right: 0))
//
//        let barAppearance = UINavigationBar.appearance(whenContainedInInstancesOf: [NavigatorController.self])
//        barAppearance.backIndicatorImage = backButtonBackgroundImage
//        barAppearance.backIndicatorTransitionMaskImage = backButtonBackgroundImage
    }
}
