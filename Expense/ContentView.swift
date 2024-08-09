//
//  ContentView.swift
//  Expense
//
//  Created by Bing on 7/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    @State private var isDetailShowing = true

    init() {
    }
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            TabView(selection: $tabSelection) {
                HistoryView().tag(1)
                ExpenseEntryTabView()
                    .tag(2)
                ProspectView(filter: .uncontacted)
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

#Preview {
    ContentView()
}
