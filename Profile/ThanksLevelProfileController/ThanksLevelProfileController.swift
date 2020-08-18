//
//  ThanksLevelProfileController.swift
//  Alerts
//
//  Created by Dima on 31.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

final class ThanksLevelProfileController: UIViewController {
    
    private let roundedLayer = CAShapeLayer()
    private let trackLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()

    private var thanksLevel: CGFloat
    private var remainedLevel: CGFloat
    private var gradientColors: [CGColor]
    
    init(thanksLevel: CGFloat, remainedLevel: CGFloat, gradientColors: [CGColor]) {
        self.thanksLevel = thanksLevel
        self.remainedLevel = remainedLevel
        self.gradientColors = gradientColors
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        makeTrackLayer()
        makeRoundedLayer()
        makeGradientLayer()
        
        view.layer.addSublayer(trackLayer)
        view.layer.addSublayer(gradientLayer)
        gradientLayer.mask = roundedLayer

        view.backgroundColor = Styles.Colors.Palette.white

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    private func makeTrackLayer() {
        let trackPath = UIBezierPath(arcCenter: .zero, radius: 72.5, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        trackLayer.path = trackPath.cgPath
        trackLayer.strokeColor = Styles.Colors.Palette.gray6.cgColor
        trackLayer.lineWidth = 2
        trackLayer.lineCap = .round
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.position = view.center
        trackLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)

        let count: CGFloat = 32
        let relativeDashLength: CGFloat = 0.25
        let dashLength = CGFloat((2 * .pi * 72.5) / count)
        trackLayer.lineDashPattern = [dashLength * relativeDashLength, dashLength * (1 - relativeDashLength)] as [NSNumber]
    }
    
    private func makeRoundedLayer() {
        let circlularPath = UIBezierPath(arcCenter: .zero, radius: 72.5, startAngle: 0, endAngle:  CGFloat.pi * 2, clockwise: true)
        roundedLayer.path = circlularPath.cgPath
        roundedLayer.strokeColor = UIColor.blue.cgColor
        roundedLayer.lineWidth = 8
        roundedLayer.fillColor = UIColor.clear.cgColor
        roundedLayer.strokeEnd = thanksLevel
        roundedLayer.lineCap = .round
        roundedLayer.position = view.center
        roundedLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
    }
    
    private func makeGradientLayer() {
        gradientLayer.type = .conic
        gradientLayer.frame = view.frame
        gradientLayer.colors = gradientColors
        gradientLayer.startPoint = CGPoint(x: 0.485, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: -1)
    }
    
    @objc private func handleTap() {
        thanksLevel += 0.05
        roundedLayer.strokeEnd = thanksLevel
    }
}
