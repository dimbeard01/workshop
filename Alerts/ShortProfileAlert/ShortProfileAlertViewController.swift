//
//  ShortProfilePresentationViewController.swift
//  Alerts
//
//  Created by Dima on 30.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

final class ShortProfileAlertViewController: UIViewController {
    
    // MARK: - Properties
    
    var onAction: ((ActionType) -> Void)?
    
    private var userAlert: ShortProfileAlertView!
    private let userPhoto: UIImage
    private let userName: String
    private let isOnline: Bool
    private let timeWasOnline: String
    private let colorStyle: UIColor
    private let userAnswerList: [QuestionnaireModel]
    private let theme: Theme
    
    // MARK: - Init

    init(userPhoto: UIImage, userName: String, isOnline: Bool, colorStyle: UIColor, timeWasOnline: String, userAnswerList: [QuestionnaireModel], theme: Theme) {
        self.userPhoto = userPhoto
        self.userName = userName
        self.isOnline = isOnline
        self.colorStyle = colorStyle
        self.timeWasOnline = timeWasOnline
        self.userAnswerList = userAnswerList
        self.theme = theme
        
        super.init(nibName: nil, bundle: nil)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userAlert = ShortProfileAlertView(userPhoto: userPhoto,
                                                 userName: userName,
                                                 isOnline: isOnline,
                                                 colorStyle: colorStyle,
                                                 timeWasOnline: timeWasOnline,
                                                 userAnswerList: userAnswerList,
                                                 buttonTypes: makeButtons(color: colorStyle),
                                                 theme: theme)
        
        view.addSubview(userAlert)
        userAlert.alpha = 1
    }
    
    // MARK: - Support

    private func makeButtons(color: UIColor) -> (ButtonType, [ButtonType]) {
        return (ButtonType.coloredBase("ПОСМОТРЕТЬ АНКЕТУ".uppercased(), color, { [weak self] in self?.onAction?(.done) }),
                [ButtonType.coloredBase("НАЧАТЬ ОБЩЕНИЕ".uppercased(), color) { [weak self] in self?.onAction?(.done) },
                ButtonType.base("ОТКЛОНИТЬ".uppercased(), { [weak self] in self?.onAction?(.done) })])
    }
}
