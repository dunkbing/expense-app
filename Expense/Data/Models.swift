//
//  Models.swift
//  Expense
//
//  Created by Bing on 12/8/24.
//

import Foundation
import SwiftData

@Model
class CategoryModel {
    @Attribute(.unique) var name: String
    var color: String
    var icon: String
    var type: String
    @Relationship(deleteRule: .nullify, inverse: \ExpenseModel.category) var expenses:
        [ExpenseModel]

    init(name: String, color: String, icon: String, type: String, expenses: [ExpenseModel] = []) {
        self.name = name
        self.color = color
        self.icon = icon
        self.type = type
        self.expenses = expenses
    }
}

@Model
class ExpenseModel {
    var amount: Double
    var type: String
    var note: String?
    var category: CategoryModel?
    var payment: CategoryModel?
    var createdAt: Date

    init(
        amount: Double,
        type: String,
        note: String? = nil,
        category: CategoryModel? = nil,
        payment: CategoryModel? = nil,
        createdAt: Date
    ) {
        self.amount = amount
        self.type = type
        self.note = note
        self.category = category
        self.payment = payment
        self.createdAt = createdAt
    }
}
