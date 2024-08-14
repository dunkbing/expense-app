//
//  HistoryViewModel.swift
//  Expense
//
//  Created by Bing on 13/8/24.
//

import Foundation
import SwiftData

@Observable
class ExpenseViewModel {
    var modelContext: ModelContext
    var allExpenses = [ExpenseModel]()
    private var timeFilter = TimeFilter.week

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchData()
    }

    func fetchData(_ timeFilter: TimeFilter = .week) {
        self.timeFilter = timeFilter
        do {
            var predicate: Predicate<ExpenseModel>?
            let now = Date.now

            switch timeFilter {
            case .week:
                let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: now)!
                predicate = #Predicate<ExpenseModel> { $0.createdAt >= oneWeekAgo }
            case .month:
                let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: now)!
                predicate = #Predicate<ExpenseModel> { $0.createdAt >= oneMonthAgo }
            case .year:
                let oneYearAgo = Calendar.current.date(byAdding: .year, value: -1, to: now)!
                predicate = #Predicate<ExpenseModel> { $0.createdAt >= oneYearAgo }
            case .allTime:
                predicate = nil
            }

            let descriptor = FetchDescriptor<ExpenseModel>(
                predicate: predicate,
                sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
            )

            allExpenses = try modelContext.fetch(descriptor)
        }
        catch {
            print("Fetch failed: \(error)")
        }
    }

    func insert(_ e: ExpenseModel) {
        self.modelContext.insert(e)
        fetchData(timeFilter)
    }

    func deleteExpenses(_ indexSet: IndexSet, in expenses: [ExpenseModel]) {
        for index in indexSet {
            let expenseToDelete = expenses[index]
            modelContext.delete(expenseToDelete)
        }
        do {
            try modelContext.save()
        }
        catch {
            print("Error deleting expense: \(error)")
        }
        fetchData(timeFilter)
    }

    var expenses: [ExpenseModel] {
        return allExpenses
    }
}

enum TimeFilter {
    case week
    case month
    case year
    case allTime
}
