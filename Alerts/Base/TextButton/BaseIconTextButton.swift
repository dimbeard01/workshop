//
//  BaseIconTextButton.swift
//  Alerts
//
//  Created by Dima on 09.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

class BaseIconTextButton: BaseTextButton {
    enum IconPosition: Int {
        case left
        case right
    }
    
    let icon: UIImageView = {
        let image = UIImageView()
        image.isHidden = true
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    private var iconColor: UIColor?
    private let iconPosition: IconPosition
    
    init(frame: CGRect = .zero, iconPosition: IconPosition = .left) {
        self.iconPosition = iconPosition
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        super.setupViews()
        
        stackView.insertArrangedSubview(icon, at: iconPosition.rawValue)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let iconSize = icon.sizeThatFits(size)
        let tilteLabelSize = tilteLabel.sizeThatFits(size)
        
        let height = max(iconSize.height, tilteLabelSize.height)
        
        return CGRect(origin: .zero, size: CGSize(width: iconSize.width + tilteLabelSize.width, height: height)).inset(by: insets.inverted()).size
    }
}

extension BaseIconTextButton {
    @discardableResult
    func setIcon(iconImage: UIImage?) -> Self {
        if let iconImage = iconImage?.withRenderingMode(.alwaysTemplate) {
            icon.image = iconImage
            icon.tintColor = iconColor
            
            icon.isHidden = false
        } else {
            icon.isHidden = true
        }
        
        self.layoutIfNeeded()
        
        return self
    }
    
    @discardableResult
    func setIconSize(size: CGSize) -> Self {
        icon.size(size)
        
        return self
    }
    
    @discardableResult
    func setIconColor(color: UIColor) -> Self  {
        iconColor = color
        icon.tintColor = color
        
        return self
    }
}
