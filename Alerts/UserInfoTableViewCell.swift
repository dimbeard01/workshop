//
//  UserInfoTableViewCell.swift
//  Alerts
//
//  Created by Dima on 30.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = "identifier"
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = Styles.Colors.Palette.gray4
        label.font = Styles.Fonts.Caption1
        label.textAlignment = .left
        return label
    }()
    
    private let answerLabel: UILabel = {
          let label = UILabel()
          label.numberOfLines = 0
          label.textColor = Styles.Colors.Palette.black
          label.font = Styles.Fonts.Body1
          label.textAlignment = .left
          return label
      }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func configure(question: String, answer: String) {
        questionLabel.text = question
        answerLabel.text = answer
    }
    
    private func setupView() {
        addSubview(questionLabel)
        addSubview(answerLabel)
        
        questionLabel.leadingToSuperview()
        questionLabel.trailingToSuperview()
        questionLabel.topToSuperview()
        questionLabel.bottomToTop(of: answerLabel, offset: -5)
        
        answerLabel.topToBottom(of: questionLabel, offset: 5)
        answerLabel.leadingToSuperview()
        answerLabel.trailingToSuperview()
        answerLabel.bottomToSuperview()
    }

}
