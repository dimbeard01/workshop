//
//  PreferenceEditProfileCellViewModel.swift
//  Alerts
//
//  Created by Dima on 27.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

struct PreferenceEditProfileCellViewModel {
    var userPhoto: UIImage
    var title: String
}

struct Listeners {
    let listentersName = "Мои слушатели"
    var listenters: [PreferenceEditProfileCellViewModel]
    var count: Int
    
    init(model: [PreferenceEditProfileCellViewModel]) {
        self.listenters = model
        self.count = model.count
    }
}
