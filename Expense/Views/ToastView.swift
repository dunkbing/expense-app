//
//  ToastView.swift
//  Expense
//
//  Created by Bing on 9/8/24.
//

import SwiftUI

struct ToastView: View {
    let message: String
    @Binding var isShowing: Bool

    var body: some View {
        VStack {
            if isShowing {
                Text(message)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isShowing = false
                            }
                        }
                    }
            }
        }
        .animation(.easeInOut, value: isShowing)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ToastView(message: "test", isShowing: .constant(true))
}
