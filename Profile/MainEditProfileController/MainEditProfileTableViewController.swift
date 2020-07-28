//
//  MainEditProfileTableViewController.swift
//  Alerts
//
//  Created by Dima on 27.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class MainEditProfileTableViewController: ASViewController<ASTableNode> {
    
    // MARK: - Properties
    
    var onCancelAction: (() -> Void)?
    var onDetailedAction: (() -> Void)?
    
    let tableNode: ASTableNode!
    let model: Listeners!
    
    // MARK: - Init

    init(model: Listeners){
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

    // MARK: - Table data source

extension MainEditProfileTableViewController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 2
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return model.listenters.count
        default:
            return 0
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard let model = model else { return {ASCellNode()} }
        let cellModel = model.listenters[indexPath.row]

        switch indexPath.section {
        case 0:
            let cellNodeBlock = { () -> ASCellNode in
                let cellNode = PreferenceEditProfileHeaderCellNode(countModel: model)
                
                cellNode.onCancel = { [weak self] in
                    self?.onCancelAction?()
                }
                
                return cellNode
            }
            return cellNodeBlock
            
        case 1:
            let cellNodeBlock = { () -> ASCellNode in
                let cellNode = PreferenceEditProfileCellNode(model: cellModel)
                
                cellNode.onDetailed = { [weak self] in
                    self?.onDetailedAction?()
                }
                
                return cellNode
            }
            return cellNodeBlock
        
        default:
            return {ASCellNode()}
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let width = UIScreen.main.bounds.width * 0.96
        return ASSizeRange(min: CGSize(width: width, height: .zero), max: CGSize(width: width, height: .infinity))
    }
}

