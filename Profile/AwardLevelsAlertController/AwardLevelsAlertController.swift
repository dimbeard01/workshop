//
//  AwardLevelsAlertController.swift
//  Alerts
//
//  Created by Dima on 04.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class AwardLevelsAlertController: UIViewController {
    // MARK: - Properties
    private let awardLevelAlertNode: AwardLevelsAlertNode
    
    // MARK: - Init
    init(model: AwardLevelsAlertModel) {
        self.awardLevelAlertNode = AwardLevelsAlertNode(model: model)
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
        view.addSubnode(awardLevelAlertNode)
        
        let width = UIScreen.main.bounds.width
        let sizeRange = awardLevelAlertNode.calculateLayoutThatFits(
            ASSizeRange(
                min: .zero,
                max: CGSize(width: width, height: CGFloat.infinity)
            )
        )
        
        awardLevelAlertNode.view.centerInSuperview()
        awardLevelAlertNode.view.height(sizeRange.size.height)
        awardLevelAlertNode.view.width(view.frame.width - 48)
    }
    
    // MARK: - Helpers
    private func setupAlert() {
        awardLevelAlertNode.onDone = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}
