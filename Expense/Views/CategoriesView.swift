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
                    RoundedRectangle(cornerRadius: 25, style: .continuous).fill(
                        isSelected ? .black : .black.opacity(0.5)
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .strokeBorder(.gray.opacity(0.3), lineWidth: 3)
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
                        //                        Text(String(item.name)).foregroundColor(.white)
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
            }
            .background(Color.black)
            .cornerRadius(15)
            .padding(.trailing)
        }
    }
}
