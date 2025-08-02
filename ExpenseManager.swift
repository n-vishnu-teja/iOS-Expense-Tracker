import Foundation
import SwiftUI

class ExpenseManager: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var categories: [ExpenseCategory] = [
        ExpenseCategory(name: "Food & Dining", icon: "fork.knife", color: .orange),
        ExpenseCategory(name: "Transportation", icon: "car.fill", color: .blue),
        ExpenseCategory(name: "Shopping", icon: "bag.fill", color: .purple),
        ExpenseCategory(name: "Entertainment", icon: "gamecontroller.fill", color: .green),
        ExpenseCategory(name: "Healthcare", icon: "cross.fill", color: .red),
        ExpenseCategory(name: "Utilities", icon: "bolt.fill", color: .yellow),
        ExpenseCategory(name: "Education", icon: "book.fill", color: .indigo),
        ExpenseCategory(name: "Other", icon: "ellipsis.circle.fill", color: .gray)
    ]
    
    init() {
        loadExpenses()
    }
    
    func addExpense(_ expense: Expense) {
        expenses.append(expense)
        saveExpenses()
    }
    
    func deleteExpense(_ expense: Expense) {
        if let index = expenses.firstIndex(where: { $0.id == expense.id }) {
            expenses.remove(at: index)
            saveExpenses()
        }
    }
    
    func getTotalExpenses() -> Double {
        return expenses.reduce(0) { $0 + $1.amount }
    }
    
    func getExpensesByCategory() -> [String: Double] {
        var categoryTotals: [String: Double] = [:]
        for expense in expenses {
            categoryTotals[expense.category, default: 0] += expense.amount
        }
        return categoryTotals
    }
    
    func getExpensesForMonth(_ date: Date) -> [Expense] {
        let calendar = Calendar.current
        return expenses.filter { expense in
            calendar.isDate(expense.date, equalTo: date, toGranularity: .month)
        }
    }
    
    private func saveExpenses() {
        if let encoded = try? JSONEncoder().encode(expenses) {
            UserDefaults.standard.set(encoded, forKey: "expenses")
        }
    }
    
    private func loadExpenses() {
        if let data = UserDefaults.standard.data(forKey: "expenses"),
           let decoded = try? JSONDecoder().decode([Expense].self, from: data) {
            expenses = decoded
        }
    }
}

struct Expense: Identifiable, Codable {
    let id = UUID()
    var title: String
    var amount: Double
    var category: String
    var date: Date
    var notes: String?
    
    enum CodingKeys: String, CodingKey {
        case title, amount, category, date, notes
    }
}

struct ExpenseCategory: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
} 