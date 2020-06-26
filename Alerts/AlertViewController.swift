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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let alertViewDark = AlertView(title: "Вы не заполнили обязательные поля",
                                      description: "Для того что-бы пользоваться сервисом у вас должы быть заполнены все поля. Вы также можете выйти, но ваша анкета будет скрыта.",
                                      buttonTypes: [ButtonType.base("ВЫЙТИ И СКРЫТЬ АНКЕТУ", { print("EXIT") }),
                                                    ButtonType.cancel({ print("CANCEL")})],
                                      theme: Themes.dark)
        
        alertViewLight = AlertView(title: "Удалить анкету",
                                       description: "Вы уверены что хотите удалить анкету. Вы так же можете скрыть анкету, ее не увидят другие пользователи.",
                                       buttonTypes: [ButtonType.base("УДАЛИТЬ", { self.remove() }),
                                                     ButtonType.hide({print("HIDE")}),
                                                     ButtonType.cancel({ print("CANCEL")}),],
                                       theme: Themes.light)
        view.addSubview(alertViewLight)
        alertViewLight.show()
    }
    
    func remove() {
        alertViewLight.hide()
    }
}
