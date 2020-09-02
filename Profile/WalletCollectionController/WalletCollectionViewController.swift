//
//  WalletCollectionViewController.swift
//  Alerts
//
//  Created by Dima on 31.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class WalletCollectionViewController: ASViewController<ASCollectionNode> {
    // MARK: - Properties
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var backgroundImageNode: ASImageNode = {
        let node = ASImageNode()
        node.image = self.backgroundImageColor
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    private let collectionNode: ASCollectionNode
    private var model: [AnonCoins]

    // MARK: - Init
    init(model: [AnonCoins]) {
        self.model = model
        collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        super.init(node: collectionNode)
        
        flowLayout.minimumLineSpacing = 7
        flowLayout.minimumInteritemSpacing = 7
        
        ThemeManager.add(self)
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
        collectionNode.registerSupplementaryNode(ofKind: UICollectionView.elementKindSectionFooter)
        collectionNode.view.backgroundView = backgroundImageNode.view
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundImageNode.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    }
}

// MARK: - Collection Data Source
extension WalletCollectionViewController: ASCollectionDataSource {
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 2
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return model.count
        default:
            return 0
        }
    }
        
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNode {
        switch indexPath.section {
        case 1:
            if kind == UICollectionView.elementKindSectionHeader {
                return WalletHeaderCellNode()
            } else if kind == UICollectionView.elementKindSectionFooter {
                return WalletFooterCellNode()
            } else {
                return ASCellNode()
            }
        default:
            return ASCellNode() 
        }
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let coinsModel = model[indexPath.row]
        
        switch indexPath.section {
        case 0:
            let cellNodeBlock = { () -> ASCellNode in
                let cellNode = UserInfoWalletCellNode(model: 15)
                return cellNode
            }
            
            return cellNodeBlock
        case 1:
            let cellNodeBlock = { () -> ASCellNode in
                let cellNode = WalletCellNode(model: coinsModel)
                return cellNode
            }
            
            return cellNodeBlock
        default:
            return { ASCellNode() }
        }
    }
}

// MARK: - Collection Delegate FlowLayout
extension WalletCollectionViewController: ASCollectionDelegateFlowLayout {
    func collectionNode(_ collectionNode: ASCollectionNode, sizeRangeForHeaderInSection section: Int) -> ASSizeRange {
        let width = collectionNode.bounds.width
        return ASSizeRange(min: CGSize(width: width, height: .zero), max: CGSize(width: width, height: .infinity))
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, sizeRangeForFooterInSection section: Int) -> ASSizeRange {
        let width = collectionNode.bounds.width
        return ASSizeRange(min: CGSize(width: width, height: .zero), max: CGSize(width: width, height: .infinity))
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        switch indexPath.section {
        case 0:
            let width = collectionNode.bounds.width - 48
            return ASSizeRange(min: CGSize(width: width, height: .zero), max: CGSize(width: width, height: .infinity))
        case 1:
            let width = Int((collectionNode.bounds.width - 30) / 3)
            return ASSizeRange(min: CGSize(width: CGFloat(width), height: .zero), max: CGSize(width: CGFloat(width), height: .infinity))
        default:
            return ASSizeRange()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 120, left: 24, bottom: 40, right: 24)
        case 1:
            return UIEdgeInsets(top: 8, left: 8, bottom: 24, right: 8)
        default:
            return UIEdgeInsets.zero
        }
    }
}

//MARK: - Themeable
extension WalletCollectionViewController: Themeable {
    func updateTheme() {
        switch theme {
        case .light:
            view.backgroundColor = Styles.Colors.Palette.white
        case .dark:
            view.backgroundColor = Styles.Colors.Palette.bgDark
        }
    }
    
    var backgroundImageColor: UIImage {
        switch theme {
        case .light:
            return Styles.Images.walletBackgroundLight
        case .dark:
            return Styles.Images.walletBackgroundDark
        }
    }
}
