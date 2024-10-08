//
//  TransactionEntryView.swift
//  Expense
//
//  Created by Bing on 7/8/24.
//

import SwiftData
import SwiftUI

struct ExpenseTypePicker: View {
    @Binding var selection: Bool
    let options: [String]

    var body: some View {
        HStack(spacing: 1) {
            ForEach(options.indices, id: \.self) { index in
                AnimatedPressButton(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selection = (index == 0)
                    }
                }) {
                    Text(options[index])
                }
                .fontWeight(.bold)
                .padding(.vertical, 8)
                .padding(.horizontal, 14)
                .background(
                    selection == (index == 0)
                        ? Color.deepOrange.opacity(0.7)
                        : Color.clear
                )
                .foregroundColor(.white)
                .cornerRadius(18)
            }
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 4)
        .background(Color.lightOrange)
        .cornerRadius(22)
    }
}

struct ExpenseEntryView: View {
    @Binding var expenseViewModel: ExpenseViewModel
    @Binding var categoryViewModel: CategoryViewModel

    @State private var amount: Double = 0
    @State private var isExpense = true
    @State private var note: String = ""
    @State private var category: CategoryModel? = nil
    @State private var payment: CategoryModel? = nil
    @State private var textFieldWidth: CGFloat = 150
    @State private var date = Date.now
    @State private var isShowingDatePicker = false
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var isCategoryExpanded = false
    @State private var selectedCategory: String?
    let categories = [
        "Groceries",
        "Subscriptions",
        "Rent",
        "Transport",
        "Food",
    ]

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
            ExpenseTypePicker(
                selection: $isExpense,
                options: ["Expense", "Income"]
            )
            .frame(width: 200)
            .overlay {
                ToastView(
                    message: toastMessage,
                    isShowing: $showToast
                )
            }
            .padding(.horizontal)

            Spacer()

            Text("\(formatCurrency(amount, Locale.current))")
                .font(.system(size: 43, weight: .bold))
                .foregroundColor(.textOrange)
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

            CategoriesSelectionView(
                selectedItem: $category,
                items: categoryViewModel.categories
            )
            CategoriesSelectionView(
                selectedItem: $payment,
                items: categoryViewModel.payments
            )

            VStack {
                AnimatedPressButton(action: {
                    isShowingDatePicker = true
                }) {
                    HStack {
                        Text(formatDate(date))
                            .font(.headline)
                        Image(systemName: "calendar")
                            .font(.system(size: 30))
                    }
                }
                .foregroundColor(.mediumOrange)

                AnimatedPressButton(action: {
                    if amount <= 0 {
                        return
                    }
                    let e = ExpenseModel(
                        amount: amount,
                        type: isExpense ? "expense" : "income",
                        note: note,
                        category: category,
                        payment: payment,
                        createdAt: date
                    )
                    toastMessage = "\(formatCurrency(amount)) added"
                    expenseViewModel.insert(e)
                    amount = 0
                    showToast = true
                }) {
                    HStack {
                        Text("Add")
                        Image(systemName: "checkmark.diamond.fill")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .background(Color.deepOrange)
                    .cornerRadius(50)
                }
            }
            .padding()
        }
        .background(Color.backgroundPeach.ignoresSafeArea(.all))
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
