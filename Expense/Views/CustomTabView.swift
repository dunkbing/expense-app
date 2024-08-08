//
//  CustomTabView.swift
//  Expense
//
//  Created by Bing on 8/8/24.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var tabSelection: Int
    @Binding var isDetailShowing: Bool
    @State private var yOffset: CGFloat = 200

    var body: some View {
        ZStack {
            UnevenRoundedRectangle(
                topLeadingRadius: 12,
                bottomLeadingRadius: 42,
                bottomTrailingRadius: 42,
                topTrailingRadius: 12
            )

            HStack(spacing: 15) {
                Button(action: {
                    tabSelection = 1
                }) {
                    VStack {
                        Image(systemName: "plus.app")
                            .font(.system(size: 29, weight: .bold))
                        Text("Expense")
                            .font(.headline)
                    }
                    .foregroundColor(.mint)
                }
                .buttonStyle(NoHighlightButtonStyle())
                Button(action: {
                    tabSelection = 2
                }) {
                    VStack {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 25, weight: .bold))
                        Text("Settings")
                            .font(.headline)
                    }
                    .foregroundColor(.mint)
                }
                .buttonStyle(NoHighlightButtonStyle())
            }
        }
        .background(.ultraThinMaterial)
        .frame(height: 80)
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 12,
                bottomLeadingRadius: 42,
                bottomTrailingRadius: 42,
                topTrailingRadius: 12
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
