//
//  AlertView.swift
//  Alerts
//
//  Created by Dima on 25.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit
import TinyConstraints

enum ButtonType {
    case coloredBase(String, UIColor, () -> Void)
    case gradient(String, [UIColor], () -> Void)
    case base(String, () -> Void)
    case cancel(() -> Void)
}

final class AlertView: UIView {
        
    // MARK: - Properties

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Styles.Colors.Palette.gray2
        view.layer.cornerRadius = Styles.Sizes.cornerRadiusBase
        view.layer.masksToBounds = true
        return view
    }()
    
    private let circleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 52
        view.layer.masksToBounds = true
        return view
    }()
    
    private let cardImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
        
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
    
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    
    private var buttonTextColor: UIColor {
        switch theme {
        case .dark:
            return Styles.Colors.Palette.white
        case .light:
            return Styles.Colors.Palette.gray4
        default: return .white
        }
    }
    
    private var buttonBackgroundColor: UIColor {
        switch theme {
        case .dark:
            return Styles.Colors.Palette.gray3
        case .light:
            return Styles.Colors.Palette.white0
            default: return .white

        }
    }
    
    private var hiddenProfileImageName: String {
        switch theme {
        case .dark: return "darkHidden"
        case .light: return "lightHidden"
        default: return ""

        }
    }
    
    private var noProfileImageName: String {
        switch theme {
        case .dark: return "dark"
        case .light: return "light"
        default: return ""

        }
    }
    
    private var buttonTypes: [ButtonType] = []
    var theme: Theme
    private var baseGradientColor: [UIColor] = []
    private let type: AlertType
    
    // MARK: - Init
    
    init(type: AlertType, buttonTypes: [ButtonType], theme: Theme) {
        self.type = type
        self.titleLabel.text = type.title
        self.descriptionLabel.text = type.description
        self.buttonTypes = buttonTypes
        self.theme = theme
        self.containerView.backgroundColor = theme == Theme.dark ? Styles.Colors.Palette.gray2 : Styles.Colors.Palette.white

        super.init(frame: UIScreen.main.bounds)
        
        self.setupViews()
        self.setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Support
    
    private func makeButton(_ type: ButtonType) -> BaseTextButton {
        switch type {
        case .coloredBase(let title, let color, let action):
            let button = BaseTextButton()
                .setTitle(title: title)
                .setTextColor(color: Styles.Colors.Palette.white)
                .setButtonColor(color: color)
            button.action = action
            return button
            
        case .gradient(let title, let colors, let action):
            let button = BaseTextButton()
                .setTitle(title: title)
                .setTextColor(color: Styles.Colors.Palette.white)
            button.gradientColors = colors
            button.needGradient = true
            button.action = action
            return button
            
        case .base(let title, let action):
            let button = BaseTextButton()
                .setTitle(title: title)
                .setTextColor(color: buttonTextColor)
                .setButtonColor(color: buttonBackgroundColor)
            button.action = action
            return button
            
        case .cancel(let action):
            let button = BaseTextButton()
                .setTitle(title: "ОТМЕНА")
                .setTextColor(color: buttonTextColor)
                .setButtonColor(color: buttonBackgroundColor)
            button.action = action
            return button
        }
    }
    
    private func setupButtons() {
        let buttons = buttonTypes.map { makeButton($0) }
        buttons.forEach { button in
            buttonStackView.addArrangedSubview(button)
            button.height(Styles.Sizes.buttonMedium)
        }
    }
    
    // MARK: - Layout
      
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circleView.addGradient(colors: baseGradientColor,
                               locations: [0.0, 1.0],
                               startPoint: CGPoint(x: 1, y: 0),
                               endPoint: CGPoint(x: 0, y: 1))
    }
   
    private func setupViews() {
        switch type {
        case .message, .like, .interestingYou, .seeMore:
            setupLimitAlert()
            
        case .boostActivated:
            setupBoostActivatedAlert()
            
        case .hiddenProfile:
            setupHiddenProfileAlert()
            
        case .noProfile:
            setupNoProfileAlert()
            
        case .emptyFields, .removeProfile:
            setupContainerView()
            
            titleLabel.textColor = theme == Theme.dark ? Styles.Colors.Palette.white : Styles.Colors.Palette.gray3
            titleLabel.topToSuperview(offset: Styles.Sizes.VPaddingBase)
        }
    }
    
    private func setupLimitAlert() {
        baseGradientColor = type.gradientColor

        let backgroundImageView = UIImageView()
        backgroundImageView.contentMode = .scaleAspectFit
        let backgroundImage = UIImage(named: "group")
        backgroundImageView.image = backgroundImage
        backgroundImageView.alpha = 0.7
        
        containerView.addSubview(backgroundImageView)
        
        backgroundImageView.topToSuperview()
        backgroundImageView.leftToSuperview()
        backgroundImageView.rightToSuperview()
        
        setupContainerView()
        
        cardImageView.image = UIImage(named: type.imageName)
        
        addSubview(circleView)
        addSubview(cardImageView)
        
        cardImageView.center(in: circleView)
        let sizeCircleView: CGFloat = 104
        
        circleView.width(sizeCircleView)
        circleView.height(sizeCircleView)
        circleView.centerXToSuperview()
        circleView.bottomToTop(of: containerView, offset: sizeCircleView / 2)
        circleView.addGradient(colors: baseGradientColor,
                               locations: [0.0, 1.0],
                               startPoint: CGPoint(x: 1, y: 0),
                               endPoint: CGPoint(x: 0, y: 1))
        
        titleLabel.textColor = type.titleColor
        titleLabel.topToBottom(of: circleView, offset: 16)
    }
    
    private func setupBoostActivatedAlert() {
        baseGradientColor = type.gradientColor

        let backgroundImageView = UIImageView()
        backgroundImageView.contentMode = .scaleAspectFit
        let backgroundImage = UIImage(named: "group")
        backgroundImageView.image = backgroundImage
        backgroundImageView.alpha = 0.7
        
        containerView.addSubview(backgroundImageView)
        
        backgroundImageView.topToSuperview()
        backgroundImageView.leftToSuperview()
        backgroundImageView.rightToSuperview()
        
        setupContainerView()
        
        let userPhotoImageView = UIImageView()
        userPhotoImageView.image = UIImage(named: type.imageName)
        
        addSubview(userPhotoImageView)
        
        let sizeUserPhoto: CGFloat = 104
        userPhotoImageView.width(sizeUserPhoto)
        userPhotoImageView.height(sizeUserPhoto)
        userPhotoImageView.centerXToSuperview()
        userPhotoImageView.bottomToTop(of: containerView, offset: sizeUserPhoto / 2)
        
        let sizeCircleView: CGFloat = 40
        addSubview(circleView)
        circleView.bottom(to: userPhotoImageView)
        circleView.trailing(to: userPhotoImageView)
        circleView.height(sizeCircleView)
        circleView.width(sizeCircleView)
        circleView.layer.cornerRadius = sizeCircleView / 2
        
        circleView.addSubview(cardImageView)
        cardImageView.image = UIImage(named: AlertType.seeMore.imageName)
        cardImageView.topToSuperview(offset: Styles.Sizes.HPaddingMedium)
        cardImageView.leftToSuperview(offset: Styles.Sizes.VPaddingMedium)
        cardImageView.rightToSuperview(offset: -Styles.Sizes.VPaddingMedium)
        cardImageView.bottomToSuperview(offset: -Styles.Sizes.HPaddingMedium)
        
        titleLabel.textColor = type.titleColor
        titleLabel.topToBottom(of: userPhotoImageView, offset: 16)
    }
    
    private func setupHiddenProfileAlert(){
        setupContainerView()
        
        cardImageView.image = UIImage(named: hiddenProfileImageName)
        containerView.addSubview(cardImageView)
        
        cardImageView.topToSuperview(offset: Styles.Sizes.HPaddingBase)
        cardImageView.leftToSuperview(offset: Styles.Sizes.VPaddingBase)
        cardImageView.rightToSuperview(offset: -Styles.Sizes.VPaddingBase)
        
        titleLabel.textColor = theme == Theme.dark ? Styles.Colors.Palette.white : Styles.Colors.Palette.gray3
        titleLabel.topToBottom(of: cardImageView, offset: 15)
    }
    
    private func setupNoProfileAlert() {
        setupContainerView()
        
        cardImageView.image = UIImage(named: noProfileImageName)
        containerView.addSubview(cardImageView)
        
        cardImageView.topToSuperview(offset: Styles.Sizes.HPaddingBase)
        cardImageView.leftToSuperview(offset: Styles.Sizes.VPaddingBase)
        cardImageView.rightToSuperview(offset: -Styles.Sizes.VPaddingBase)
        
        titleLabel.textColor = theme == Theme.dark ? Styles.Colors.Palette.white : Styles.Colors.Palette.gray3
        titleLabel.topToBottom(of: cardImageView, offset: 15)
        
    }
    
    private func setupContainerView() {
        backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        addSubview(containerView)

        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(buttonStackView)
        containerView.centerInSuperview()
        containerView.widthToSuperview(multiplier: 0.87)
        
        titleLabel.leftToSuperview(offset: Styles.Sizes.VPaddingBase)
        titleLabel.rightToSuperview(offset: -Styles.Sizes.VPaddingBase)
        
        descriptionLabel.topToBottom(of: titleLabel, offset: Styles.Sizes.HPaddingMedium)
        descriptionLabel.leftToSuperview(offset: Styles.Sizes.VPaddingBase)
        descriptionLabel.rightToSuperview(offset: -Styles.Sizes.VPaddingBase)
        
        buttonStackView.topToBottom(of: descriptionLabel, offset: 15)
        buttonStackView.leftToSuperview(offset: Styles.Sizes.VPaddingBase)
        buttonStackView.rightToSuperview(offset: -Styles.Sizes.VPaddingBase)
        buttonStackView.bottomToSuperview(offset: -Styles.Sizes.HPaddingBase)
    }
    
    // MARK: - Internal

    func show() {
        UIView.animate(withDuration: Styles.Constants.animationDurationBase) {
            self.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: Styles.Constants.animationDurationBase, animations: {
            self.alpha = 0
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
}
