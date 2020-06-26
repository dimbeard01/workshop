//  Created by boris on 03/05/2019.
//  Copyright © 2019 Anonym. All rights reserved.

import UIKit

struct Font {
    static func regular(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    static func medium(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    static func semibold(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    
    static func bold(_ size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
    
    static func light(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .light)
    }
    
    static func semiboldItalic(_ size: CGFloat) -> UIFont {
        if let descriptor = UIFont.systemFont(ofSize: size).fontDescriptor.withSymbolicTraits([.traitBold, .traitItalic]) {
            return UIFont(descriptor: descriptor, size: size)
        } else {
            return italic( size)
        }
    }
    
    static func italic(_ size: CGFloat) -> UIFont {
        return UIFont.italicSystemFont(ofSize: size)
    }
}
