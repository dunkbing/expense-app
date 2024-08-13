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
            CategoryModel(name: "Food", color: "red", icon: "🍔", type: CATEGORY_TYPE),
            CategoryModel(name: "Transport", color: "blue", icon: "🚗", type: CATEGORY_TYPE),
            CategoryModel(name: "Rent", color: "brown", icon: "🏠", type: CATEGORY_TYPE),
            CategoryModel(name: "Subscriptions", color: "purple", icon: "📺", type: CATEGORY_TYPE),
            CategoryModel(name: "Groceries", color: "green", icon: "🛒", type: CATEGORY_TYPE),
            CategoryModel(name: "Utilities", color: "yellow", icon: "💡", type: CATEGORY_TYPE),
            CategoryModel(name: "Family", color: "pink", icon: "👨‍👩‍👧‍👦", type: CATEGORY_TYPE),
            CategoryModel(name: "Fashion", color: "orange", icon: "👚", type: CATEGORY_TYPE),
            CategoryModel(name: "Healthcare", color: "white", icon: "🏥", type: CATEGORY_TYPE),
            CategoryModel(name: "Pets", color: "cyan", icon: "🐾", type: CATEGORY_TYPE),
            CategoryModel(name: "Entertainment", color: "magenta", icon: "🎭", type: CATEGORY_TYPE),
            CategoryModel(name: "Education", color: "navy", icon: "📚", type: CATEGORY_TYPE),
            CategoryModel(name: "Savings", color: "gold", icon: "💰", type: CATEGORY_TYPE),
            CategoryModel(name: "Gifts", color: "teal", icon: "🎁", type: CATEGORY_TYPE),
            CategoryModel(name: "Travel", color: "turquoise", icon: "✈️", type: CATEGORY_TYPE),
            CategoryModel(name: "Sports", color: "lime", icon: "⚽", type: CATEGORY_TYPE),
            CategoryModel(name: "Technology", color: "silver", icon: "💻", type: CATEGORY_TYPE),
            CategoryModel(
                name: "Home Improvement",
                color: "maroon",
                icon: "🔨",
                type: CATEGORY_TYPE
            ),
            CategoryModel(name: "Personal Care", color: "lavender", icon: "💅", type: CATEGORY_TYPE),
            CategoryModel(name: "Charity", color: "olive", icon: "🤲", type: CATEGORY_TYPE),
        ]

        // Default payment types
        let paymentTypes = [
            CategoryModel(name: "Cash", color: "green", icon: "💵", type: PAYMENT_TYPE),
            CategoryModel(name: "Credit Card", color: "blue", icon: "💳", type: PAYMENT_TYPE),
            CategoryModel(name: "Digital Wallet", color: "blue", icon: "📱", type: PAYMENT_TYPE),
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
