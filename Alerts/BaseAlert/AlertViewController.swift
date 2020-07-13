//
//  AlertViewController.swift
//  Alerts
//
//  Created by Dima on 25.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

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
        case .message: return [ButtonType.gradient("ПОДРОБНЕЕ".uppercased(), type.gradientColor, { [weak self] in
            self?.onAction?(.detailed) })]
            
        case .like: return [ButtonType.gradient("ПОДРОБНЕЕ".uppercased(), type.gradientColor, { [weak self] in
            self?.onAction?(.detailed) })]
            
        case .interestingYou: return [ButtonType.gradient("АКТИВИРОВАТЬ".uppercased(), type.gradientColor, { [weak self] in
            self?.onAction?(.activated) })]
            
        case .seeMore: return [ButtonType.gradient("АКТИВИРОВАТЬ".uppercased(), type.gradientColor, { [weak self] in
            self?.onAction?(.activated) })]
            
        case .boostActivated: return [
            ButtonType.base("ГОТОВО".uppercased(), { [weak self] in
                self?.onAction?(.done) }),
            ButtonType.base("ПОДРОБНЕЕ О BOOST".uppercased(), { [weak self] in
                self?.onAction?(.boostDetailed) })]
            
        case .boostActivatedWithoutPhoto: return [
            ButtonType.base("ГОТОВО".uppercased(), { [weak self] in
                self?.onAction?(.done) })]
            
        case .hideProfile: return [
            ButtonType.base("ВЕРНУТЬ АНКЕТУ".uppercased(), { [weak self] in
                self?.onAction?(.done)}),
            ButtonType.base("СКРЫТЬ".uppercased(), { [weak self] in
                self?.onAction?(.done) })]
            
        case .emptyFields: return [
            ButtonType.coloredBase("ВЫЙТИ И СКРЫТЬ АНКЕТУ".uppercased(), Styles.Colors.Palette.error1,{ [weak self] in
                self?.onAction?(.exitAndHide) }),
            ButtonType.cancel({ [weak self] in
                self?.onAction?(.cancel("transfer data")) })]
            
        case .removeProfile: return [
            ButtonType.coloredBase("УДАЛИТЬ АНКЕТУ".uppercased(), Styles.Colors.Palette.error1, { [weak self] in
                self?.onAction?(.remove) }),
            ButtonType.base("СКРЫТЬ".uppercased(), { [weak self] in
                self?.onAction?(.hide) }),
            ButtonType.cancel({ [weak self] in
                self?.onAction?(.cancel("transfer data")) })]

            case .hiddenProfile:
                return theme == Theme.dark ? [ButtonType.coloredBase("ОТКРЫТЬ АНКЕТУ".uppercased(), Styles.Colors.Palette.purple1 , { [weak self] in
                self?.onAction?(.openProfile) })] : [ButtonType.coloredBase("ОТКРЫТЬ АНКЕТУ".uppercased(), Styles.Colors.Palette.pink1 , { [weak self] in
                self?.onAction?(.openProfile) })]

            case .noProfile:
                return theme == Theme.dark ? [ButtonType.coloredBase("СОЗДАТЬ АНКЕТУ".uppercased(), Styles.Colors.Palette.orange1 , { [weak self] in
                self?.onAction?(.createProfile) })] : [ButtonType.coloredBase("СОЗДАТЬ АНКЕТУ".uppercased(), Styles.Colors.Palette.green1 , { [weak self] in
                self?.onAction?(.createProfile) })]
        }
    }
}
