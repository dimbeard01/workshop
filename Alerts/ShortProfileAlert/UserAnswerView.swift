//
//  UserAnswerView.swift
//  Alerts
//
//  Created by Dima on 30.06.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

final class UserAnswerView: UIView {
    
    // MARK: - Properties
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Styles.Fonts.Caption1
        label.textAlignment = .left
        return label
    }()
    
    private let answerLabel: UILabel = {
          let label = UILabel()
          label.numberOfLines = 0
          label.font = Styles.Fonts.Body1
          label.textAlignment = .left
          return label
      }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers

    func configure(userInfo: QuestionnaireModel, theme: Theme) {
        questionLabel.text = userInfo.question
        answerLabel.text = userInfo.answer
        answerLabel.textColor = theme == Theme.dark ? Styles.Colors.Palette.white : Styles.Colors.Palette.gray3
        questionLabel.textColor = theme == Theme.dark ? Styles.Colors.Palette.gray4 : Styles.Colors.Palette.gray5
    }
    
    private func setupView() {
        addSubview(questionLabel)
        addSubview(answerLabel)
        
        questionLabel.leftToSuperview()
        questionLabel.rightToSuperview()
        questionLabel.topToSuperview()
        
        answerLabel.topToBottom(of: questionLabel, offset: 5)
        answerLabel.leftToSuperview()
        answerLabel.rightToSuperview()
        answerLabel.bottomToSuperview()
    }
}
