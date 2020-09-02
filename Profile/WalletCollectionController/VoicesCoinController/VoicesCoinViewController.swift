//
//  VoicesCoinViewController.swift
//  Alerts
//
//  Created by Dima on 02.09.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

final class VoicesCoinViewController: ASViewController<ASCollectionNode> {
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

    // MARK: - Init
    init() {
        collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        super.init(node: collectionNode)
                
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

        collectionNode.view.backgroundView = backgroundImageNode.view
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundImageNode.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    }
}

// MARK: - Collection Data Source
extension VoicesCoinViewController: ASCollectionDataSource {
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 2
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }
  

    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        switch indexPath.section {
        case 0:
            let cellNodeBlock = { () -> ASCellNode in
                let cellNode = VoicesUserInfoCellNode()
                return cellNode
            }
            
            return cellNodeBlock
        case 1:
            let cellNodeBlock = { () -> ASCellNode in
                let cellNode = VoicesWalletCellNode()
        
                return cellNode
            }
            
            return cellNodeBlock
        default:
            return { ASCellNode() }
        }
    }
}

// MARK: - Collection Delegate FlowLayout
extension VoicesCoinViewController: ASCollectionDelegateFlowLayout {
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        switch indexPath.section {
        case 0:
            let width = collectionNode.bounds.width - 48
            return ASSizeRange(min: CGSize(width: width, height: .zero), max: CGSize(width: width, height: .infinity))
        case 1:
            let width = collectionNode.bounds.width
            return ASSizeRange(min: CGSize(width: width, height: .zero), max: CGSize(width: width, height: .infinity))
        default:
            return ASSizeRange()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 120, left: 24, bottom: 32, right: 24)
        default:
            return UIEdgeInsets.zero
        }
    }
}

//MARK: - Themeable
extension VoicesCoinViewController: Themeable {
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
            return Styles.Images.voicesWalletBackgroundLight
        case .dark:
            return Styles.Images.voicesWalletBackgroundDark
        }
    }
}
