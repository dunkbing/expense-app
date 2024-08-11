//
//  ExpenseEntity.swift
//  Expense
//
//  Created by Bing on 9/8/24.
//

import Foundation

struct ExpenseEntity {
    let id: Int64
    let amount: Double
    let note: String? = ""
    let createdAt: Date?
    let category: CategoryEntity
}

struct ExpenseCreate {
    let amount: Double
    let note: String
    let createdAt: Date
    let category: String
}
