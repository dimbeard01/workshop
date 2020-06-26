//	Created by boris on 09/07/2019.
//	Copyright © 2019 Anonym. All rights reserved.

import Foundation

@objc enum ThemeStyle: Int, CaseIterable {
    case light = 0
    case dark
    
    var theme: Theme {
        switch self {
        case .light:
            return Theme.light
        case .dark:
            return Theme.dark
        }
    }
}

extension ThemeStyle {
    var name: String {
        switch self {
        case .light:
            return "light"
        case .dark:
            return "dark"
        }
    }
    
    static func enumFromString(name: String) -> ThemeStyle? {
        return ThemeStyle.allCases.first(where: {$0.name == name})
    }
}
