//
//  HistoryView.swift
//  Expense
//
//  Created by Bing on 9/8/24.
//

import SwiftData
import SwiftUI

struct ExpenseSection: View {
    let title: String
    let amount: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            Text(amount)
                .foregroundColor(.gray)
        }
        .fontWeight(.bold)
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .background(Color.black)
    }
}

struct ExpenseRow: View {
    let icon: String?
    let title: String?
    let time: String
    let amount: Double
    let color: String

    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(colorFromString(color).opacity(0.7))
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
            Text(formatCurrency(amount))
                .foregroundColor(.white)
        }
        .fontWeight(.bold)
    }
}

struct HistoryView: View {
    struct ExpenseHistoryItem: Identifiable {
        let id = UUID()
        let label: String
        let amount: Double
        let expenses: [ExpenseModel]
    }

    @Binding var expenseViewModel: ExpenseViewModel

    var expensesArray: [ExpenseHistoryItem] {
        let groupedExpenses = Dictionary(grouping: expenseViewModel.expenses) {
            formatDate($0.createdAt)
        }

        let sortedKeys = expenseViewModel.expenses.map { formatDate($0.createdAt) }.reduce(
            into: [String]()
        ) {
            result,
            dateString in
            if !result.contains(dateString) {
                result.append(dateString)
            }
        }

        return sortedKeys.compactMap { dateString -> ExpenseHistoryItem? in
            if let expensesForDate = groupedExpenses[dateString] {
                let totalAmount = expensesForDate.reduce(0) { $0 + $1.amount }
                return ExpenseHistoryItem(
                    label: dateString,
                    amount: totalAmount,
                    expenses: expensesForDate
                )
            }
            return nil
        }
    }

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray.opacity(0.6))
                            .padding(10)
                            .fontWeight(.black)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(50)
                    }
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundColor(.gray.opacity(0.6))
                            .padding(10)
                            .fontWeight(.black)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(50)
                    }
                }
                .padding()

                List {
                    ForEach(expensesArray) { section in
                        Section(
                            header:
                                ExpenseSection(
                                    title: section.label,
                                    amount: formatCurrency(section.amount, Locale.current)
                                )
                                .listRowInsets(EdgeInsets())
                        ) {
                            ForEach(section.expenses) { expense in
                                ExpenseRow(
                                    icon: expense.category?.icon,
                                    title: expense.category?.name,
                                    time: formatDateTime(expense.createdAt),
                                    amount: expense.amount,
                                    color: expense.category?.color ?? "cyan"
                                )
                                .listRowBackground(Color.black)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        if let index = section.expenses.firstIndex(where: {
                                            $0.id == expense.id
                                        }) {
                                            expenseViewModel.deleteExpenses(
                                                IndexSet(integer: index),
                                                in: section.expenses
                                            )
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.gray)
                                }
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}
