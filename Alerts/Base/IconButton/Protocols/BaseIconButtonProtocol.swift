//
//  BaseIconButtonProtocol.swift
//  Alerts
//
//  Created by Dima on 07.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//


import UIKit

protocol BaseIconButtonProtocol {
    var selecteble: Bool { get set }
    var isSelected: Bool { get set }
    
    var needCorners: Bool { get set }
    
    @discardableResult
    func setImage(image: UIImage) -> Self
    
    @discardableResult
    func setSelectedImage(image: UIImage) -> Self
    
    @discardableResult
    func setIconSize(height: CGFloat) -> Self
    
    @discardableResult
    func setButtonSize(height: CGFloat) -> Self
    
//    @discardableResult
//    func setButtonPaddings(paddings: UIEdgeInsets) -> Self
    
    @discardableResult
    func setButtonColor(color: UIColor?) -> Self
    
    @discardableResult
    func setIconColor(color: UIColor?) -> Self
    
    @discardableResult
    func setIconSelectedColor(color: UIColor?) -> Self
}
