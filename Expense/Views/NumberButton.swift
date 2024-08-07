//
//  NumberButton.swift
//  Expense
//
//  Created by Bing on 7/8/24.
//

import SwiftUI

struct NumberButton: View {
    let number: String
    let action: () -> Void

    var body: some View {
        Button (action: action) {
            Text(number)
                .font(.title)
                .fontWeight(.bold)
                .frame(width: 100, height: 80)
                .background(Color.gray.opacity(0.2))
                .foregroundColor(.orange)
                .cornerRadius(15)
        }
    }
}

#Preview {
    NumberButton(number: "1", action: {})
}
