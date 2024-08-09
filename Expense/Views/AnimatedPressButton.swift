//
//  AnimatedPressButton.swift
//  Expense
//
//  Created by Bing on 9/8/24.
//

import SwiftUI

struct AnimatedPressButton<Content: View>: View {
    let action: () -> Void
    let content: () -> Content

    @State private var isPressed = false

    init(action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.action = action
        self.content = content
    }

    var body: some View {
        Button(action: action) {
            content()
                .scaleEffect(isPressed ? 0.9 : 1.0)
                .animation(
                    .spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0),
                    value: isPressed
                )
        }
        .buttonStyle(PlainButtonStyle())
        .pressEvents {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
            }
        } onRelease: {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = false
            }
        }
    }
}

// PressActions ViewModifier (same as before)
struct PressActions: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in onPress() }
                    .onEnded { _ in onRelease() }
            )
    }
}

// View extension for pressEvents (same as before)
extension View {
    func pressEvents(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void))
        -> some View
    {
        modifier(
            PressActions(
                onPress: {
                    onPress()
                },
                onRelease: {
                    onRelease()
                }
            )
        )
    }
}
