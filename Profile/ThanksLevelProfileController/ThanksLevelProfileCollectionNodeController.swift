//
//  ThanksLevelProfileCollectionNodeController.swift
//  Alerts
//
//  Created by Dima on 05.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class ThanksLevelProfileCollectionNodeController: ASViewController<ASCollectionNode> {
    
    // MARK: - Properties
    
    let premiumViewModel = PremiumAliasPriceCellModel(image: Styles.Images.premiumIcon,
                                                      title: "Anonym Premium",
                                                      additionalTitle: "Входит в подписку",
                                                      priceInfo: 499.0)
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()

    private let collectionNode: ASCollectionNode
    private var model: UserThanksLevelModel
    
    // MARK: - Init
    
    init(model: UserThanksLevelModel) {
        self.model = model
        collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        super.init(node: collectionNode)
        
        flowLayout.minimumLineSpacing = 24
        view.backgroundColor = Styles.Colors.Palette.bgDark
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionNode.dataSource = self
        collectionNode.delegate = self
        flowLayout.scrollDirection = .vertical
        collectionNode.registerSupplementaryNode(ofKind: UICollectionView.elementKindSectionHeader)
    }
}

// MARK: - Collection Data Source

extension ThanksLevelProfileCollectionNodeController: ASCollectionDataSource {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNode {
        
        let cellNode = ThanksLevelHeaderCollectionCellNode(model: model)
        return cellNode
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let model = premiumViewModel
        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = ProfileUniqueAliasPremiumCellNode(model: model)
            return cellNode
        }
        return cellNodeBlock
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, sizeRangeForHeaderInSection section: Int) -> ASSizeRange {
        switch section {
        case 0:
            let width = collectionNode.bounds.width
            return ASSizeRange(min: CGSize(width: width, height: .zero), max: CGSize(width: width, height: .infinity))
        default:
            return ASSizeRangeZero
        }
    }
}

// MARK: - Collection Delegate FlowLayout

extension ThanksLevelProfileCollectionNodeController: ASCollectionDelegateFlowLayout {
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let width = collectionNode.bounds.width - 24
        return ASSizeRange(min: CGSize(width: width, height: .zero), max: CGSize(width: width, height: .infinity))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 12, bottom: 12, right: 12)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        model = UserThanksLevelModel(image: UIImage(named: "photo")!, level: .fourth, thanksCount: 1341)
        collectionNode.reloadData()
    }
}
