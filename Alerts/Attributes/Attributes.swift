//
//  Attributes.swift
//  Alerts
//
//  Created by Dima on 09.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

struct Attributes {

    let dictionary: [NSAttributedString.Key: Any]

    init() {
        dictionary = [:]
    }

    init(_ attributesBlock: (Attributes) -> Attributes) {
        self = attributesBlock(Attributes())
    }

    internal init(dictionary: [NSAttributedString.Key: Any]) {
        self.dictionary = dictionary
    }

    func font(_ font: UIFont) -> Attributes {
        return self + Attributes(dictionary: [NSAttributedString.Key.font: font])
    }

    func kerning(_ kerning: Double) -> Attributes {
        return self + Attributes(dictionary: [NSAttributedString.Key.kern: NSNumber(floatLiteral: kerning)])
    }

    func strikeThroughStyle(_ strikeThroughStyle: NSUnderlineStyle) -> Attributes {
        return self + Attributes(dictionary: [NSAttributedString.Key.strikethroughStyle: strikeThroughStyle.rawValue, NSAttributedString.Key.baselineOffset : NSNumber(floatLiteral: 1.5)])
    }

    func underlineStyle(_ underlineStyle: NSUnderlineStyle) -> Attributes {
        return self + Attributes(dictionary: [NSAttributedString.Key.underlineStyle: underlineStyle.rawValue])
    }

    func strokeColor(_ strokeColor: UIColor) -> Attributes {
        return self + Attributes(dictionary: [NSAttributedString.Key.strokeColor: strokeColor])
    }

    func strokeWidth(_ strokewidth: Double) -> Attributes {
        return self + Attributes(dictionary: [NSAttributedString.Key.strokeWidth: NSNumber(floatLiteral: strokewidth)])
    }

    func foreground(color: UIColor) -> Attributes {
        return self + Attributes(dictionary: [NSAttributedString.Key.foregroundColor: color])
    }

    func background(color: UIColor) -> Attributes {
        return self + Attributes(dictionary: [NSAttributedString.Key.backgroundColor: color])
    }

    func paragraphStyle(_ paragraphStyle: NSParagraphStyle) -> Attributes {
        return self + Attributes(dictionary: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func shadow(_ shadow: NSShadow) -> Attributes {
        return self + Attributes(dictionary: [NSAttributedString.Key.shadow: shadow])
    }

    func obliqueness(_ value: CGFloat) -> Attributes {
        return self + Attributes(dictionary: [NSAttributedString.Key.obliqueness: value])
    }

    func link(_ link: String) -> Attributes {
        return self + Attributes(dictionary: [NSAttributedString.Key.link: link])
    }

    func baselineOffset(_ offset: NSNumber) -> Attributes {
        return self + Attributes(dictionary: [NSAttributedString.Key.baselineOffset: offset])
    }
}

// MARK: NSParagraphStyle related

extension Attributes {

    func lineSpacing(_ lineSpacing: CGFloat) -> Attributes {
        let paragraphStyle = (dictionary[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.lineSpacing = lineSpacing
        return self + Attributes(dictionary: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func paragraphSpacing(_ paragraphSpacing: CGFloat) -> Attributes {
        let paragraphStyle = (dictionary[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.paragraphSpacing =  paragraphSpacing
        return self + Attributes(dictionary: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func alignment(_ alignment: NSTextAlignment) -> Attributes {
        let paragraphStyle = (dictionary[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.alignment = alignment
        return self + Attributes(dictionary: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func firstLineHeadIndent(_ firstLineHeadIndent: CGFloat) -> Attributes {
        let paragraphStyle = (dictionary[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.firstLineHeadIndent = firstLineHeadIndent
        return self + Attributes(dictionary: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func headIndent(_ headIndent: CGFloat) -> Attributes {
        let paragraphStyle = (dictionary[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.headIndent = headIndent
        return self + Attributes(dictionary: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func tailIndent(_ tailIndent: CGFloat) -> Attributes {
        let paragraphStyle = (dictionary[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.tailIndent = tailIndent
        return self + Attributes(dictionary: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> Attributes {
        let paragraphStyle = (dictionary[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = lineBreakMode
        return self + Attributes(dictionary: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func minimumLineHeight(_ minimumLineHeight: CGFloat) -> Attributes {
        let paragraphStyle = (dictionary[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.minimumLineHeight = minimumLineHeight
        return self + Attributes(dictionary: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func maximumLineHeight(_ maximumLineHeight: CGFloat) -> Attributes {
        let paragraphStyle = (dictionary[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.maximumLineHeight = maximumLineHeight
        return self + Attributes(dictionary: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func uniformLineHeight(_ uniformLineHeight: CGFloat) -> Attributes {
        return maximumLineHeight(uniformLineHeight).minimumLineHeight(uniformLineHeight)
    }

    func baseWritingDirection(_ baseWritingDirection: NSWritingDirection) -> Attributes {
        let paragraphStyle = (dictionary[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.baseWritingDirection = baseWritingDirection
        return self + Attributes(dictionary: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func lineHeightMultiple(_ lineHeightMultiple: CGFloat) -> Attributes {
        let paragraphStyle = (dictionary[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        return self + Attributes(dictionary: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func paragraphSpacingBefore(_ paragraphSpacingBefore: CGFloat) -> Attributes {
        let paragraphStyle = (dictionary[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.paragraphSpacingBefore = paragraphSpacingBefore
        return self + Attributes(dictionary: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func hyphenationFactor(_ hyphenationFactor: Float) -> Attributes {
        let paragraphStyle = (dictionary[NSAttributedString.Key.paragraphStyle] ?? NSMutableParagraphStyle.default.mutableCopy()) as! NSMutableParagraphStyle
        paragraphStyle.hyphenationFactor = hyphenationFactor
        return self + Attributes(dictionary: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}
