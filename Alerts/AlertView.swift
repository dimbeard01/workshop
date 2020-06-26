//
//  AlertView.swift
//  Alerts
//
//  Created by Dima on 25.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit
import TinyConstraints

final class AlertView: UIView {
    
    // MARK: - Properties
    
//    var isHide: CGFloat = 0 {
//        didSet {
//            self.isHide = 1
//        }
//    }
    
    enum ButtonType {
        case base(String, UIColor, UIColor)
        case cancel
    }
    
    enum Theme {
        case dark
        case light
    }
    
    private let customAlertView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 20
        return view
    }()

    private let alertTitle: UILabel = {
        let label = UILabel()
        label.text = "Вы не заполнили обязательные поля"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private let alertDescription: UILabel = {
        let label = UILabel()
        label.text = "Для того что-бы пользоваться сервисом у вас должы быть заполнены все поля. Вы также можете выйти, но ваша анкета будет скрыта."
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var exitAndHideButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.backgroundColor = .red
//        button.setTitle("ВЫЙТИ И СКРЫТЬ АНКЕТУ", for: .normal)
        button.tintColor = .white
        button.tag = 0
        button.addTarget(self, action: #selector(exitOrCancelButtonsPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.backgroundColor = .black
        button.setTitle("ОТМЕНА", for: .normal)
        button.tintColor = .white
        button.tag = 1
        button.addTarget(self, action: #selector(exitOrCancelButtonsPressed), for: .touchUpInside)
        return button
    }()
    
    private let conteinerView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    
    static func makeButton(_ type: ButtonType) -> UIButton {
        switch type {
        case .base(let title, let textColor, let bgColor):
            return UIButton()
        default:
            return UIButton()
        }
    }
    
    private var theme: Theme = .dark
    private let buttonTypes: [ButtonType] = []
    
    // MARK: - Init
    
//    convenience init(buttons: [ButtonType]) {
//          self.buttonTypes = buttons
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundColor = .black
        alpha = 1
        
        addSubview(customAlertView)
        customAlertView.addSubview(alertTitle)
        customAlertView.addSubview(alertDescription)
        customAlertView.addSubview(conteinerView)

        conteinerView.addArrangedSubview(exitAndHideButton)
        conteinerView.addArrangedSubview(cancelButton)
        exitAndHideButton.height(44)
        
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButtons() {
        
//        AlertView.makeButton(ButtonType.base(<#T##String#>, buttonTitleColor, <#T##UIColor#>))
        let buttons = buttonTypes.map { AlertView.makeButton($0) }
        buttons.forEach { button in
            conteinerView.addArrangedSubview(button)
            button.height(44)
        }
        
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        customAlertView.center(in: self)
        customAlertView.width(to: self, multiplier: 0.87)
        alertTitle.edgesToSuperview(insets: .top(12) + .left(12) + .right(12) + .bottom(211))
        alertDescription.edgesToSuperview(insets: .top(64) + .left(12) + .right(12) + .bottom(123))
        conteinerView.edgesToSuperview(insets: .top(159) + .left(12) + .right(12) + .bottom(12))
    }
    
    // MARK: - Actions
    
    @objc private func exitOrCancelButtonsPressed(sender: UIButton) {
        switch sender.tag {
        case 0:
            print("EXIT AND HIDE PRESSED")
        case 1:
            print("CANCEL PRESSED")
        default:
            return
        }
    }
    
    var buttonTitleColor: UIColor {
        switch theme {
        case .dark:
            return .white
        case .light:
            return .black
        }
    }
}
