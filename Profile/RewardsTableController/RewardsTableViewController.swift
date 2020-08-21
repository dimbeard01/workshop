//
//  RewardsTableViewController.swift
//  Alerts
//
//  Created by Dima on 21.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class RewardsTableViewController: ASViewController<ASTableNode> {
    
    let tableNode: ASTableNode!
    let model: [UserRewardsModel]?
    
    // MARK: - Init
    
    init(model: [UserRewardsModel]){
        let tableNode = ASTableNode()
        self.tableNode = tableNode
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
        tableNode.allowsSelection = false
        tableNode.view.separatorStyle = .none
        tableNode.view.showsVerticalScrollIndicator = false
    }
}

extension RewardsTableViewController: ASTableDataSource {
   
       func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
       }
       
       func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard let model = model?[indexPath.row] else { return {ASCellNode()} }
        
        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = RewardsTableNodeCell(model: model)
            return cellNode
        }
        return cellNodeBlock
       }
       
       func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
           let width = UIScreen.main.bounds.width 
           return ASSizeRange(min: CGSize(width: width, height: .zero), max: CGSize(width: width, height: .infinity))
       }
}
