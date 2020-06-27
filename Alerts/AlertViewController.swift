//
//  AlertViewController.swift
//  Alerts
//
//  Created by Dima on 25.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

final class AlertViewController: UIViewController {
    
    // MARK: - LifeCycle
    
    var alertViewLight: AlertView!
    var alertViewDark: AlertView!
    var cardAlertView: AlertView!
    var subscriptionAlertView: AlertView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let cardImage = UIImage(named: "lightHidden")
        let subscriptionImage = UIImage(named: "Star")
        
        
        alertViewDark = AlertView(title: "Вы не заполнили обязательные поля",
                                      description: "Для того что-бы пользоваться сервисом у вас должы быть заполнены все поля. Вы также можете выйти, но ваша анкета будет скрыта.",
                                      buttonTypes: [ButtonType.base("ВЫЙТИ И СКРЫТЬ АНКЕТУ", Styles.Colors.Palette.error1, { self.remove(); print("EXIT") }),
                                                    ButtonType.cancel({ print("CANCEL")})],
                                      theme: Themes.light)
        
        alertViewLight = AlertView(title: "Удалить анкету",
                                       description: "Вы уверены что хотите удалить анкету. Вы так же можете скрыть анкету, ее не увидят другие пользователи.",
                                       buttonTypes: [ButtonType.base("УДАЛИТЬ", Styles.Colors.Palette.error1, { self.remove() }),
                                                     ButtonType.hide({ print("HIDE")}),
                                                     ButtonType.cancel({ print("CANCEL")}),],
                                       theme: Themes.dark)
        
        cardAlertView = AlertView(image: cardImage!,
                                  title: "Ваша анкета скрыта",
                                  description: "Чтобы отправлять запросы на общение и ставить лайки, откройте свою анкету.",
                                  buttonTypes: [ButtonType.base("ОТКРЫТЬ АНКЕТУ", Styles.Colors.Palette.pink1, { print("OPEN")})],
                                  theme: Themes.light)
        
        subscriptionAlertView = AlertView(image: subscriptionImage!,
                                  color: Styles.Colors.Gradients.findsGradientColors,
                                  title: "Вы достигли лимита на отправку запросов на общение",
                                  description: "С подпиской Finds+ ограничений не существует, попробуйте прямо сейчас",
                                  buttonTypes: [ButtonType.gradient("ПОДРОБНЕЕ", Styles.Colors.Gradients.findsGradientColors, { print("OPEN")})],
                                  theme: Themes.light)
        
        view.addSubview(subscriptionAlertView)
        subscriptionAlertView.show()
    }
    
    func remove() {
        subscriptionAlertView.hide()
    }
}
