//
//  CategoriesView.swift
//  Expense
//
//  Created by Bing on 8/8/24.
//

import SwiftUI

struct CategoryItem: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
}

struct CategoryItemView: View {
    @Binding var selectedItem: UUID?
    let item: CategoryItem

    var isSelected: Bool {
        selectedItem == item.id
    }

    var body: some View {
        Text("\(item.emoji) \(item.name)")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25, style: .continuous).fill(
                    isSelected ? .black : .black.opacity(0.5)
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .strokeBorder(.gray.opacity(0.3), lineWidth: 3)
            )
            .opacity(selectedItem == nil || isSelected ? 1.0 : 0.5)
            .onTapGesture {
                selectedItem = isSelected ? nil : item.id
            }
    }
}

struct CategoriesView: View {
    @State private var selectedItem: UUID?
    let items = [
        CategoryItem(name: "Meal", emoji: "🍔"),
        CategoryItem(name: "Coffee", emoji: "☕️"),
        CategoryItem(name: "Groceries", emoji: "🛒"),
        CategoryItem(name: "Cash", emoji: "💵"),
        CategoryItem(name: "Credit card", emoji: "💳"),
        CategoryItem(name: "Digital wallet", emoji: "📱"),
    ]

    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(items) { item in
                        CategoryItemView(selectedItem: $selectedItem, item: item)
                    }
                }
                .padding(.horizontal)
            }

            Button(action: {
            }) {
                Image(systemName: "pencil")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(10)
            }
            .background(Color.black)
            .cornerRadius(15)
            .padding(.trailing)
        }
    }

}

#Preview {
    CategoriesView()
}
