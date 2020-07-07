//
//  BaseNodeViewBox.swift
//  Alerts
//
//  Created by Dima on 06.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

class BaseNodeViewBox<T:UIView>: ASDisplayNode {
    weak var value : T? {
        return self.view as? T
    }
}



