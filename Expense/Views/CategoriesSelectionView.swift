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

struct CategoriesSelectionView: View {
    @Binding var selectedItem: CategoryModel?
    let items: [CategoryModel]
    @State private var isShowingDatePicker = false

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
                isShowingDatePicker = true
            }) {
                HStack {
                    Image(systemName: "pencil")
                    Text("Edit").fontWeight(.bold)
                }
            }
            .font(.system(size: 15))
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(10)
            .background(Color.mediumOrange)
            .cornerRadius(15)
            .padding(.trailing)
        }
        .sheet(isPresented: $isShowingDatePicker) {
            ZStack {
                CategoriesListView(categories: items)
            }.background(Color.backgroundPeach)
        }
    }
}

struct CategoryDropdownMenu: View {
    @Binding var selectedCategory: CategoryModel?
    let categories: [CategoryModel]

    @State private var showDropdown: Bool = false
    @State private var menuWidth: CGFloat = 200

    var buttonHeight: CGFloat = 50
    var maxItemDisplayed: Int = 5

    var body: some View {
        VStack {
            AnimatedPressButton(action: {
                withAnimation {
                    showDropdown.toggle()
                }
            }) {
                HStack(spacing: 10) {
                    if let selected = selectedCategory {
                        Text(selected.icon)
                        Text(selected.name)
                    }
                    else {
                        Text("Select Category")
                    }
                    Spacer()
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(showDropdown ? 180 : 0))
                }
                .padding(.horizontal, 20)
                .frame(width: menuWidth, height: buttonHeight)
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.deepOrange.opacity(0.6), lineWidth: 2)
                )
                .foregroundStyle(Color.deepOrange)
                .fontWeight(.bold)
            }
            .overlay(alignment: .top) {
                if showDropdown {
                    let scrollViewHeight: CGFloat =
                        CGFloat(min(categories.count, maxItemDisplayed)) * buttonHeight
                    VStack(spacing: 0) {
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(categories) { category in
                                    Button(
                                        action: {
                                            withAnimation {
                                                selectedCategory = category
                                                showDropdown.toggle()
                                            }
                                        },
                                        label: {
                                            HStack(spacing: 10) {
                                                Text(category.icon)
                                                Text(category.name)
                                                Spacer()
                                                if category.id == selectedCategory?.id {
                                                    Image(systemName: "checkmark.circle.fill")
                                                }
                                            }
                                        }
                                    )
                                    .padding(.horizontal, 20)
                                    .frame(
                                        width: menuWidth,
                                        height: buttonHeight,
                                        alignment: .leading
                                    )
                                }
                            }
                        }
                        .frame(height: scrollViewHeight)

                        Divider()
                            .background(Color.white)

                        Button(
                            action: {
                                print("Edit categories")
                            },
                            label: {
                                HStack {
                                    Text("Edit").fontWeight(.bold)
                                    Spacer()
                                    Image(systemName: "pencil")
                                }
                                .padding(.horizontal, 20)
                                .frame(width: menuWidth, height: buttonHeight, alignment: .leading)
                            }
                        )
                    }
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.backgroundPeach))
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.deepOrange.opacity(0.6), lineWidth: 2)
                    )
                    .foregroundStyle(Color.deepOrange.opacity(0.8))
                    .offset(y: -(scrollViewHeight + buttonHeight + 10))
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
        }
        .onAppear(perform: calculateWidth)
    }

    private func calculateWidth() {
        let textWidth: (String) -> CGFloat = { str in
            let font = UIFont.systemFont(ofSize: 17, weight: .bold)
            let attributes = [NSAttributedString.Key.font: font]
            return (str as NSString).size(withAttributes: attributes).width
        }

        let padding: CGFloat = 80  // Accounts for icon, spacer, chevron, and horizontal padding
        let maxCategoryWidth = categories.map { textWidth($0.icon) + textWidth($0.name) }.max() ?? 0
        let selectedTextWidth =
            selectedCategory.map { textWidth($0.icon) + textWidth($0.name) }
            ?? textWidth("Select Category")
        let editWidth = textWidth("Edit") + 30  // Extra space for pencil icon

        menuWidth = max(maxCategoryWidth, selectedTextWidth, editWidth) + padding
    }
}
