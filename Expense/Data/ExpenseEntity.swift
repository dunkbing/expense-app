//
//  ExpenseEntity.swift
//  Expense
//
//  Created by Bing on 9/8/24.
//

import Foundation

struct ExpenseEntity {
    let id: Int
    let amount: Double
    let description: String = ""
    let createdAt: Date
    let category: CategoryEntity
}
