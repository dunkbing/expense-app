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
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
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
                .padding()
            }
        }
    }

}

#Preview {
    HistoryView()
}
