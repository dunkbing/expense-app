//
//  CategoryViewModel.swift
//  Expense
//
//  Created by Bing on 14/8/24.
//

import Foundation
import SwiftData

@Observable
class CategoryViewModel {
    var modelContext: ModelContext
    var categories = [CategoryModel]()
    var payments = [CategoryModel]()

    private var timeFilter = TimeFilter.allTime

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchData()
    }

    func fetchData(_ timeFilter: TimeFilter = .allTime) {
        do {
            var descriptor = FetchDescriptor<CategoryModel>(
                predicate: #Predicate<CategoryModel> { c in
                    c.type == CATEGORY_TYPE
                }
            )
            categories = try modelContext.fetch(descriptor)
            descriptor = FetchDescriptor<CategoryModel>(
                predicate: #Predicate<CategoryModel> { c in
                    c.type == PAYMENT_TYPE
                }
            )
            payments = try modelContext.fetch(descriptor)
        }
        catch {
            print("Fetch failed")
        }
    }
}
