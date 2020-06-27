//
//  CardAlertView.swift
//  Alerts
//
//  Created by Dima on 27.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit
import TinyConstraints

enum CardButtonType {
    case base(String, UIColor, () -> Void)
}

final class CardAlertView {
    
    //MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Styles.Fonts.Body1
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Styles.Colors.Palette.gray4
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    
}
