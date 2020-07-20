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
    
    let monthViewModel: [AliasPriceCellViewModel] = [
        AliasPriceCellViewModel(title: "1 Месяц", additionalTitle: "Популярное", priceInfo: 299.46, price: 299.0),
        AliasPriceCellViewModel(title: "3 Месяцa", additionalTitle: "без подписки", priceInfo: 299.0, price: 897.0),
        AliasPriceCellViewModel(title: "3 Месяцa", additionalTitle: "лучший выбор", priceInfo: 299.0, price: 1794.0),
        AliasPriceCellViewModel(title: "12 Месяцев", additionalTitle: "экономия 80%", priceInfo: 299.0, price: 3588.0)
    ]
    
    let premiumViewModel = [PremiumAliasPriceCellViewModel(image: Styles.Images.premiumIcon, title: "Anonym Premium", additionalTitle: "Входит в подписку", priceInfo: 499.0)]

    // MARK: - Init
    
    init() {
        collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        
        super.init(node: collectionNode)
        
        flowLayout.minimumLineSpacing = 12
        flowLayout.minimumInteritemSpacing = 0
        view.backgroundColor = Styles.Colors.Palette.bgDark
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

extension ProfileUniqueAliasCollectionViewController: ASCollectionDataSource {
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 2
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return monthViewModel.count
        case 1:
            return premiumViewModel.count
        default:
            return 0
        }
     }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        switch indexPath.section {
        case 0:
            let cellModel = monthViewModel[indexPath.item]
            let cellNodeBlock = { () -> ASCellNode in
                let cellNode = ProfileUniqueAliasCellNode(model: cellModel)
                return cellNode
            }
            return cellNodeBlock
            
        case 1:
            let cellModel = premiumViewModel[indexPath.item]
            let cellNodeBlock = { () -> ASCellNode in
                let cellNode = ProfileUniqueAliasPremiumCellNode(model: cellModel)
                return cellNode
            }
            return cellNodeBlock
        default:
            return {ASCellNode()}
        }
    }
}

// MARK: - Collection Delegate FlowLayout

extension ProfileUniqueAliasCollectionViewController: ASCollectionDelegateFlowLayout {
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        switch indexPath.section {
        case 0:
            let width = (collectionNode.bounds.width - 37) / 2
            return ASSizeRange(min: CGSize(width: width, height: .zero), max: CGSize(width: width, height: .infinity))
        case 1:
            let width = collectionNode.bounds.width - 24
              return ASSizeRange(min: CGSize(width: width, height: .zero), max: CGSize(width: width, height: .infinity))
        default:
            let width = collectionNode.bounds.width
            return ASSizeRange(min: CGSize(width: width, height: .zero), max: CGSize(width: width, height: .infinity))
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12)
    }
}

extension ProfileUniqueAliasCollectionViewController: ASCollectionDelegate {
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didDeselectItemAt indexPath: IndexPath) {
        collectionNode.deselectItem(at: indexPath, animated: true)
    }
}
