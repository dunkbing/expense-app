//
//  TransactionEntryView.swift
//  Expense
//
//  Created by Bing on 7/8/24.
//

import SwiftUI

struct TransactionTypePicker: View {
    @Binding var selection: Bool
    let options: [String]

    var body: some View {
        HStack(spacing: 1) {
            ForEach(options.indices, id: \.self) { index in
                Button(action: {
                    withAnimation {
                        selection = index == 0
                    }
                }) {
                    Text(options[index])
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 14)
                .background(
                    selection == (index == 0)
                    ? Color.gray.opacity(0.6)
                    : Color.clear
                )
                .foregroundColor(
                    selection == (index == 0)
                    ? .white
                    : .gray
                )
                .cornerRadius(18)
            }
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 4)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(22)
    }
}

struct TransactionEntryView: View {
    @State private var amount: Double = 0
    @State private var isExpense = true

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray.opacity(0.6))
                            .padding(10)
                            .fontWeight(.black)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(50)
                    }
                    Spacer()

                    TransactionTypePicker(
                        selection: $isExpense,
                        options: ["Expense", "Income"]
                    )
                    .frame(width: 200)
                    Spacer()

                    Button (action: {}) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.gray.opacity(0.6))
                            .padding(10)
                            .fontWeight(.black)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(50)
                    }
                }
                .padding()

                Spacer()

                Text("\(formatCurrency(num: amount, locale: Locale.current))")
                    .font(.system(size: 45, weight: .bold))
                    .padding()
                    .foregroundStyle(.white)
                Button(action :{}) {
                    HStack {
                        Image(systemName: "list.bullet")
                        Text("Add Note")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
                HStack {
                    Button(action: {
                        // Date picker action
                    }) {
                        HStack {
                            Image(systemName: "calendar")
                            Text("Today, 7 Aug")
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }

                    Button(action: {
                        // Category action
                    }) {
                        HStack {
                            Image(systemName: "square.grid.2x2")
                            Text("Category")
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                }
                .padding()

                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
                    ForEach(1...9, id: \.self) { number in
                        NumberButton(number: "\(number)", action: {
                            let newVal = amount * 10 + Double(number)
                            let formattedNewVal = formatCurrency(num: newVal, locale: Locale.current)
                            if formattedNewVal.count <= 11 {
                                amount = newVal
                            }
                        })
                    }
                    NumberButton(number: "K", action: {
                        let newVal = amount * 1000
                        let formattedNewVal = formatCurrency(num: newVal, locale: Locale.current)
                        if formattedNewVal.count <= 11 {
                            amount = newVal
                        }
                    })
                    NumberButton(number: "0", action: {
                        let newVal = amount * 10
                        let formattedNewVal = formatCurrency(num: newVal, locale: Locale.current)
                        if formattedNewVal.count <= 11 {
                            amount = newVal
                        }
                    })
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
    }
}

#Preview {
    TransactionEntryView()
}
