//
//  CategoriesView.swift
//  Expense
//
//  Created by Bing on 8/8/24.
//

import SwiftUI

struct CategoryItemView: View {
    @Binding var selectedItem: CategoryModel?
    let item: CategoryModel

    var isSelected: Bool {
        selectedItem?.name == item.name
    }

    var body: some View {
        Button(action: {
            selectedItem = isSelected ? nil : item
        }) {
            Text("\(item.icon) \(item.name)")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(
                            isSelected
                                ? colorFromString(item.color)
                                : colorFromString(item.color).opacity(0.9)
                        )
                )
                .opacity(selectedItem == nil || isSelected ? 1.0 : 0.5)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CategoriesView: View {
    @Binding var selectedItem: CategoryModel?
    let items: [CategoryModel]

    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(items, id: \.name) { item in
                        CategoryItemView(
                            selectedItem: $selectedItem,
                            item: item
                        )
                    }
                }
                .padding(.horizontal)
            }

            AnimatedPressButton(action: {
            }) {
                Image(systemName: "pencil")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.mediumOrange)
                    .cornerRadius(15)
            }
            .padding(.trailing)
        }
    }
}
