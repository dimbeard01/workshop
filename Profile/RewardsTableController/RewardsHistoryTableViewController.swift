//
//  RewardsHistoryTableViewController.swift
//  Alerts
//
//  Created by Dima on 21.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class RewardsHistoryTableViewController: ASViewController<ASTableNode> {
    
    // MARK: - Properties
    private let tableNode: ASTableNode = ASTableNode()
    private let model: [RewardModel]?
    
    // MARK: - Init
    init(model: [RewardModel]){
        self.model = model
        super.init(node: tableNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Styles.Colors.Palette.bgDark
        tableNode.dataSource = self
        tableNode.delegate = self
        tableNode.allowsSelection = false
        tableNode.view.separatorStyle = .none
        tableNode.view.showsVerticalScrollIndicator = false
    }
}

// MARK: - Table Data Source
extension RewardsHistoryTableViewController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard let model = model?[indexPath.row] else { return {ASCellNode()} }
        
        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = RewardsHistoryTableNodeCell(model: model)
            
            cellNode.onTapEnded = { [weak self] in
                let alert = RewardAlertViewController(model: model)
                alert.modalPresentationStyle = .overFullScreen
                alert.modalTransitionStyle = .crossDissolve
                
                self?.present(alert, animated: true, completion: nil)
            }
            
            return cellNode
        }
        
        return cellNodeBlock
    }
}

// MARK: - Table Delegate
extension RewardsHistoryTableViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let width = UIScreen.main.bounds.width
        return ASSizeRange(min: CGSize(width: width, height: .zero), max: CGSize(width: width, height: .infinity))
    }
}
