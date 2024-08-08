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
                ExpenseEntryTabView()
                    .tag(1)
                ProspectView(filter: .uncontacted)
                    .tag(2)
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
