//
//  WalletAlertViewController.swift
//  Alerts
//
//  Created by Dima on 02.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class WalletAlertViewController: UIViewController {
    // MARK: - Properties
    private let walletAlertNode: WalletAlertNode
    
    // MARK: - Init
    init(model: Int) {
        self.walletAlertNode = WalletAlertNode(model: model)
        super.init(nibName: nil, bundle: nil)
    
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupAlert()
    }
    
    // MARK: - Layout
    private func setupViews() {
        view.addSubnode(walletAlertNode)
            
        let width = UIScreen.main.bounds.width
        let sizeRange = walletAlertNode.calculateLayoutThatFits(
            ASSizeRange(
                min: .zero,
                max: CGSize(width: width, height: CGFloat.infinity)
            )
        )
        
        walletAlertNode.view.centerInSuperview()
        walletAlertNode.view.height(sizeRange.size.height)
        walletAlertNode.view.width(view.frame.width)
    }
    
    // MARK: - Helpers
    private func setupAlert() {
        walletAlertNode.onDone = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}
