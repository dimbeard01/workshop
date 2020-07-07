//
//  InitialViewController.swift
//  Alerts
//
//  Created by Dima on 30.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: 400, width: 200, height: 55)
        button.setTitle("Show Alert", for: .normal)
        button.backgroundColor = .lightGray
        button.tintColor = .white
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        view.backgroundColor = .white
        view.addSubview(button)
    }
    
    @objc private func showAlert() {
        
        let userAnswerList = [QuestionnaireModel(question: "Любимый цвет?", answer: "Черный"),
                              QuestionnaireModel(question: "Ваш любимый участник проекта дом 2?", answer: "Елена Беркова"),
                              QuestionnaireModel(question: "О чем все знают?", answer: "Все знают, что я даже не скрываю!")]
        let userName = "Bruce Willis"
        let timeWasOnline = "в 21:00 сегодня"
        let userPhoto = UIImage(named: "userPhoto")!
        let colorStyle = Styles.Colors.Palette.green1
        let isOnline = true
        
        let userAlertVC = ShortProfileAlertViewController(userPhoto: userPhoto,
                                                                 userName: userName,
                                                                 isOnline: isOnline,
                                                                 colorStyle: colorStyle,
                                                                 timeWasOnline: timeWasOnline,
                                                                 userAnswerList: userAnswerList,
                                                                 theme: Theme.dark)
        
        userAlertVC.modalPresentationStyle = .overCurrentContext
        userAlertVC.modalTransitionStyle = .crossDissolve
        
        let alertVC = AlertViewController(type: .hideProfile, theme: Theme.light)
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.modalTransitionStyle = .crossDissolve
        
        alertVC.onAction = { [weak self] actionType in
            switch actionType {
            case .detailed :
                print("Detailed")
            case .activated:
                print("Activated")
            case .done:
                self?.dismiss(animated: true, completion: nil)
                print("Done")
            case .boostDetailed:
                print("See more about Boost")
            case .openProfile:
                self?.dismiss(animated: true, completion: nil)
                print("Open Profile")
            case .createProfile:
                print("Create Profile")
            case .exitAndHide:
                print("Exit and Hide")
            case .hide:
                print("Hide")
            case .remove:
                print("Remove")
            case .cancel(let string):
                print(string)
            }
        }
        
        let boostVC = BoostViewController(type: BoostAlertType.baseBoost, gradient: Styles.Colors.Gradients.findsBoostGradientColors, theme: .light)
        present(boostVC, animated: true, completion: nil)
    }
}
