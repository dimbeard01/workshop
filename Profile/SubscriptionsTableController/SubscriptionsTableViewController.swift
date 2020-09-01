//
//  SubscriptionsTableViewController.swift
//  Alerts
//
//  Created by Dima on 28.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import AsyncDisplayKit

enum Subscriptions {
    case premium(isActive: Bool)
    case findsPlus(isActive: Bool)
    case uniqueAlias(isActive: Bool)
    
    var title: String {
        switch self {
        case .premium:
            return "Premium"
        case .findsPlus:
            return "Finds+"
        case .uniqueAlias:
            return "Уникальный Псевдоним"
        }
    }
    
    var icon: UIImage {
        switch self {
        case .premium:
            return Styles.Images.premiumSubscriptionIcon
        case .findsPlus:
            return Styles.Images.findsPlusSubscriptionIcon
        case .uniqueAlias:
            return Styles.Images.uniqueAliasSubscriptionIcon
        }
    }
    
    var description: String {
        switch self {
        case .premium:
            return "Anonym Premium открывает новые возможности и дарит творчеству максимальную свободу."
        case .findsPlus:
            return "Получи доступ к возможностям Finds+, чтобы встретить новых друзей и в полной мере насладиться общением."
        case .uniqueAlias:
            return "Текст про уникальный псевдоним.Текст про уникальный псевдоним.Текст про уникальный псевдоним."
        }
    }
    
    var colors: [UIColor] {
        switch self {
        case .premium:
            return Styles.Colors.Gradients.premiumColors
        case .findsPlus:
            return Styles.Colors.Gradients.findsPlusColors
        case .uniqueAlias:
            return Styles.Colors.Gradients.uniqueAliasColors
        }
    }
    
    var paymentPrice: Double {
        switch self {
        case .premium:
            return 599.0
        case .findsPlus:
            return 399.0
        case .uniqueAlias:
            return 299.0
        }
    }
}

final class SubscriptionsTableViewController: ASViewController<ASTableNode> {
    
    // MARK: - Properties
    
    private let tableNode: ASTableNode = ASTableNode()
    private let model: [Subscriptions]?
    
    // MARK: - Init
    
    init(model: [Subscriptions]){
        self.model = model
        super.init(node: tableNode)
        
        ThemeManager.add(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableNode.dataSource = self
        tableNode.allowsSelection = false
        tableNode.view.separatorStyle = .none
        tableNode.view.showsVerticalScrollIndicator = false
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let changeAction = UIAlertAction(title: "Изменить подписку", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Отменить подписку", style: .default, handler: nil)
        let doneAction = UIAlertAction(title: "Done", style: .cancel, handler: nil)
        
        alertController.addAction(changeAction)
        alertController.addAction(cancelAction)
        alertController.addAction(doneAction)
        present(alertController, animated: true, completion: nil)
    }
}

    // MARK: - Table Data Source

extension SubscriptionsTableViewController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard let model = model?[indexPath.row] else { return {ASCellNode()} }
        
        
        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = SubscriptionsTableNodeCell(model: model)
            
            cellNode.onDetailed = { [weak self] in
                self?.showAlert()
            }
            
            return cellNode
        }
        
        return cellNodeBlock
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let width = UIScreen.main.bounds.width
        return ASSizeRange(min: CGSize(width: width, height: .zero), max: CGSize(width: width, height: .infinity))
    }
}

    // MARK: - Themeable

extension SubscriptionsTableViewController: Themeable {
    func updateTheme() {
        switch theme {
        case .light:
            view.backgroundColor = Styles.Colors.Palette.white0
        case .dark:
            view.backgroundColor = Styles.Colors.Palette.bgDark
        }
    }
}
