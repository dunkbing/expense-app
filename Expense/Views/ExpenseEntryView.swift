//
//  TransactionEntryView.swift
//  Expense
//
//  Created by Bing on 7/8/24.
//

import SwiftUI

struct ExpenseTypePicker: View {
    @Binding var selection: Bool
    let options: [String]

    var body: some View {
        HStack(spacing: 1) {
            ForEach(options.indices, id: \.self) { index in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selection = (index == 0)
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

struct ExpenseEntryView: View {
    @State private var amount: Double = 0
    @State private var isExpense = true
    @State private var note: String = ""
    @State private var textFieldWidth: CGFloat = 150
    @State var date = Date.now
    @State private var isShowingDatePicker = false

    let dateRange: ClosedRange<Date> =
        Date(timeIntervalSinceNow: -864000)...Date(timeIntervalSinceNow: 864000)

    private func adjustWidth() {
        let maxWidth: CGFloat = 250
        let minWidth: CGFloat = 150

        let textWidth = note.size(withAttributes: [.font: UIFont.systemFont(ofSize: 17)]).width + 50
        textFieldWidth = min(maxWidth, max(minWidth, textWidth))
    }

    var body: some View {
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

                ExpenseTypePicker(
                    selection: $isExpense,
                    options: ["Expense", "Income"]
                )
                .frame(width: 200)
                Spacer()

                Button(action: {}) {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.gray.opacity(0.6))
                        .padding(10)
                        .fontWeight(.black)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(50)
                }
            }
            .padding(.horizontal)

            Spacer()

            Text("\(formatCurrency(num: amount, locale: Locale.current))")
                .font(.system(size: 43, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)

            TextField(
                "",
                text: $note,
                prompt: Text("Note...").foregroundColor(.gray)
            )
            .onChange(of: note) {
                adjustWidth()
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .frame(width: textFieldWidth)
            .foregroundColor(.orange.opacity(0.7))
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray.opacity(0.5), lineWidth: 1)
            )

            KeypadView(amount: $amount)

            CategoriesView()
            CategoriesView()

            VStack {
                Button(action: {
                    isShowingDatePicker = true
                }) {
                    HStack {
                        Text(formatDate(date))
                            .font(.headline)
                        Image(systemName: "calendar")
                            .font(.system(size: 30))
                    }
                }
                .foregroundColor(.white)

                Button(action: {
                }) {
                    HStack {
                        Text("Add")
                        Image(systemName: "checkmark.diamond.fill")
                    }
                    .padding(.vertical)
                }
                .frame(maxWidth: .infinity)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .background(Color.green.opacity(0.7))
                .cornerRadius(50)
            }
            .padding()
        }
        .background(Color(.black).ignoresSafeArea(.all))
        .sheet(isPresented: $isShowingDatePicker) {
            ZStack {
                DatePicker("", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.graphical)
                    .accentColor(.blue)
                    .labelsHidden()
                    .foregroundColor(.white)
                    .colorScheme(.dark)
                    .presentationDetents([.height(400)])
                    .presentationDragIndicator(.visible)
                    .padding()
            }.background(Color.black.gradient.opacity(0.8))
        }
    }
}

#Preview {
    ExpenseEntryView()
}