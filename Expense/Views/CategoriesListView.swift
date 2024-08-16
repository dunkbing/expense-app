//
//  CategoriesListView.swift
//  Expense
//
//  Created by Bing on 16/8/24.
//

import SwiftUI

struct CategoriesListView: View {
    let categories: [CategoryModel]
    @State private var isExpense = true

    var body: some View {
        ZStack {
            Color.backgroundPeach.edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: 0) {
                Text("EXPENSE CATEGORIES")
                    .foregroundColor(.deepOrange)
                    .font(.system(size: 24, weight: .bold))
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .padding(.leading, 20)
                    .padding(.bottom, 10)

                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(categories) { category in
                            VStack(spacing: 0) {
                                HStack {
                                    Text(category.icon)
                                        .font(.system(size: 30))

                                    Text(category.name)
                                        .foregroundColor(.deepOrange)
                                        .font(.system(size: 20, weight: .medium))

                                    Spacer()

                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(colorFromString(category.color))
                                        .frame(width: 30, height: 30)
                                }
                                .padding(.vertical, 12)
                                .padding(.horizontal, 20)

                                if category.id != categories.last?.id {
                                    Divider()
                                        .background(Color.gray.opacity(0.3))
                                        .padding(.horizontal, 20)
                                }
                            }
                        }
                    }
                }
                .background(Color.accentOrange.opacity(0.2))
                .cornerRadius(15)

                Spacer()

                HStack {
                    ExpenseTypePicker(
                        selection: $isExpense,
                        options: ["Expense", "Income"]
                    )
                    .frame(width: 200)
                    Spacer()
                    AnimatedPressButton(action: {
                    }) {
                        HStack {
                            Text("New")
                            Image(systemName: "plus")
                        }
                        .fontWeight(.bold)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 14)
                        .background(
                            Color.deepOrange.opacity(0.7)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(18)
                    }
                }
            }
            .padding()
        }
    }
}
