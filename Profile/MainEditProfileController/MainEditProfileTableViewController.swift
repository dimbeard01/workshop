//
//  MainEditProfileTableViewController.swift
//  Alerts
//
//  Created by Dima on 27.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class MainEditProfileTableViewController: ASViewController<ASTableNode> {
 
    let tableNode: ASTableNode!
    let model: [PreferenceEditProfileCellViewModel]!
    
    init(model: [PreferenceEditProfileCellViewModel]){
        let tableNode = ASTableNode()
        self.tableNode = tableNode
        self.model = model
        super.init(node: tableNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableNode.dataSource = self
        tableNode.allowsSelection = false
        tableNode.view.separatorStyle = .none
        tableNode.view.showsVerticalScrollIndicator = false
    }
}

extension MainEditProfileTableViewController: ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellModel = model[indexPath.row]
        
        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = PreferenceEditProfileCellNode(model: cellModel)
            return cellNode
        }
        return cellNodeBlock
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let width = UIScreen.main.bounds.width * 0.96
        return ASSizeRange(min: CGSize(width: width, height: .zero), max: CGSize(width: width, height: .infinity))
    }
    
}
