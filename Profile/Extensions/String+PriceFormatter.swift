//
//  String+PriceFormatter.swift
//  Alerts
//
//  Created by Dima on 23.07.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation

extension String {

    private static let intCurrencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()

        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0

        return formatter
    }()

    private static let decimalCurrencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()

        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        return formatter
    }()
    
    private static let intFormatter: NumberFormatter = {
        let formatter = NumberFormatter()

        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .none
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0

        return formatter
    }()

    /// String formatted in form of price with currency
    /// Formatted string has fraction part only if it doesn't equal to zero
    ///
    /// "123.50" is converted to  "123,50 ₽"
    ///
    /// "123" is converted to  "123 ₽"
    var asIntPrice: String? {
        let formatter: NumberFormatter = {
            guard contains(".") else { return String.intCurrencyFormatter }
            return contains(".00") ? String.intCurrencyFormatter : String.decimalCurrencyFormatter
        }()
        let number = NSDecimalNumber(string: self)

        return formatter.string(from: number)
    }

    /// String formatted in form of price with currency
    /// Formatted string always has fraction part
    ///
    /// "123.50" is converted to  "123,50 ₽"
    ///
    /// "123" is converted to  "123,00 ₽"
    var asDecimalPrice: String? {
        let number = NSDecimalNumber(string: self)

        return String.decimalCurrencyFormatter.string(from: number)
    }
    
    /// String formatted in form of price without currency
    /// Formatted string has fraction part only if it doesn't equal to zero
    ///
    /// "123.50" is converted to  "123"
    var asIntString: String? {
        let formatter: NumberFormatter = {
            return String.intFormatter
        }()
        let number = NSDecimalNumber(string: self)

        return formatter.string(from: number)
    }
    
    var asIntPriceRub: String {
        return asIntPrice ?? "0 ₽"
    }
    
    var asInt: Int? {
        guard let intString = asIntString else { return nil }
        return Int(intString)
    }
    
}
