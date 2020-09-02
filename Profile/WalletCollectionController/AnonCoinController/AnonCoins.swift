//
//  AnonCoins.swift
//  Alerts
//
//  Created by Dima on 31.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

enum AnonCoins: CaseIterable {
    case price_1
    case price_2
    case price_3
    case price_4
    case price_5
    case price_6
    
    static let allValues = [AnonCoins.price_1, AnonCoins.price_2, AnonCoins.price_3, AnonCoins.price_4, AnonCoins.price_5, AnonCoins.price_6]
    
    var image: UIImage {
        switch self {
        case .price_1:
            return Styles.Images.priceImage_1
        case .price_2:
            return Styles.Images.priceImage_2
        case .price_3:
            return Styles.Images.priceImage_3
        case .price_4:
            return Styles.Images.priceImage_4
        case .price_5:
            return Styles.Images.priceImage_5
        case .price_6:
            return Styles.Images.priceImage_6
        }
    }
    
    var price: Double {
        switch self {
        case .price_1:
            return 149.0
        case .price_2:
            return 299.0
        case .price_3:
            return 379.0
        case .price_4:
            return 459.0
        case .price_5:
            return 1490.0
        case .price_6:
            return 7490.0
        }
    }
    
    var amount: Int {
        switch self {
        case .price_1:
            return 50
        case .price_2:
            return 110
        case .price_3:
            return 150
        case .price_4:
            return 180
        case .price_5:
            return 720
        case .price_6:
            return 4000
        }
    }
}
