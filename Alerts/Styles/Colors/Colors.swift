//  Created by boris on 30/05/2019.
//  Copyright © 2019 Anonym. All rights reserved.

import UIKit

extension Styles.Colors {
    static var randomColor: UIColor {
        return [Palette.error1,
                Palette.secondary1,
                Palette.primary1,
                Palette.success1].randomElement() ?? .white
    }
}
