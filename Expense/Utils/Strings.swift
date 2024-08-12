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

func formatDateTime(_ date: Date) -> String {
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()

    if calendar.isDateInToday(date) {
        dateFormatter.dateFormat = "'Today,' d MMM HH:mm"
    }
    else if calendar.isDateInYesterday(date) {
        dateFormatter.dateFormat = "'Yesterday,' d MMM HH:mm"
    }
    else {
        dateFormatter.dateFormat = "EEE, d MMM HH:mm"
    }

    return dateFormatter.string(from: date)
}

func formatDate(_ dateOp: Date?) -> String {
    if let date = dateOp {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Today"
        }
        else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    else {
        return ""
    }
}

func convertStringToDate(_ dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy, h:mm a"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")

    return dateFormatter.date(from: dateString)
}
