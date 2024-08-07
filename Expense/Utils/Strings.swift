//
//  Strings.swift
//  Expense
//
//  Created by Bing on 7/8/24.
//

import Foundation

func formatCurrency(num: Double, locale: Locale) -> String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = locale

    let priceString = currencyFormatter.string(from: NSNumber(value: num))!
    return priceString
}
