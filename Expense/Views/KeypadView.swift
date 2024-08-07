//
//  KeypadView.swift
//  Expense
//
//  Created by Bing on 7/8/24.
//

import SwiftUI

struct KeypadView: View {
    @Binding var amount: Double
    let columns = Array(repeating: GridItem(.flexible()), count: 3)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(1...9, id: \.self) { number in
                NumberButton(
                    number: "\(number)",
                    action: {
                        let newVal = amount * 10 + Double(number)
                        let formattedNewVal = formatCurrency(num: newVal, locale: Locale.current)
                        if formattedNewVal.count <= 11 {
                            amount = newVal
                        }
                    }
                )
            }
            NumberButton(
                number: "K",
                action: {
                    let newVal = amount * 1000
                    let formattedNewVal = formatCurrency(num: newVal, locale: Locale.current)
                    if formattedNewVal.count <= 11 {
                        amount = newVal
                    }
                }
            )
            NumberButton(
                number: "0",
                action: {
                    let newVal = amount * 10
                    let formattedNewVal = formatCurrency(num: newVal, locale: Locale.current)
                    if formattedNewVal.count <= 11 {
                        amount = newVal
                    }
                }
            )
            Button(action: {
                // Confirm action
            }) {
                Image(systemName: "checkmark")
                    .frame(width: 100, height: 80)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
