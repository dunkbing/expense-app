//
//  TabView.swift
//  Expense
//
//  Created by Bing on 8/8/24.
//

import SwiftUI

struct ProspectView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    let filter: FilterType
    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted people"
        case .uncontacted:
            "Uncontacted people"
        }
    }

    var body: some View {
        NavigationStack {
            Text("Hello")
                .navigationTitle(title)
        }
        .background(.black)
    }
}

#Preview {
    ProspectView(filter: .contacted)
}
