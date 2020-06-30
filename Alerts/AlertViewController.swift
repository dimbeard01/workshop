//
//  AlertViewController.swift
//  Alerts
//
//  Created by Dima on 25.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

enum ActionType {
    case detailed
    case openProfile
    case createProfile
    case activated
    case boostDetailed
    case done
    case hide
    case remove
    case exitAndHide
    case cancel(String)
}

enum AlertType {
    case message
    case like
    case interestingYou
    case seeMore
    case boostActivated
    case hiddenProfile
    case noProfile
    case emptyFields
    case removeProfile
    
    var title: String {
        switch self {
        case .message: return "Вы достигли лимита на отправку запросов на общение"
        case .like: return "Вы достигли лимита на отправку лайков"
        case .interestingYou: return "Показывай свою анкету только тем, кто тебе интересен!"
        case .seeMore: return "Окажись в центре внимания, тебя увидит гораздо больше людей!"
        case .boostActivated: return "Boost активирован"
        case .hiddenProfile: return "Ваша анкета скрыта"
        case .noProfile: return "У Вас еще нет анкеты Finds"
        case .emptyFields: return "Вы не заполнили обязательные поля"
        case .removeProfile: return "Удалить анкету"
        }
    }
    
    var description: String {
        switch self {
        case .message: return "С подпиской Finds+ ограничений не существует, попробуйте прямо сейчас."
        case .like: return "С подпиской Finds+ ограничений не существует, попробуйте прямо сейчас."
        case .interestingYou: return "С подпиской Finds+ ограничений не существует, попробуйте прямо сейчас."
        case .seeMore: return "С подпиской Finds+ ограничений не существует, попробуйте прямо сейчас."
        case .boostActivated: return "Ваша анкета будет выше в подборке у других пользователей"
        case .hiddenProfile: return "Чтобы отправлять запросы на общение и ставить лайки, откройте свою анкету."
        case .noProfile: return "Чтобы отправлять запросы на общение и ставить лайки, создайте анкету."
        case .emptyFields: return "Для того что-бы пользоваться сервисом у вас должы быть заполнены все поля. Вы также можете выйти, но ваша анкета будет скрыта."
        case .removeProfile: return "Вы уверены что хотите удалить анкету. Вы так же можете скрыть анкету, ее не увидят другие пользователи."
        }
    }
    
    var imageName: String {
        switch self {
        case .message: return "rectangle"
        case .like: return "star"
        case .interestingYou: return "finds"
        case .seeMore: return "boost"
        case .boostActivated: return "userPhoto"
        default: return ""
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .message: return #colorLiteral(red: 0.9294117647, green: 0.2980392157, blue: 0.4039215686, alpha: 1)
        case .like: return #colorLiteral(red: 0.2274509804, green: 0.4431372549, blue: 0.9333333333, alpha: 1)
        case .interestingYou: return #colorLiteral(red: 0.1019607843, green: 0.737254902, blue: 0.6117647059, alpha: 1)
        case .seeMore: return #colorLiteral(red: 0.1019607843, green: 0.737254902, blue: 0.6117647059, alpha: 1)
        case .boostActivated: return #colorLiteral(red: 0.1019607843, green: 0.737254902, blue: 0.6117647059, alpha: 1)
        default: return .black
        }
    }
    
    var gradientColor: [UIColor] {
        switch self {
        case .message: return Styles.Colors.Gradients.findsGradientColors
        case .like: return Styles.Colors.Gradients.addButtonGradientColors
        case .interestingYou: return Styles.Colors.Gradients.interestingYouGradientColors
        case .seeMore: return Styles.Colors.Gradients.findsBoostGradientColors
        case .boostActivated: return Styles.Colors.Gradients.findsBoostGradientColors
        default: return Styles.Colors.Gradients.findsBoostGradientColors
        }
    }
}

final class AlertViewController: UIViewController {
    
    // MARK: - Properties

    var onAction: ((ActionType) -> Void)?
    lazy var buttonTypes: [ButtonType] = []
    private var alertView: AlertView!
    private let theme: Theme
    private let type: AlertType
    
    // MARK: - Init

    init(type: AlertType, theme: Theme) {
        self.type = type
        self.theme = theme
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
   
        alertView = AlertView(type: type, buttonTypes: makeButtons(), theme: theme)
        view.addSubview(alertView)
        alertView.alpha = 1
    }
    
    // MARK: - Support

    private func makeButtons() -> [ButtonType] {
        switch type {
        case .message: return [ButtonType.gradient("ПОДРОБНЕЕ", type.gradientColor, { [weak self] in
            self?.onAction?(.detailed) })]
            
        case .like: return [ButtonType.gradient("ПОДРОБНЕЕ", type.gradientColor, { [weak self] in
            self?.onAction?(.detailed) })]
            
        case .interestingYou: return [ButtonType.gradient("АКТИВИРОВАТЬ", type.gradientColor, { [weak self] in
            self?.onAction?(.activated) })]
            
        case .seeMore: return [ButtonType.gradient("АКТИВИРОВАТЬ", type.gradientColor, { [weak self] in
            self?.onAction?(.activated) })]
            
        case .boostActivated: return [
            ButtonType.base("ГОТОВО", { [weak self] in
                self?.onAction?(.done) }),
            ButtonType.base("ПОДРОБНЕЕ О BOOST", { [weak self] in
                self?.onAction?(.boostDetailed) })]
            
        case .hiddenProfile:
            return theme == Theme.dark ? [ButtonType.coloredBase("ОТКРЫТЬ АНКЕТУ", Styles.Colors.Palette.purple1 , { [weak self] in
            self?.onAction?(.openProfile) })] : [ButtonType.coloredBase("ОТКРЫТЬ АНКЕТУ", Styles.Colors.Palette.pink1 , { [weak self] in
            self?.onAction?(.openProfile) })]

        case .noProfile:
            return theme == Theme.dark ? [ButtonType.coloredBase("СОЗДАТЬ АНКЕТУ", Styles.Colors.Palette.orange1 , { [weak self] in
            self?.onAction?(.createProfile) })] : [ButtonType.coloredBase("СОЗДАТЬ АНКЕТУ", Styles.Colors.Palette.green1 , { [weak self] in
            self?.onAction?(.createProfile) })]
            
        case .emptyFields: return [
            ButtonType.coloredBase("ВЫЙТИ И СКРЫТЬ АНКЕТУ", Styles.Colors.Palette.error1,{ [weak self] in
                self?.onAction?(.exitAndHide) }),
            ButtonType.cancel({ [weak self] in
                self?.onAction?(.cancel("transfer data")) })]
            
        case .removeProfile: return [
            ButtonType.coloredBase("УДАЛИТЬ АНКЕТУ", Styles.Colors.Palette.error1, { [weak self] in
                self?.onAction?(.remove) }),
            ButtonType.base("СКРЫТЬ", { [weak self] in
                self?.onAction?(.hide) }),
            ButtonType.cancel({ [weak self] in
                self?.onAction?(.cancel("transfer data")) })]
        }
    }
}
