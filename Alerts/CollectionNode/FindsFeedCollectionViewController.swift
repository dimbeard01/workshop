//
//  FindsFeedCollectionViewController.swift
//  Alerts
//
//  Created by Dima on 13.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class FindsFeddCollectionViewController: ASViewController<ASCollectionNode> {
    
    // MARK: - Properties
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    let collectionNode: ASCollectionNode
    let alertNodes = [FindsFeedPlaceholderNode(type: .noRequestAndLike), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode(), FindsFeedInactiveBoostNode()]
    let itemsSet = [[1],[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]]
    let profileItems = [1,2,3,4]
    // MARK: - Init
    
    init() {
        collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        
        super.init(node: collectionNode)
        
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 0
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionNode.delegate = self
        collectionNode.dataSource = self
        flowLayout.scrollDirection = .vertical
    }
}

    // MARK: - Collection Data Source

extension FindsFeddCollectionViewController: ASCollectionDataSource {
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 2
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return itemsSet[0].count
        case 1:
            return itemsSet[1].count
        default:
            return 1
        }
     }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let node = alertNodes[indexPath.item]
        
        switch indexPath.section {
        case 0:
            collectionNode.view.backgroundView = UIImageView(image: UIImage(named: "photo")!)

            let cellNodeBlock = { () -> ASCellNode in
                let cellNode = FindsFeedAlertCellNode(node: node)
                return cellNode
            }
            return cellNodeBlock
            
        case 1:
            collectionNode.view.backgroundView = UIImageView(image: UIImage(named: "photo2")!)

            let cellNodeBlock = { () -> ASCellNode in
                let cellNode = FindsFeedCellNode()
                return cellNode
            }
            return cellNodeBlock
            
        default:
            return { ASCellNode() }
        }
    }
    
}

// MARK: - Collection Delegate FlowLayout

extension FindsFeddCollectionViewController: ASCollectionDelegateFlowLayout {
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        switch indexPath.section {
        case 0:
            return ASSizeRange(min: CGSize(width: 359,
                                           height: 164),
                               max: CGSize(width: 359,
                                           height: 164))
        case 1:
            let width = (collectionNode.bounds.width - 23) / 2
            let height = width
            return ASSizeRange(min: CGSize(width: width, height: height), max: CGSize(width: width, height: .infinity))
        default:
            return ASSizeRange(min: .zero, max: .zero)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
