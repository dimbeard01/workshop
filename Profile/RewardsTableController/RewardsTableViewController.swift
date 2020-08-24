//
//  RewardsTableViewController.swift
//  Alerts
//
//  Created by Dima on 21.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class RewardsTableViewController: ASViewController<ASTableNode> {
    
    // MARK: - Properties

    private let tableNode: ASTableNode = ASTableNode()
    private let model: [UserRewardsModel]?
    
    // MARK: - Init
    
    init(model: [UserRewardsModel]){
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
        //tableNode.allowsSelection = false
        tableNode.view.separatorStyle = .none
        tableNode.view.showsVerticalScrollIndicator = false
    }
}

    // MARK: - Table Data Source

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

extension RewardsTableViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        guard let model = model?[indexPath.row] else { return }
        let a = AlertViewController(type: .boostActivated, theme: .dark)
        present(a, animated: true, completion: nil)
        print("ss")
    }
}
