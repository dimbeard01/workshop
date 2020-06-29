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
    
    var alertView: AlertView!
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let cardImage = UIImage(named: "darkHidden")
        let subscriptionImage = UIImage(named: "boost")
        let userPhoto = UIImage(named: "userPhoto")
        let gradient = Styles.Colors.Gradients.findsBoostGradientColors

        alertView = AlertView(image: subscriptionImage,
                              userPhoto: userPhoto,
                              gradient: gradient,
                              title: "Вы достигли лимита на отправку запросов на общение",
                              description: "С подпиской Finds+ ограничений не существует, попробуйте прямо сейчас",
                              buttonTypes: [ButtonType.gradient("ПОДРОБНЕЕ", gradient, {
                                print("подробнее")
                              }) , ButtonType.coloredBase("ГОТОВО", Styles.Colors.Palette.purple1, { self.remove() }), ButtonType.base("ОТМЕНА", {
                                print("cancel")
                              })],
                              theme: Themes.light)
        
        view.addSubview(alertView)
        alertView.show()
    }
    
    func remove() {
        alertView.hide()
    }
}
