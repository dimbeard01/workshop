//
//  ShortProfilePresentationView.swift
//  Alerts
//
//  Created by Dima on 30.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

struct QuestionnaireModel {
    var question: String?
    var answer: String?
}

final class ShortProfileAlertView: UIView {
    
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
    
    private let onlineIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Styles.Colors.Palette.success1
        view.layer.borderWidth = 3
        view.layer.masksToBounds = true
        return view
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Styles.Fonts.Body1
        label.textAlignment = .center
        return label
    }()
    
    let dateDigits: Int
    
    private let timeWasOnlineLabel: UILabel = {
        let label = UILabel()
      
        label.textColor = Styles.Colors.Palette.gray5
        label.numberOfLines = 0
        label.font = Styles.Fonts.Caption2
        label.textAlignment = .center
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private let infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }()
    
    private var openProfileButton = BaseTextButton()
    private var buttonTypes: [ButtonType] = []
    private var userAnswerList: [QuestionnaireModel]?
    private let userPhoto: UIImage
    private var colorStyle: UIColor
    private var theme: Theme
    private var isOnline = false
    
    // MARK: - Init
    
    init(userPhoto: UIImage, userName: String, isOnline: Bool, colorStyle: UIColor, timeWasOnline: Int, userAnswerList: [QuestionnaireModel]?, buttonTypes: (ButtonType, [ButtonType]), theme: Theme) {
        self.userPhoto = userPhoto
        self.userNameLabel.text = userName
        self.isOnline = isOnline
        self.colorStyle = colorStyle
        self.dateDigits = timeWasOnline
        self.userAnswerList = userAnswerList
        self.buttonTypes = buttonTypes.1
        self.theme = theme
        
        super.init(frame: UIScreen.main.bounds)
        
        
        timeWasOnlineLabel.text = LastSeenDateFormatter().convertedDate(with: dateDigits)

        openProfileButton = makeOpenProfileButton(buttonTypes.0)
        setupViews()
        setupStackButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Support
    
    private func makeOpenProfileButton(_ type: ButtonType) -> BaseTextButton {
        switch type {
        case .coloredBase(let title, let color, let action):
            let button = BaseTextButton()
            button.setTitle(title: title)
            button.setButtonColor(color: color.withAlphaComponent(0.2))
            button.setTextColor(color: color)
            button.action = action
            return  button
        default: return BaseTextButton()
        }
    }
    
    private func makeStackButton(_ type: ButtonType) -> BaseTextButton {
        switch type {
        case .coloredBase(let title, let color, let action):
            let button = BaseTextButton()
                .setTitle(title: title)
                .setTextColor(color: Styles.Colors.Palette.white)
                .setButtonColor(color: color)
                .setTitleFont(font: Styles.Fonts.Tagline1)
            button.action = action
            return button
            
        case .base(let title, let action):
            let button = BaseTextButton()
                .setTitle(title: title)
                .setTextColor(color: colorStyle)
                .setButtonColor(color: .clear)
                .setTitleFont(font: Styles.Fonts.Tagline1)
            button.action = action
            return button
        default: return BaseTextButton()
        }
    }
    
    // MARK: - Layout
    
    private func setupStackButtons() {
        let buttons = buttonTypes.map { makeStackButton($0) }
        buttons.forEach { button in
            buttonStackView.addArrangedSubview(button)
            button.height(Styles.Sizes.buttonMedium)
        }
    }
    
    private func setupViews() {
        backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        containerView.backgroundColor = theme == Theme.dark ? Styles.Colors.Palette.gray2 : Styles.Colors.Palette.white
        
        addSubview(containerView)
        
        containerView.addSubview(userNameLabel)
        containerView.addSubview(timeWasOnlineLabel)
        containerView.centerYToSuperview(multiplier: 1.1)
        containerView.centerXToSuperview()
        
        containerView.widthToSuperview(multiplier: 0.95)
        
        let userPhotoImageView = UIImageView()
        userPhotoImageView.image = userPhoto
        
        addSubview(userPhotoImageView)
        
        let sizeUserPhoto: CGFloat = 92
        userPhotoImageView.width(sizeUserPhoto)
        userPhotoImageView.height(sizeUserPhoto)
        userPhotoImageView.centerXToSuperview()
        userPhotoImageView.bottomToTop(of: containerView, offset: sizeUserPhoto / 2)
        
        let sizeCircleView: CGFloat = 18
        
        if isOnline {
            addSubview(onlineIndicatorView)
            onlineIndicatorView.layer.borderColor = theme == Theme.dark ? Styles.Colors.Palette.gray2.cgColor : Styles.Colors.Palette.white.cgColor
            
            onlineIndicatorView.bottom(to: userPhotoImageView, offset: -5)
            onlineIndicatorView.right(to: userPhotoImageView, offset: -5)
            onlineIndicatorView.height(sizeCircleView)
            onlineIndicatorView.width(sizeCircleView)
            onlineIndicatorView.layer.cornerRadius = sizeCircleView / 2
        }
        
        userNameLabel.textColor = theme == Theme.dark ? Styles.Colors.Palette.white : Styles.Colors.Palette.gray3
        userNameLabel.topToBottom(of: userPhotoImageView, offset: 12)
        userNameLabel.leftToSuperview(offset: 16)
        userNameLabel.rightToSuperview(offset: -16)
        
        timeWasOnlineLabel.textColor = theme == Theme.dark ? Styles.Colors.Palette.gray4 : Styles.Colors.Palette.gray5
        timeWasOnlineLabel.topToBottom(of: userNameLabel, offset: Styles.Sizes.VPaddingMedium)
        timeWasOnlineLabel.leftToSuperview(offset: 16)
        timeWasOnlineLabel.rightToSuperview(offset: -16)
        setupStackViews()
    }
    
    private func setupStackViews() {
        if let userAnswerList = userAnswerList, !userAnswerList.isEmpty {
            containerView.addSubview(openProfileButton)
            containerView.addSubview(infoStackView)
            containerView.addSubview(buttonStackView)
            
            openProfileButton.topToBottom(of: timeWasOnlineLabel, offset: 15)
            openProfileButton.centerXToSuperview()
            openProfileButton.height(Styles.Sizes.buttonSmall)
            
            userAnswerList.forEach { info in
                let userInfoView = UserAnswerView()
                userInfoView.configure(userInfo: info, theme: theme)
                infoStackView.addArrangedSubview(userInfoView)
            }
            
            infoStackView.topToBottom(of: openProfileButton, offset: 12)
            infoStackView.leftToSuperview(offset: 16)
            infoStackView.rightToSuperview(offset: -16)
            
            buttonStackView.topToBottom(of: infoStackView, offset: 12)
            buttonStackView.leftToSuperview(offset: 16)
            buttonStackView.rightToSuperview(offset: -16)
            buttonStackView.bottomToSuperview(offset: -3)
        } else {
            containerView.addSubview(openProfileButton)
            containerView.addSubview(buttonStackView)
            
            openProfileButton.topToBottom(of: timeWasOnlineLabel, offset: 15)
            openProfileButton.centerXToSuperview()
            openProfileButton.height(Styles.Sizes.buttonSmall)
            
            buttonStackView.topToBottom(of: openProfileButton, offset: Styles.Sizes.VPaddingBase)
            buttonStackView.leftToSuperview(offset: 16)
            buttonStackView.rightToSuperview(offset: -16)
            buttonStackView.bottomToSuperview(offset: -3)
        }
    }
}

//
//extension Int {
//    func formatingData() -> String{
//        if let timeResult = (Double(self) as? Double) {
//            let date = Date(timeIntervalSince1970: timeResult)
//            let dateFormatter = DateFormatter()
//            //dateFormatter.dateFormat = "в hh:mm, dd MMMM"
//
//            dateFormatter.dateFormat = "в hh:mm, dd MMMM"
//
//            let b = date.month()
//            print(b)
//            let a = dateFormatter.calendar.component(Calendar.Component.month, from: date)
//            //dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
//            //dateFormatter.dateStyle = DateFormatter.Style.long //Set date style
//            dateFormatter.timeZone = .current
//            let localDate = dateFormatter.string(from: date)
//
//            let s = URLDateFormatter(12).stringFromDate()
//            print(s)
//            switch a {
//            case 11:
//                return "hh:mm dd "
//            default:
//                return "hh:mm dd Июля"
//            }
//        }
//    }
//}

