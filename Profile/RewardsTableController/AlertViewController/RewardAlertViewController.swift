//
//  RewardAlertViewController.swift
//  Alerts
//
//  Created by Dima on 24.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

final class RewardAlertViewController: UIViewController {
    // MARK: - Properties
    var onAction: ((ActionType) -> Void)?
    
    private let model: RewardModel
    
    // MARK: - Init
    init(model: RewardModel) {
        self.model = model  
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userAlert = RewardAlertView(model: model, buttons: makeButtons())
        view.addSubview(userAlert)
    }
    
    // MARK: - Helpers
    private func makeButtons() -> ([ButtonType]) {
        switch model {
        case is AnonUserReward:
            return [ButtonType.base("Перейти к \(model.event.localizedType)".uppercased(), { [weak self] in self?.onAction?(.done)})]
        default:
            return [ButtonType.base("Перейти к \(model.event.localizedType)".uppercased(), { [weak self] in self?.onAction?(.done)}),
                    ButtonType.base("Перейти к пользователю".uppercased(), { [weak self] in self?.onAction?(.done)})]
        }
    }
}
