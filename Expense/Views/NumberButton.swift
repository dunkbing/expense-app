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
    @State private var isPressed: Bool = false

    var body: some View {
        AnimatedPressButton(action: action) {
            Text(number)
                .font(.title)
                .fontWeight(.bold)
                .frame(width: 90, height: 55)
                .background(Color.gray.opacity(0.2))
                .foregroundColor(.white)
                .cornerRadius(15)
                .scaleEffect(isPressed ? 0.9 : 1.0)
        }
    }
}

#Preview {
    NumberButton(number: "1", action: {})
}
