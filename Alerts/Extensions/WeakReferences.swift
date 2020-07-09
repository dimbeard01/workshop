//
//  WeakReferences.swift
//  Alerts
//
//  Created by Dima on 09.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation

@objc protocol Weakable: class { }

class Weak<T: Weakable> {
    private (set) weak var value: T?
    
    var isNil: Bool {
        return self.value == nil
    }
    
    init(value: T?) {
        self.value = value
    }
}
