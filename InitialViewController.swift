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
        userAlertVC.onAction = { [weak self] (action) in
            switch action {
            case .done:
                self?.dismiss(animated: true, completion: nil)
            default:
                print("sds")
            }
        }
        
        let alertVC = AlertViewController(type: .noProfile, theme: Theme.light)
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
        
        let boostVC = BoostViewController()
    
        boostVC.onAction = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        
        let blurVC = BlurViewController()
        
        let collectionVC = FindsFeddCollectionViewController()
        
        let collectionProfileVC = ProfileUniqueAliasCollectionViewController()
        collectionProfileVC.modalPresentationStyle = .overFullScreen
        collectionProfileVC.modalTransitionStyle = .coverVertical
        
        let avatarProfileVC = ProfileUniqueAvatarController()
        avatarProfileVC.modalPresentationStyle = .overFullScreen
        avatarProfileVC.modalTransitionStyle = .coverVertical

        
        let model: [PreferenceEditProfileCellViewModel] = [
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo")!, title: "asfasf123"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "asfasf123"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo")!, title: "asda12"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "vcxw2"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "232ff"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo")!, title: "scsd21"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "ccc3"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo")!, title: "bfdfbdfwefwewdqwdqwdqwdqwdqwqfwefwefwefwef"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "wewet2efwe4t2ef2ef2ef2e"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo")!, title: "asfasf123"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "asfasf123"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo")!, title: "asda12"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "vcxw2"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "232ff"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo")!, title: "scsd21"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "ccc3"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo")!, title: "bfdfbdfgqergqfvqrfgqrv"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "wewet2efwe4t2ef2ef2ef2e"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo")!, title: "asfasf123"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "asfasf123"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo")!, title: "asda12"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "vcxw2"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "232ff"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo")!, title: "scsd21"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "ccc3"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo")!, title: "bfdfbdfgqergqfvqrfgqrv"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "wewet2efwe4t2ef2ef2ef2e"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo")!, title: "asfasf123"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "asfasf123"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo")!, title: "asda12"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "vcxw2"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "232ff"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo")!, title: "scsd21"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "ccc3"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo")!, title: "bfdfbdfgqergqfvqrfgqrv"),
            PreferenceEditProfileCellViewModel(userPhoto: UIImage(named: "photo2")!, title: "wewet2efwe4t2ef2ef2ef2e")
        ]
        
        let people = Listeners(model: model)
        
        let lisenersVC = MainEditProfileTableViewController(model: people)
        lisenersVC.modalPresentationStyle = .popover
        lisenersVC.modalTransitionStyle = .coverVertical
        
        lisenersVC.onCancelAction = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        
        lisenersVC.onDetailedAction = { [weak self] in
            lisenersVC.present(userAlertVC, animated: true, completion: nil)
        }
        
        
        let updateAliasVC = ProfileUniqueAliasViewController(model: UniqueAliasUserModel(userPhoto: UIImage(named: "photo2")!, userName: "Bobo Sisun", state: true))
        updateAliasVC.modalPresentationStyle = .overFullScreen
        updateAliasVC.modalTransitionStyle = .coverVertical
        
        present(updateAliasVC, animated: true, completion: nil)
    }
}
