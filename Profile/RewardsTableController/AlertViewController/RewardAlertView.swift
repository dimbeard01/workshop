//
//  RewardAlertView.swift
//  Alerts
//
//  Created by Dima on 24.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

final class RewardAlertView: UIView {
    
    // MARK: - Properties
    
    private let rewardImageView = UIImageView()
    private let titelLabel = UILabel()
    private let userNameLabel = UILabel()
    private let userDescriptionLabel = UILabel()
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Styles.Sizes.cornerRadiusBase
        view.layer.masksToBounds = true
        return view
    }()
    
    private let userPhotoImageView:  UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = Styles.Sizes.cornerRadiusBase
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private let rewardCoinsHStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 3
        return stack
    }()
    
    private let buttonTypes: [ButtonType] 
    private let model: RewardModel
    
    // MARK: - Init
    
    init(model: RewardModel, buttons: [ButtonType]) {
        self.model = model
        self.buttonTypes = buttons
        super.init(frame: UIScreen.main.bounds)
        
        updateRewardImage()
        updateTitle()
        updateUserPhotoImage()
        updateUserNameTitle()
        updateUserDescriprionTitle()
        
        setupViews()
        setupRewardCoinsHStack()
        setupStackButtons()
        
        ThemeManager.add(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout
    
    private func setupStackButtons() {
        let buttons = buttonTypes.map { makeStackButton($0) }
        buttons.forEach { button in
            buttonStackView.addArrangedSubview(button)
            button.height(Styles.Sizes.buttonMedium)
        }
    }
    
    private func setupRewardCoinsHStack() {
        var counter = 1
        model.reward.rewardCoins.forEach { (coin) in
            let coinsLabel = UILabel()
            coinsLabel.attributedText = updateCoinTitle(text: "+\(coin.count)")
            
            let divider = UILabel()
            divider.attributedText = updateCoinTitle(text: "/")
            
            let coinIconImage = UIImageView()
            coinIconImage.image = updateCoinImage(image: coin.image)
            coinIconImage.height(Styles.Sizes.iconSmall)
            coinIconImage.width(Styles.Sizes.iconSmall)
            
            rewardCoinsHStackView.addArrangedSubview(coinsLabel)
            rewardCoinsHStackView.addArrangedSubview(coinIconImage)
            
            if model.reward.rewardCoins.count != counter {
                rewardCoinsHStackView.addArrangedSubview(divider)
                counter += 1
            }
        }
    }
    
    private func setupViews() {
        backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        
        addSubview(containerView)
        
        containerView.centerInSuperview()
        containerView.widthToSuperview(multiplier: 0.87)
        
        addSubview(rewardImageView)
        
        let sizeRewardImage: CGFloat = 128
        rewardImageView.width(sizeRewardImage)
        rewardImageView.height(sizeRewardImage)
        rewardImageView.centerXToSuperview()
        rewardImageView.bottomToTop(of: containerView, offset: sizeRewardImage / 2)
        
        containerView.addSubview(titelLabel)
        
        titelLabel.topToBottom(of: rewardImageView, offset: 4)
        titelLabel.leftToSuperview(offset: Styles.Sizes.HPaddingBase)
        titelLabel.rightToSuperview(offset: -Styles.Sizes.HPaddingBase)
        
        containerView.addSubview(rewardCoinsHStackView)
        
        rewardCoinsHStackView.topToBottom(of: titelLabel)
        rewardCoinsHStackView.centerXToSuperview()
        
        let userInfoHContainerView = UIView()
        
        containerView.addSubview(userInfoHContainerView)
        
        userInfoHContainerView.topToBottom(of: rewardCoinsHStackView, offset: Styles.Sizes.VPaddingBase)
        userInfoHContainerView.leftToSuperview(offset: Styles.Sizes.HPaddingBase, relation: .equalOrGreater)
        userInfoHContainerView.rightToSuperview(offset: -Styles.Sizes.HPaddingBase, relation: .equalOrLess)
        userInfoHContainerView.centerXToSuperview()
        
        let userInfoVContainerView = UIView()
        
        userInfoVContainerView.addSubview(userNameLabel)
        userInfoVContainerView.addSubview(userDescriptionLabel)
        
        userNameLabel.topToSuperview()
        userNameLabel.leftToSuperview()
        userNameLabel.rightToSuperview()
        
        userDescriptionLabel.topToBottom(of: userNameLabel)
        userDescriptionLabel.leftToSuperview()
        userDescriptionLabel.rightToSuperview()
        userDescriptionLabel.bottomToSuperview()
        
        userInfoHContainerView.addSubview(userPhotoImageView)
        userInfoHContainerView.addSubview(userInfoVContainerView)
        
        let sizeUserPhoto: CGFloat = 40
        userPhotoImageView.width(sizeUserPhoto)
        userPhotoImageView.height(sizeUserPhoto)
        userPhotoImageView.topToSuperview()
        userPhotoImageView.leftToSuperview()
        userPhotoImageView.bottomToSuperview()
        
        userInfoVContainerView.leftToRight(of: userPhotoImageView, offset: Styles.Sizes.HPaddingMedium)
        userInfoVContainerView.rightToSuperview()
        userInfoVContainerView.centerYToSuperview()
        
        containerView.addSubview(buttonStackView)
        
        buttonStackView.topToBottom(of: userInfoHContainerView, offset: 15)
        buttonStackView.leftToSuperview(offset: Styles.Sizes.HPaddingBase)
        buttonStackView.rightToSuperview(offset: -Styles.Sizes.HPaddingBase)
        buttonStackView.bottomToSuperview(offset: -Styles.Sizes.VPaddingBase)
    }
    
    //MARK: - Helpers
    
    private func makeStackButton(_ type: ButtonType) -> BaseTextButton {
        switch type {
        case .base(let title, let action):
            let button = BaseTextButton()
                .setTitle(title: title)
                .setTextColor(color: buttonTextColor)
                .setButtonColor(color: buttonColor)
                .setTitleFont(font: Styles.Fonts.Tagline1)
            button.action = action
            return button
        default: return BaseTextButton()
        }
    }
    
    private func updateTitle() {
        let attributes = Attributes {
            return $0.foreground(color: titleColor)
                .font(Styles.Fonts.Body1)
                .alignment(.center)
                .lineBreakMode(.byTruncatingTail)
        }
        
        titelLabel.attributedText = NSAttributedString(string: model.reward.title, attributes: attributes.dictionary)
    }
    
    private func updateCoinTitle(text: String) -> NSAttributedString {
        let attributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.gray4)
                .font(Styles.Fonts.Caption3)
                .alignment(.left)
        }
        
        return NSAttributedString(string: text, attributes: attributes.dictionary)
    }
    
    private func updateUserNameTitle() {
        let attributes = Attributes {
            return $0.foreground(color: titleColor)
                .font(Styles.Fonts.Subhead1)
                .alignment(.left)
                .lineBreakMode(.byTruncatingTail)
        }
        
        userNameLabel.attributedText = NSAttributedString(string: model.name, attributes: attributes.dictionary)
    }
    
    private func updateUserDescriprionTitle() {
        let attributes = Attributes {
            return $0.foreground(color: descriptionTitleColor)
                .font(Styles.Fonts.Caption3)
                .alignment(.left)
                .lineBreakMode(.byTruncatingTail)
        }
        
        let dotSpacerAttributes = Attributes {
            return $0.foreground(color: Styles.Colors.Palette.gray4)
                .font(Styles.Fonts.Caption3)
                .alignment(.center)
        }
        
        let rewardReceivingAttributes = Attributes {
            return $0.foreground(color: descriptionTitleColor)
                .font(Styles.Fonts.Caption3)
                .alignment(.left)
                .lineBreakMode(.byTruncatingTail)
        }
        
        let mutableString = NSMutableAttributedString(string: model.event.rawValue, attributes: attributes.dictionary)
        
        mutableString.append(
            NSAttributedString(
                string: " \u{2022} ",
                attributes: dotSpacerAttributes.dictionary
            )
        )
        
        let rewardReceivingTime = RewardTimeFormatter().convertedDate(with: model.rewardTimeReceiving) ?? ""
        mutableString.append(
            NSAttributedString(
                string: "\(rewardReceivingTime)",
                attributes: rewardReceivingAttributes.dictionary
            )
        )
        
        userDescriptionLabel.attributedText = mutableString
    }
    
    private func updateRewardImage() {
        rewardImageView.image = model.reward.image
    }
    
    private func updateUserPhotoImage() {
        userPhotoImageView.image = model.photo
    }
    
    private func updateCoinImage(image: UIImage) -> UIImage {
        return image.withTintColor(Styles.Colors.Palette.gray4, renderingMode: .automatic)
    }
}

    // MARK: - Themeable

extension RewardAlertView: Themeable {
    func updateTheme() {
        switch theme {
        case .light:
            containerView.backgroundColor = Styles.Colors.Palette.white
        case .dark:
            containerView.backgroundColor = Styles.Colors.Palette.gray1
        }
    }
    
    var titleColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.gray3
        case .dark:
            return Styles.Colors.Palette.white0
        }
    }
    
    var descriptionTitleColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.gray5
        case .dark:
            return Styles.Colors.Palette.gray4
        }
    }
    
    var buttonColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.white0
        case .dark:
            return Styles.Colors.Palette.gray2
        }
    }
    
    var buttonTextColor: UIColor {
        switch theme {
        case .light:
            return Styles.Colors.Palette.gray4
        case .dark:
            return Styles.Colors.Palette.white0
        }
    }
}
