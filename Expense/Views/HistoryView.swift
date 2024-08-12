//
//  HistoryView.swift
//  Expense
//
//  Created by Bing on 9/8/24.
//

import SwiftData
import SwiftUI

struct ExpenseSection<Content: View>: View {
    let title: String
    let amount: String
    let content: Content

    init(title: String, amount: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.amount = amount
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title)
                    .foregroundColor(.gray)
                Spacer()
                Text(amount)
                    .foregroundColor(.gray)
            }
            .fontWeight(.bold)
            Divider()
                .background(Color.gray)
            content
        }
    }
}

struct ExpenseRow: View {
    let icon: String?
    let title: String?
    let time: String
    let amount: String

    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(icon == "🏠" ? .pink : icon == "🍔" ? .blue : .orange).opacity(0.3))
                    .frame(width: 40, height: 40)
                Text(icon ?? "💰")
            }
            VStack(alignment: .leading) {
                Text(title ?? "")
                    .foregroundColor(.white)
                Text(time)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(amount)
                .foregroundColor(.white)
        }
        .fontWeight(.bold)
    }
}

struct HistoryView: View {
    struct ExpenseHistoryItem {
        let label: String
        let amount: Double
        let expenses: [ExpenseModel]
    }

    @Query var expenses: [ExpenseModel]
    var expensesArray: [ExpenseHistoryItem] {
        let groupedExpenses = Dictionary(grouping: expenses) { formatDate($0.createdAt) }
        let expenseHistoryItems = groupedExpenses.map {
            (dateString, expenses) -> ExpenseHistoryItem in
            let totalAmount = expenses.reduce(0) { $0 + $1.amount }
            return ExpenseHistoryItem(label: dateString, amount: totalAmount, expenses: expenses)
        }
        return expenseHistoryItems
    }

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(expensesArray, id: \.label) { e in
                        ExpenseSection(
                            title: e.label,
                            amount: formatCurrency(num: e.amount, locale: Locale.current)
                        ) {
                            ForEach(e.expenses, id: \.id) { ee in
                                ExpenseRow(
                                    icon: ee.category?.icon,
                                    title: ee.category?.name,
                                    time: formatDateTime(ee.createdAt),
                                    amount: String(ee.amount)
                                )
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}
