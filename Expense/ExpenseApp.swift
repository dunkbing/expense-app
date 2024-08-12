//
//  ExpenseApp.swift
//  Expense
//
//  Created by Bing on 7/8/24.
//

import SwiftData
import SwiftUI

@main
struct ExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [CategoryModel.self, ExpenseModel.self]) { result in
            switch result {
            case .success(let container):
                insertDefaultDataIfNeeded(container: container)
            case .failure(let error):
                print("Failed to create container: \(error.localizedDescription)")
            }
        }
    }

    @MainActor private func insertDefaultDataIfNeeded(container: ModelContainer) {
        let context = container.mainContext

        // Check if categories exist
        let categoryDescriptor = FetchDescriptor<CategoryModel>(predicate: nil, sortBy: [])
        guard let categoryCount = try? context.fetchCount(categoryDescriptor), categoryCount == 0
        else {
            return  // Data already exists, so return
        }

        // Default categories
        let categories = [
            CategoryModel(name: "Food", color: "Red", icon: "🍔", type: CATEGORY_TYPE),
            CategoryModel(name: "Transport", color: "Blue", icon: "🚗", type: CATEGORY_TYPE),
            CategoryModel(name: "Rent", color: "Brown", icon: "🏠", type: CATEGORY_TYPE),
            CategoryModel(name: "Subscriptions", color: "Purple", icon: "📺", type: CATEGORY_TYPE),
            CategoryModel(name: "Groceries", color: "Green", icon: "🛒", type: CATEGORY_TYPE),
            CategoryModel(name: "Utilities", color: "Yellow", icon: "💡", type: CATEGORY_TYPE),
            CategoryModel(name: "Family", color: "Pink", icon: "👨‍👩‍👧‍👦", type: CATEGORY_TYPE),
            CategoryModel(name: "Fashion", color: "Orange", icon: "👚", type: CATEGORY_TYPE),
            CategoryModel(name: "Healthcare", color: "White", icon: "🏥", type: CATEGORY_TYPE),
            CategoryModel(name: "Pets", color: "Cyan", icon: "🐾", type: CATEGORY_TYPE),
            CategoryModel(name: "Entertainment", color: "Magenta", icon: "🎭", type: CATEGORY_TYPE),
            CategoryModel(name: "Education", color: "Navy", icon: "📚", type: CATEGORY_TYPE),
            CategoryModel(name: "Savings", color: "Gold", icon: "💰", type: CATEGORY_TYPE),
            CategoryModel(name: "Gifts", color: "Teal", icon: "🎁", type: CATEGORY_TYPE),
            CategoryModel(name: "Travel", color: "Turquoise", icon: "✈️", type: CATEGORY_TYPE),
            CategoryModel(name: "Sports", color: "Lime", icon: "⚽", type: CATEGORY_TYPE),
            CategoryModel(name: "Technology", color: "Silver", icon: "💻", type: CATEGORY_TYPE),
            CategoryModel(
                name: "Home Improvement",
                color: "Maroon",
                icon: "🔨",
                type: CATEGORY_TYPE
            ),
            CategoryModel(name: "Personal Care", color: "Lavender", icon: "💅", type: CATEGORY_TYPE),
            CategoryModel(name: "Charity", color: "Olive", icon: "🤲", type: CATEGORY_TYPE),
        ]

        // Default payment types
        let paymentTypes = [
            CategoryModel(name: "Cash", color: "Green", icon: "💵", type: PAYMENT_TYPE),
            CategoryModel(name: "Credit Card", color: "Blue", icon: "💳", type: PAYMENT_TYPE),
            CategoryModel(name: "Digital Wallet", color: "Blue", icon: "📱", type: PAYMENT_TYPE),
        ]

        // Insert categories
        for category in categories {
            context.insert(category)
        }

        // Insert payment types
        for paymentType in paymentTypes {
            context.insert(paymentType)
        }

        // Save the changes
        do {
            try context.save()
            print("Default data inserted successfully")
        }
        catch {
            print("Failed to save default data: \(error.localizedDescription)")
        }
    }
}
