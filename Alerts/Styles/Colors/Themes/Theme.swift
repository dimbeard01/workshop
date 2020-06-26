//  Created by boris on 31/03/2019.
//  Copyright © 2019 Anonym. All rights reserved.

import UIKit

class Theme: NSObject {
    let primaryColor: UIColor
    let secondaryColor: UIColor
    let appearence: Appearence
    
    init(primaryColor: UIColor, secondaryColor: UIColor, appearence: Appearence) {
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.appearence = appearence
    }
}
