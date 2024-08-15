//
//  CustomTabView.swift
//  Expense
//
//  Created by Bing on 8/8/24.
//

import SwiftUI

struct TabButton: View {
    let icon: String
    let title: String
    let action: () -> Void
    let isSelected: Bool

    var body: some View {
        AnimatedPressButton(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 25, weight: .bold))
                Text(title)
                    .font(.headline)
            }
            .foregroundColor(.backgroundPeach)
            .padding(10)
            .shadow(color: isSelected ? .white : .clear, radius: 10, x: 0, y: 0)
        }
        .padding(.horizontal, 10)
    }
}

struct CustomTabView: View {
    @Binding var tabSelection: Int
    @Binding var isDetailShowing: Bool
    @State private var yOffset: CGFloat = 200

    var body: some View {
        ZStack {
            UnevenRoundedRectangle(
                topLeadingRadius: 20,
                bottomLeadingRadius: 42,
                bottomTrailingRadius: 42,
                topTrailingRadius: 20
            )

            HStack(spacing: 15) {
                TabButton(
                    icon: "pencil.and.list.clipboard",
                    title: "Insight",
                    action: { withAnimation(.spring()) { tabSelection = 1 } },
                    isSelected: tabSelection == 1
                )
                TabButton(
                    icon: "note.text.badge.plus",
                    title: "Expense",
                    action: { withAnimation(.spring()) { tabSelection = 2 } },
                    isSelected: tabSelection == 2
                )
                TabButton(
                    icon: "gearshape.fill",
                    title: "Settings",
                    action: { withAnimation(.spring()) { tabSelection = 3 } },
                    isSelected: tabSelection == 3
                )
            }
        }
        .background(.ultraThinMaterial.opacity(0.2))
        .frame(height: 80)
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 20,
                bottomLeadingRadius: 42,
                bottomTrailingRadius: 42,
                topTrailingRadius: 20
            )
        )
        .offset(y: yOffset)
        .onAppear {
            withAnimation(.bouncy) {
                yOffset = 32
            }
        }
    }
}

#Preview {
    CustomTabView(tabSelection: .constant(1), isDetailShowing: .constant(true))
}
