//
//  ShortProfilePresentationView.swift
//  Alerts
//
//  Created by Dima on 30.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

class ShortProfilePresentationView: UIView {
    
    // MARK: - Properties
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
          tableView.register(UserInfoTableViewCell.self, forCellReuseIdentifier: UserInfoTableViewCell.identifier)
          tableView.backgroundColor = .red
        

        return tableView
    }()
    
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
        view.layer.borderColor = Styles.Colors.Palette.white.cgColor
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
    
    private let timeWasOnlineLabel: UILabel = {
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
    
    private var buttonTypes: [ButtonType] = []
     let userPhoto: UIImage
    private var userInfo: [String]
    
    // MARK: - Init
    
    init(userPhoto: UIImage, buttonTypes: [ButtonType], theme: Theme, userInfo: [String]) {
        self.buttonTypes = buttonTypes
        self.userPhoto = userPhoto
        self.userNameLabel.text = "Сосо Пипус"
        self.timeWasOnlineLabel.text = "В 1950 году"
        self.userInfo = userInfo
        self.containerView.backgroundColor = theme == Theme.dark ? Styles.Colors.Palette.gray2 : Styles.Colors.Palette.white
      
        super.init(frame: UIScreen.main.bounds)
        
       tableView.dataSource = self
       tableView.delegate = self
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
        default: return BaseTextButton()
        }
    }
    
    private func setupButtons() {
        let buttons = buttonTypes.map { makeButton($0) }
        buttons.forEach { button in
            buttonStackView.addArrangedSubview(button)
            button.height(Styles.Sizes.buttonMedium)
        }
    }
    
    private func setupViews() {
        backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        addSubview(containerView)
        
        containerView.addSubview(userNameLabel)
        containerView.addSubview(timeWasOnlineLabel)
        containerView.addSubview(buttonStackView)
        containerView.centerInSuperview()
        containerView.widthToSuperview(multiplier: 0.87)
        
        let userPhotoImageView = UIImageView()
        userPhotoImageView.image = userPhoto
        
        addSubview(userPhotoImageView)
        
        let sizeUserPhoto: CGFloat = 92
        userPhotoImageView.width(sizeUserPhoto)
        userPhotoImageView.height(sizeUserPhoto)
        userPhotoImageView.centerXToSuperview()
        userPhotoImageView.bottomToTop(of: containerView, offset: sizeUserPhoto / 2)
        
        let sizeCircleView: CGFloat = 18
        addSubview(onlineIndicatorView)
        onlineIndicatorView.bottom(to: userPhotoImageView, offset: -5)
        onlineIndicatorView.trailing(to: userPhotoImageView, offset: -5)
        onlineIndicatorView.height(sizeCircleView)
        onlineIndicatorView.width(sizeCircleView)
        onlineIndicatorView.layer.cornerRadius = sizeCircleView / 2
        
        userNameLabel.topToBottom(of: userPhotoImageView, offset: 16)
        
        userNameLabel.topToBottom(of: userPhotoImageView, offset: 12)
        userNameLabel.leftToSuperview(offset: Styles.Sizes.VPaddingBase)
        userNameLabel.rightToSuperview(offset: -Styles.Sizes.VPaddingBase)
        
        timeWasOnlineLabel.topToBottom(of: userNameLabel, offset: Styles.Sizes.HPaddingMedium)
        timeWasOnlineLabel.leftToSuperview(offset: Styles.Sizes.VPaddingBase)
        timeWasOnlineLabel.rightToSuperview(offset: -Styles.Sizes.VPaddingBase)
        
        let button = BaseTextButton()
        button.setTitle(title: "ПОСМОТРЕТЬ АНКЕТУ")
        button.setTextColor(color: Styles.Colors.Palette.purple1)
        button.setButtonColor(color: #colorLiteral(red: 0.9489526153, green: 0.8863272071, blue: 0.9998814464, alpha: 1))
        button.setTitleFont(font: Styles.Fonts.Tagline2)
        
        containerView.addSubview(button)
        containerView.addSubview(tableView)

        button.centerXToSuperview()
        button.topToBottom(of: timeWasOnlineLabel, offset: 15)
        button.bottomToTop(of: tableView, offset: -15)
        
        
        tableView.topToBottom(of: button, offset: 15)
        tableView.leftToSuperview(offset: Styles.Sizes.VPaddingBase)
        tableView.rightToSuperview(offset: -Styles.Sizes.VPaddingBase)
        tableView.bottomToTop(of: buttonStackView, offset: -15)
            
            
        buttonStackView.topToBottom(of: tableView, offset: 15)
        buttonStackView.leftToSuperview(offset: Styles.Sizes.VPaddingBase)
        buttonStackView.rightToSuperview(offset: -Styles.Sizes.VPaddingBase)
        buttonStackView.bottomToSuperview(offset: -Styles.Sizes.HPaddingBase)
    }
    
    
}


extension ShortProfilePresentationView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoTableViewCell.identifier, for: indexPath) as? UserInfoTableViewCell else { return UITableViewCell()}
        print("D")
        let question = userInfo[indexPath.row]
        cell.configure(question: question, answer: question)
        return cell
    }
}

extension ShortProfilePresentationView: UITableViewDelegate {
    
}
