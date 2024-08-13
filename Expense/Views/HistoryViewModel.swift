//
//  HistoryViewModel.swift
//  Expense
//
//  Created by Bing on 13/8/24.
//

import Foundation
import SwiftData
import SwiftUI

extension HistoryView {
    @Observable
    class ViewModel {
        var modelContext: ModelContext
        var allExpenses = [ExpenseModel]()

        init(modelContext: ModelContext) {
            self.modelContext = modelContext
        }
        func fetchData() {
            do {
                let descriptor = FetchDescriptor<ExpenseModel>(sortBy: [
                    SortDescriptor(\.createdAt, order: .reverse)
                ])
                allExpenses = try modelContext.fetch(descriptor)
            }
            catch {
                print("Fetch failed")
            }
        }
        //        @Query(sort: \ExpenseModel.createdAt, order: .reverse) private var allExpenses: [ExpenseModel]

        var expenses: [ExpenseModel] {
            switch timeFilter {
            case .week:
                return filterExpenses(for: .week)
            case .month:
                return filterExpenses(for: .month)
            case .year:
                return filterExpenses(for: .year)
            case .allTime:
                return allExpenses
            }
        }

        private var timeFilter: TimeFilter = .allTime

        private func filterExpenses(for period: TimeFilter) -> [ExpenseModel] {
            let calendar = Calendar.current
            let now = Date()
            var startDate: Date

            switch period {
            case .week:
                startDate = calendar.date(byAdding: .day, value: -7, to: now)!
            case .month:
                startDate = calendar.date(byAdding: .month, value: -1, to: now)!
            case .year:
                startDate = calendar.date(byAdding: .year, value: -1, to: now)!
            case .allTime:
                return allExpenses
            }

            return allExpenses.filter { $0.createdAt >= startDate }
        }
    }

    enum TimeFilter {
        case week
        case month
        case year
        case allTime
    }
}
