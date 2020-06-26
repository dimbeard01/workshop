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
    
    private let customAlertView: UIView = {
        let view = UIView()
        view.backgroundColor = Styles.Colors.Palette.gray2
        view.layer.cornerRadius = Styles.Sizes.cornerRadiusBase
        return view
    }()
    
    private let alertTitle: UILabel = {
        let label = UILabel()
        label.textColor = Styles.Colors.Palette.white
        label.numberOfLines = 0
        label.font = Styles.Fonts.Body1
        label.textAlignment = .center
        return label
    }()
    
    private let alertDescription: UILabel = {
        let label = UILabel()
        label.textColor = Styles.Colors.Palette.gray4
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private let conteinerView: UIStackView = {
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
        self.alertTitle.text = title
        self.alertTitle.textColor = theme == Themes.dark ? Styles.Colors.Palette.white : Styles.Colors.Palette.gray3
        self.alertDescription.text = description
        self.buttonTypes = buttonTypes
        self.theme = theme
        self.customAlertView.backgroundColor = theme == Themes.dark ? Styles.Colors.Palette.gray2 : Styles.Colors.Palette.white
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
        let buttons = buttonTypes.map { self.makeButton($0) }
        buttons.forEach { button in
            conteinerView.addArrangedSubview(button)
            button.height(Styles.Sizes.buttonMedium)
        }
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        alpha = 0
        
        backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        addSubview(customAlertView)
        customAlertView.addSubview(alertTitle)
        customAlertView.addSubview(alertDescription)
        customAlertView.addSubview(conteinerView)
        
        customAlertView.center(in: self)
        customAlertView.width(to: self, multiplier: 0.87)
        
        alertTitle.topToSuperview(offset: Styles.Sizes.VPaddingBase)
        alertTitle.leftToSuperview(offset: Styles.Sizes.HPaddingBase)
        alertTitle.rightToSuperview(offset: -Styles.Sizes.HPaddingBase)
        alertTitle.bottomToTop(of: alertDescription, offset: -Styles.Sizes.VPaddingMedium)
        
        alertDescription.leftToSuperview(offset: Styles.Sizes.HPaddingBase)
        alertDescription.rightToSuperview(offset: -Styles.Sizes.HPaddingBase)
        alertDescription.bottomToTop(of: conteinerView, offset: -15)
        
        conteinerView.leftToSuperview(offset: Styles.Sizes.HPaddingBase)
        conteinerView.rightToSuperview(offset: -Styles.Sizes.HPaddingBase)
        conteinerView.bottomToSuperview(offset: -Styles.Sizes.VPaddingBase)
    }
    
    // MARK: - Public
    
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
