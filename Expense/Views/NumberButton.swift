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
        Button(action: {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed = false
                }
                action()
            }
        }) {
            Text(number)
                .font(.title)
                .fontWeight(.bold)
                .frame(width: 100, height: 80)
                .background(Color.gray.opacity(0.2))
                .foregroundColor(.orange)
                .cornerRadius(15)
                .scaleEffect(isPressed ? 0.9 : 1.0)
        }
    }
}

#Preview {
    NumberButton(number: "1", action: {})
}
