//
//  BaseIconButton.swift
//  Alerts
//
//  Created by Dima on 07.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

class BaseIconButton: BaseButton {
//    private var imageManager: ImageManager {
//        return ImageManager.shared
//    }
    
    var isSelected: Bool = false {
        didSet {
            if selecteble || manualSelecteble {
                setStatus(status: .normal)
                updateIcon()
            }
        }
    }
    
    var selecteble: Bool = false
    var manualSelecteble: Bool = false
    
    var needCorners = false {
        didSet {
            layoutSubviews()
        }
    }
    
    var status: ButtonStatus = ButtonStatus.normal {
        willSet {
            switch newValue {
            case .busy:
                showActivityIndicator()
                break
            case .normal:
                hideActivityIndicator()
                self.alpha = 1.0
                break
            case .deactive:
                hideActivityIndicator()
                self.alpha = 0.7
                break
            }
        }
    }
    
    internal let icon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    internal let activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.heightToWidth(of: activity)
        activity.isHidden = true
        
        return activity
    }()
    
    private var buttonColor: UIColor?
    
    private var iconColor: UIColor?
    private var iconSelectedColor: UIColor?
    
    private var iconImage: UIImage?
    private var iconSelectedImage: UIImage?
    
    private var iconSize: CGFloat?
    private var buttonSize: CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(icon)
        self.addSubview(activityIndicatorView)
        
        icon.leftToSuperview(offset: 0, relation: .equalOrGreater)
        icon.rightToSuperview(offset: 0, relation: .equalOrLess)
        icon.topToSuperview(offset: 0, relation: .equalOrGreater)
        icon.bottomToSuperview(offset: 0, relation: .equalOrLess)
        
        activityIndicatorView.leftToSuperview(offset: 0, relation: .equalOrGreater)
        activityIndicatorView.rightToSuperview(offset: 0, relation: .equalOrLess)
        activityIndicatorView.topToSuperview(offset: 0, relation: .equalOrGreater)
        activityIndicatorView.bottomToSuperview(offset: 0, relation: .equalOrLess)
        
        icon.centerInSuperview()
        activityIndicatorView.centerInSuperview()
    }
    
    private func updateIcon() {
        let iconImageR = (iconColor == nil) ? iconImage : iconImage?.withRenderingMode(.alwaysTemplate)
        let iconImageSelectedR = (iconSelectedColor == nil) ? iconSelectedImage : iconSelectedImage?.withRenderingMode(.alwaysTemplate)
        
        UIView.transition(with: self, duration: Styles.Constants.animationDurationSmall, options: .transitionCrossDissolve, animations: { [weak self] in
            guard let self = self else { return }
            
            if self.selecteble || self.manualSelecteble {
                if let iconSelectedImage = iconImageSelectedR {
                    self.icon.image = self.isSelected ? iconSelectedImage : iconImageR
                } else {
                    self.icon.image = iconImageR
                }
                
                self.icon.tintColor = self.isSelected ? self.iconSelectedColor : self.iconColor
            } else {
                self.icon.image = iconImageR
                self.icon.tintColor =  self.iconColor
            }
            }, completion: nil)
        
    }
    
    private func updateSize() {
        if let buttonSize = buttonSize {
            self.height(buttonSize)
            self.widthToHeight(of: self)
            
            if iconSize == nil {
                iconSize = buttonSize
            }
            
            activityIndicatorView.height(buttonSize)
        }
        
        if let iconSize = iconSize {
            icon.height(iconSize)
            icon.widthToHeight(of: icon)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if needCorners {
            self.makeRound()
        } else {
            self.setCornerRadius(radius: 0)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if status == .normal {
            if manualSelecteble {
                status = .busy
            } else if selecteble {
                isSelected = !isSelected
            }
            
            super.touchesEnded(touches, with: event)
        }
    }
}

extension BaseIconButton: BaseIconButtonProtocol {
    
    @discardableResult
    func setImage(image: UIImage) -> Self {
        iconImage = image
        updateIcon()
        
        return self
    }
//    
//    @discardableResult
//    func setImage(url: URL) -> Self {
//        UIImage.imageFrom(url) { (result) in
//            DispatchQueue.main.async { [weak self] in
//                guard let self = self else { return }
//                
//                switch result {
//                case .success(let image):
//                    self.iconImage = image
//                    self.updateIcon()
//                    
//                case .failure:
//                    break
//                }
//            }
//        }
//        
//        return self
//    }
//    
//    @discardableResult
//    func setSelectedImage(url: URL) -> Self {
//        UIImage.imageFrom(url) { (result) in
//            DispatchQueue.main.async { [weak self] in
//                guard let self = self else { return }
//                
//                switch result {
//                case .success(let image):
//                    self.iconSelectedImage = image
//                    self.updateIcon()
//                    
//                case .failure:
//                    break
//                }
//            }
//        }
//        
//        return self
//    }
    
    @discardableResult
    func setSelectedImage(image: UIImage) -> Self {
        iconSelectedImage = image.withRenderingMode(.alwaysTemplate)
        updateIcon()
        
        return self
    }
    
    @discardableResult
    func setButtonSize(height: CGFloat) -> Self {
        buttonSize = height
        updateSize()
        
        return self
    }
    
    @discardableResult
    func setIconSize(height: CGFloat) -> Self {
        iconSize = height
        updateSize()
        
        return self
    }
    
    @discardableResult
    func setButtonColor(color: UIColor?) -> Self {
        buttonColor = color
        backgroundColor = buttonColor
        
        return self
    }
    
    @discardableResult
    func setIconColor(color: UIColor?) -> Self {
        iconColor = color
        updateIcon()
        
        return self
    }
    
    @discardableResult
    func setIconSelectedColor(color: UIColor?) -> Self {
        iconSelectedColor = color
        updateIcon()
        
        return self
    }
}

extension BaseIconButton: BaseButtonStatusProtocol {
    @discardableResult
    func setStatus(status: BaseButton.ButtonStatus) -> Self {
        self.status = status
        
        return self
    }
    
    @discardableResult
    func updateStatus() -> Self {
        if status == .busy, !activityIndicatorView.isAnimating {
            activityIndicatorView.startAnimating()
        }
        
        return self
    }
    
    func showActivityIndicator() {
        UIView.animate(withDuration: Styles.Constants.animationDurationBase) { [weak self] in
            guard let self = self else { return }
            
            self.icon.isHidden = true
            self.activityIndicatorView.isHidden = false
            
            if self.isSelected {
                self.activityIndicatorView.color = self.iconSelectedColor ?? self.iconColor
            } else {
                self.activityIndicatorView.color = self.iconColor ?? .white
            }
            
            self.activityIndicatorView.startAnimating()
            
            self.layoutIfNeeded()
        }
    }
    
    func hideActivityIndicator() {
        UIView.animate(withDuration: Styles.Constants.animationDurationBase) { [weak self] in
            self?.icon.isHidden = false
            self?.activityIndicatorView.isHidden = true
            
            self?.activityIndicatorView.stopAnimating()
            
            self?.layoutIfNeeded()
        }
    }
}

