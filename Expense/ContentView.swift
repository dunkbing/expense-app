//
//  ContentView.swift
//  Expense
//
//  Created by Bing on 7/8/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    @State private var isDetailShowing = true
    @Environment(\.modelContext) private var modelContext
    @State private var expenseViewModel: ExpenseViewModel
    @State private var categoryViewModel: CategoryViewModel

    init(modelContext: ModelContext) {
        let viewModel = ExpenseViewModel(modelContext: modelContext)
        _expenseViewModel = State(initialValue: viewModel)
        let categoryViewModel = CategoryViewModel(modelContext: modelContext)
        _categoryViewModel = State(initialValue: categoryViewModel)
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            TabView(selection: $tabSelection) {
                HistoryView(expenseViewModel: $expenseViewModel).tag(1)
                ExpenseEntryView(
                    expenseViewModel: $expenseViewModel,
                    categoryViewModel: $categoryViewModel
                )
                .tag(2)
                SettingsView()
                    .tag(3)
            }
            .overlay(alignment: .bottom) {
                if isDetailShowing {
                    CustomTabView(
                        tabSelection: $tabSelection,
                        isDetailShowing: $isDetailShowing
                    )
                    .tint(.mint)
                }
            }
        }
    }
}
