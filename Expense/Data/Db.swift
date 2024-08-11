//
//  Db.swift
//  Expense
//
//  Created by Bùi Đặng Bình on 10/8/24.
//

import Foundation
import SQLite

class Db {
    private let categories = Table("expenses")
    private let name = Expression<String?>("name")
    private let icon = Expression<String>("icon")
    private let color = Expression<String>("color")

    private let expenses = Table("expenses")
    private let expenseId = Expression<Int64>("id")
    private let amount = Expression<Double>("amount")
    private let category = Expression<String?>("category")
    private let note = Expression<String?>("note")
    private let createdAt = Expression<String>("created_at")
    let path = NSSearchPathForDirectoriesInDomains(
        .documentDirectory,
        .userDomainMask,
        true
    ).first!

    static let shared = Db()

    private init() {
    }

    func getDb() throws -> Connection {
        let dbPath = "\(self.path)/expense-db2"
        print("db path", dbPath)
        let db = try Connection(dbPath)
        return db
    }

    func createExpense(_ e: ExpenseCreate) {
        print(e)
        do {
            let db = try getDb()
            try db.run(
                expenses.insert(
                    amount <- e.amount,
                    note <- e.note,
                    createdAt <- e.createdAt.formatted(),
                    category <- e.category
                )
            )
        }
        catch {
            print(error)
        }
    }

    func getExpenses() -> [ExpenseEntity] {
        var results: [ExpenseEntity] = []
        do {
            let db = try getDb()
            for expense in try db.prepare(expenses) {
                //                results.append(
                //                    ExpenseEntity(
                //                        id: expense[expenseId],
                //                        amount: expense[amount],
                //                        createdAt: convertStringToDate(expense[createdAt]),
                //                        category: expense[category] ?? ""
                //                    )
                //                )
            }
        }
        catch {
            print(error)
        }
        return results
    }

    func initDb() {
        do {
            let db = try getDb()
            try db.run(
                categories.create(ifNotExists: true) { t in
                    t.column(name, unique: true)
                    t.column(icon)
                    t.column(color)
                }
            )

            print("columns", amount, category, note, createdAt)
            try db.run(
                expenses.create(temporary: true) { t in
                    t.column(expenseId, primaryKey: true)
                    t.column(amount)
                    t.column(category)
                    t.column(note)
                    t.column(createdAt)
                }
            )

            let insertCate = categories.insert(
                name <- "Rent",
                icon <- "🤣",
                color <- "red"
            )

            let insert = expenses.insert(
                amount <- 1000,
                note <- "test amount",
                createdAt <- Date.now.formatted(),
                category <- "Rent"
            )

            for e in try db.prepare(expenses) {
                print(
                    "id: \(e[expenseId]), name: \(e[amount]), email: \(String(describing: e[note]))"
                )
            }
        }
        catch {
            print(error)
        }
    }
}
