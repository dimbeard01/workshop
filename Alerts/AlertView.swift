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
    case base(String, () -> Void)
    case hide(() -> Void)
    case cancel(() -> Void)
}

enum Themes {
    case dark
    case light
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Styles.Colors.Palette.white
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
        }
    }
    
    private var buttonBackgroundColor: UIColor {
        switch theme {
        case .dark:
            return Styles.Colors.Palette.gray3
        case .light:
            return Styles.Colors.Palette.white0
        }
    }
    
    private var buttonTypes: [ButtonType] = []
    private var theme: Themes
    
    // MARK: - Init

    init(title: String, description: String, buttonTypes: [ButtonType], theme: Themes) {
        self.titleLabel.text = title
        self.titleLabel.textColor = theme == Themes.dark ? Styles.Colors.Palette.white : Styles.Colors.Palette.gray3
        self.descriptionLabel.text = description
        self.buttonTypes = buttonTypes
        self.theme = theme
        self.containerView.backgroundColor = theme == Themes.dark ? Styles.Colors.Palette.gray2 : Styles.Colors.Palette.white
        
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
        case .base(let title, let action):
            let button = BaseTextButton()
            button.setTitle(title: title)
            button.setTextColor(color: Styles.Colors.Palette.white)
            button.setButtonColor(color: Styles.Colors.Palette.error1)
            button.action = action
            return button
            
        case .hide(let action):
            let button = BaseTextButton()
            button.setTitle(title: "СКРЫТЬ")
            button.setTextColor(color: buttonTextColor)
            button.setButtonColor(color: buttonBackgroundColor)
            button.action = action
            return button
            
        case .cancel(let action):
            let button = BaseTextButton()
            button.setTitle(title: "ОТМЕНА")
            button.setTextColor(color: buttonTextColor)
            button.setButtonColor(color: buttonBackgroundColor)
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
    
    private func setupViews() {
        alpha = 0
        
        backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(buttonStackView)
        
        containerView.centerInSuperview()
        containerView.widthToSuperview(multiplier: 0.87)
        
        titleLabel.topToSuperview(offset: Styles.Sizes.VPaddingBase)
        titleLabel.leftToSuperview(offset: Styles.Sizes.HPaddingBase)
        titleLabel.rightToSuperview(offset: -Styles.Sizes.HPaddingBase)
        
        descriptionLabel.topToBottom(of: titleLabel, offset: Styles.Sizes.VPaddingMedium)
        descriptionLabel.leftToSuperview(offset: Styles.Sizes.HPaddingBase)
        descriptionLabel.rightToSuperview(offset: -Styles.Sizes.HPaddingBase)
        
        buttonStackView.topToBottom(of: descriptionLabel, offset: 15)
        buttonStackView.leftToSuperview(offset: Styles.Sizes.HPaddingBase)
        buttonStackView.rightToSuperview(offset: -Styles.Sizes.HPaddingBase)
        buttonStackView.bottomToSuperview(offset: -Styles.Sizes.VPaddingBase)
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
