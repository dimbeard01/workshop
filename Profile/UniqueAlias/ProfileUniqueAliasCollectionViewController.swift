//
//  ProfileUniqueAliasCollectionViewController.swift
//  Alerts
//
//  Created by Dima on 20.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class ProfileUniqueAliasCollectionViewController: ASViewController<ASCollectionNode> {
    
    // MARK: - Properties
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    let collectionNode: ASCollectionNode
    
    let monthViewModel: [AliasPriceCellModel] = [
        AliasPriceCellModel(title: "1 Месяц",
                                additionalTitle: "Популярное",
                                priceInfo: 299.46,
                                price: 299.0),
        AliasPriceCellModel(title: "3 Месяцa",
                                additionalTitle: "без подписки",
                                priceInfo: 299.0,
                                price: 897.0),
        AliasPriceCellModel(title: "3 Месяцa",
                                additionalTitle: "лучший выбор",
                                priceInfo: 299.0,
                                price: 1794.0),
        AliasPriceCellModel(title: "12 Месяцев",
                                additionalTitle: "экономия 80%",
                                priceInfo: 299.0,
                                price: 3588.0)
    ]
    
    let premiumViewModel = PremiumAliasPriceCellModel(image: Styles.Images.premiumIcon,
                                                           title: "Anonym Premium",
                                                           additionalTitle: "Входит в подписку",
                                                           priceInfo: 499.0)
    
    let model: UniqueAliasUserModel
    
    // MARK: - Init
    
    init(model: UniqueAliasUserModel) {
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
        
        collectionNode.delegate = self
        collectionNode.dataSource = self
        flowLayout.scrollDirection = .vertical
        collectionNode.registerSupplementaryNode(ofKind: UICollectionView.elementKindSectionHeader)
        additionalSafeAreaInsets.top = -20
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

    // MARK: - Collection Data Source

extension ProfileUniqueAliasCollectionViewController: ASCollectionDataSource {
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
       return 3
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNode {
        let cellNode = ProfileUniqueAliasHeaderCellNode()
        return cellNode
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        switch indexPath.item {
        case 0:
            let cellModel = model
            let cellNodeBlock = { () -> ASCellNode in
                let cellNode = ProfileUniqueAliasUserInfoCellNode(model: cellModel)
                return cellNode
            }
            return cellNodeBlock
            
        case 1:
            if !model.state {
                let cellModel = premiumViewModel
                let cellNodeBlock = { () -> ASCellNode in
                    let cellNode = ProfileUniqueAliasPremiumCellNode(model: cellModel)
                    return cellNode
                }
                return cellNodeBlock
            } else {
                return { ASCellNode() }
            }
            
        case 2:
            let cellNodeBlock = { () -> ASCellNode in
                let cellNode = ProfileUniqueAliasAgreementCellNode()
                return cellNode
            }
            return cellNodeBlock
        default:
            return { ASCellNode() }
        }
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

extension ProfileUniqueAliasCollectionViewController: ASCollectionDelegateFlowLayout {
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
            let width = collectionNode.bounds.width - 24
            return ASSizeRange(min: CGSize(width: width, height: .zero), max: CGSize(width: width, height: .infinity))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 32, left: 12, bottom: 12, right: 12)
    }
}
