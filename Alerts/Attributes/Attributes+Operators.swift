//
//  Attributes+Operators.swift
//  Alerts
//
//  Created by Dima on 09.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
    let result = NSMutableAttributedString()
    result.append(lhs)
    result.append(rhs)
    return NSAttributedString(attributedString: result)
}

// NSParagraphStyle Addition

func + (lhs: NSParagraphStyle, rhs: NSParagraphStyle) -> NSParagraphStyle {
    let defaultParagraph = NSParagraphStyle.default
    let combinedAttributes = lhs.mutableCopy() as! NSMutableParagraphStyle

    if rhs.lineSpacing != defaultParagraph.lineSpacing {
        combinedAttributes.lineSpacing = rhs.lineSpacing
    }

    if rhs.paragraphSpacing != defaultParagraph.paragraphSpacing {
        combinedAttributes.paragraphSpacing = rhs.paragraphSpacing
    }

    if rhs.alignment != defaultParagraph.alignment {
        combinedAttributes.alignment = rhs.alignment
    }

    if rhs.firstLineHeadIndent != defaultParagraph.firstLineHeadIndent {
        combinedAttributes.firstLineHeadIndent = rhs.firstLineHeadIndent
    }

    if rhs.headIndent != defaultParagraph.headIndent {
        combinedAttributes.headIndent = rhs.headIndent
    }

    if rhs.tailIndent != defaultParagraph.tailIndent {
        combinedAttributes.tailIndent = rhs.tailIndent
    }

    if rhs.lineBreakMode != defaultParagraph.lineBreakMode {
        combinedAttributes.lineBreakMode = rhs.lineBreakMode
    }

    if rhs.minimumLineHeight != defaultParagraph.minimumLineHeight {
        combinedAttributes.minimumLineHeight = rhs.minimumLineHeight
    }

    if rhs.maximumLineHeight != defaultParagraph.maximumLineHeight {
        combinedAttributes.maximumLineHeight = rhs.maximumLineHeight
    }

    if rhs.baseWritingDirection != defaultParagraph.baseWritingDirection {
        combinedAttributes.baseWritingDirection = rhs.baseWritingDirection
    }

    if rhs.lineHeightMultiple != defaultParagraph.lineHeightMultiple {
        combinedAttributes.lineHeightMultiple = rhs.lineHeightMultiple
    }

    if rhs.paragraphSpacingBefore != defaultParagraph.paragraphSpacingBefore {
        combinedAttributes.paragraphSpacingBefore = rhs.paragraphSpacingBefore
    }

    if rhs.hyphenationFactor != defaultParagraph.hyphenationFactor {
        combinedAttributes.hyphenationFactor = rhs.hyphenationFactor
    }

    if rhs.tabStops != defaultParagraph.tabStops {
        combinedAttributes.tabStops = rhs.tabStops
    }

    if rhs.defaultTabInterval != defaultParagraph.defaultTabInterval {
        combinedAttributes.defaultTabInterval = rhs.defaultTabInterval
    }

    if #available(iOS 9.0, *) {
        if rhs.allowsDefaultTighteningForTruncation != defaultParagraph.allowsDefaultTighteningForTruncation {
            combinedAttributes.allowsDefaultTighteningForTruncation = rhs.allowsDefaultTighteningForTruncation
        }
    }

    return combinedAttributes
}

// MARK: Attributes addition

func + (lhs: Attributes, rhs: Attributes) -> Attributes {
    var combined = lhs.dictionary
    for (key, value) in rhs.dictionary {
        combined[key] = value
    }

    let combinedParagraphStyle: NSParagraphStyle?
    let lhsParagraphStyle = lhs.dictionary[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle
    let rhsParagraphStyle = rhs.dictionary[NSAttributedString.Key.paragraphStyle] as? NSParagraphStyle

    if let lhsParagraphStyle = lhsParagraphStyle, let rhsParagraphStyle = rhsParagraphStyle {
        combinedParagraphStyle = lhsParagraphStyle + rhsParagraphStyle
    } else {
        combinedParagraphStyle = lhsParagraphStyle ?? rhsParagraphStyle
    }

    if let paragraphStyle = combinedParagraphStyle {
        combined[NSAttributedString.Key.paragraphStyle] = paragraphStyle
    }

    return Attributes(dictionary: combined)
}
