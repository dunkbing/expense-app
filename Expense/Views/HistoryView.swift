//
//  HistoryView.swift
//  Expense
//
//  Created by Bing on 9/8/24.
//

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
    let icon: String
    let title: String
    let time: String
    let amount: String

    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(icon == "🏠" ? .pink : icon == "🍔" ? .blue : .orange).opacity(0.3))
                    .frame(width: 40, height: 40)
                Text(icon)
            }
            VStack(alignment: .leading) {
                Text(title)
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
        let expenses: [ExpenseEntity]
    }
    let expenses: [ExpenseHistoryItem]

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(expenses, id: \.label) { e in
                        ExpenseSection(
                            title: e.label,
                            amount: formatCurrency(num: e.amount, locale: Locale.current)
                        ) {
                            ForEach(e.expenses, id: \.id) { ee in
                                ExpenseRow(
                                    icon: ee.category.icon,
                                    title: ee.category.title,
                                    time: ee.createdAt.formatted(),
                                    amount: String(ee.amount)
                                )
                            }
                        }
                    }
                    ExpenseSection(title: "TODAY", amount: "-d212.000") {
                        ExpenseRow(icon: "🏠", title: "Rent", time: "10:27 AM", amount: "-d212.000")
                        ExpenseRow(icon: "🏠", title: "Rent", time: "10:27 AM", amount: "-d212.000")
                        ExpenseRow(icon: "🍔", title: "Food", time: "1:16 PM", amount: "-d23.000")
                    }

                    ExpenseSection(title: "YESTERDAY", amount: "-d23.000") {
                        ExpenseRow(icon: "🍔", title: "Food", time: "1:16 PM", amount: "-d23.000")
                    }

                    ExpenseSection(title: "WED, 7 AUG", amount: "-d35.000") {
                        ExpenseRow(
                            icon: "🚄",
                            title: "Transport",
                            time: "10:34 AM",
                            amount: "-d35.000"
                        )
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    HistoryView(expenses: [
        HistoryView.ExpenseHistoryItem(
            label: "TODAY",
            amount: 212000,
            expenses: [
                ExpenseEntity(
                    id: 1,
                    amount: 212000,
                    createdAt: Date.now,
                    category: CategoryEntity(id: 1, title: "Rent", icon: "🏠", color: "green")
                )
            ]
        ),
        HistoryView.ExpenseHistoryItem(
            label: "YESTERDAY",
            amount: 212000,
            expenses: [
                ExpenseEntity(
                    id: 1,
                    amount: 212000,
                    createdAt: Date.now,
                    category: CategoryEntity(id: 1, title: "Rent", icon: "🏠", color: "green")
                )
            ]
        ),
    ])
}
