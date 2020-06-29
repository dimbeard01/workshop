//
//  AlertViewController.swift
//  Alerts
//
//  Created by Dima on 25.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

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
    
    var buttonType: [ButtonType] {
        switch self {
        case .message: return [ButtonType.gradient("ПОДРОБНЕЕ", AlertType.message.gradientColor, { print("MESSEGE") })]
        case .like: return [ButtonType.gradient("ПОДРОБНЕЕ", AlertType.like.gradientColor, { print("LIKE") })]
        case .interestingYou: return [ButtonType.gradient("АКТИВИРОВАТЬ", AlertType.interestingYou.gradientColor, { print("INTERESTING YOU") })]
        case .seeMore: return [ButtonType.gradient("АКТИВИРОВАТЬ", AlertType.seeMore.gradientColor, { print("SEE MORE") })]
        case .boostActivated: return [ButtonType.base("ГОТОВО", { print("BOOST ACTIVATED") }), ButtonType.base("ПОДРОБНЕЕ О BOOST", { print("BOOST ACTIVATED") })]
        case .emptyFields: return [ButtonType.coloredBase("ВЫЙТИ И СКРЫТЬ АНКЕТУ", Styles.Colors.Palette.error1,{ print("EMPTY FIELDS")}), ButtonType.cancel({ print("CANCEL") })]
        case .removeProfile: return [ButtonType.coloredBase("УДАЛИТЬ АНКЕТУ", Styles.Colors.Palette.error1, { print("HIDDEN PROFILE")}), ButtonType.base("СКРЫТЬ", { print("REMOVE PROFILE") }), ButtonType.cancel({ print("CANCEL") })]
        default: return [ButtonType.base("ГОТОВО", { print("BOOST ACTIVATED") })]
        }
    }
}

final class AlertViewController: UIViewController {
    
    // MARK: - LifeCycle
    
    var alertView: AlertView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
   
        alertView = AlertView(type: AlertType.boostActivated, theme: Themes.light)
        
        view.addSubview(alertView)
        alertView.show()
    }
    
    func remove() {
        alertView.hide()
    }
}
