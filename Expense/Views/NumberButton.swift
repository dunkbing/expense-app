//
//  NumberButton.swift
//  Expense
//
//  Created by Bing on 7/8/24.
//

import SwiftUI

struct NoHighlightButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.foregroundColor(.accentColor)
    }
}

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
                .frame(width: 90, height: 55)
                .background(Color.gray.opacity(0.2))
                .foregroundColor(.orange)
                .cornerRadius(15)
                .scaleEffect(isPressed ? 0.9 : 1.0)
        }
        .buttonStyle(NoHighlightButtonStyle())
    }
}

#Preview {
    NumberButton(number: "1", action: {})
}
