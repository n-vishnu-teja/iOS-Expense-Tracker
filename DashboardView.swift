import SwiftUI

struct DashboardView: View {
    @ObservedObject var expenseManager: ExpenseManager
    @State private var selectedMonth = Date()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Header with total
                    TotalExpenseCard(total: expenseManager.getTotalExpenses())
                    
                    // Monthly selector
                    MonthSelector(selectedMonth: $selectedMonth)
                    
                    // Category breakdown
                    CategoryBreakdownView(expenseManager: expenseManager)
                    
                    // Recent expenses
                    RecentExpensesView(expenseManager: expenseManager, selectedMonth: selectedMonth)
                }
                .padding()
            }
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct TotalExpenseCard: View {
    let total: Double
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Total Expenses")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("$\(String(format: "%.2f", total))")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
    }
}

struct MonthSelector: View {
    @Binding var selectedMonth: Date
    
    var body: some View {
        HStack {
            Button(action: {
                selectedMonth = Calendar.current.date(byAdding: .month, value: -1, to: selectedMonth) ?? selectedMonth
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.blue)
            }
            
            Spacer()
            
            Text(monthYearFormatter.string(from: selectedMonth))
                .font(.title2)
                .fontWeight(.semibold)
            
            Spacer()
            
            Button(action: {
                selectedMonth = Calendar.current.date(byAdding: .month, value: 1, to: selectedMonth) ?? selectedMonth
            }) {
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .foregroundColor(.blue)
            }
        }
        .padding(.horizontal)
    }
    
    private var monthYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

struct CategoryBreakdownView: View {
    @ObservedObject var expenseManager: ExpenseManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Category Breakdown")
                .font(.headline)
                .padding(.horizontal)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                ForEach(expenseManager.categories) { category in
                    CategoryCard(
                        category: category,
                        amount: expenseManager.getExpensesByCategory()[category.name] ?? 0,
                        total: expenseManager.getTotalExpenses()
                    )
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CategoryCard: View {
    let category: ExpenseCategory
    let amount: Double
    let total: Double
    
    var percentage: Double {
        total > 0 ? (amount / total) * 100 : 0
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: category.icon)
                    .foregroundColor(category.color)
                    .font(.title2)
                
                Spacer()
                
                Text("$\(String(format: "%.2f", amount))")
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            
            Text(category.name)
                .font(.caption)
                .foregroundColor(.secondary)
            
            ProgressView(value: percentage, total: 100)
                .progressViewStyle(LinearProgressViewStyle(tint: category.color))
                .scaleEffect(x: 1, y: 0.5, anchor: .center)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
    }
}

struct RecentExpensesView: View {
    @ObservedObject var expenseManager: ExpenseManager
    let selectedMonth: Date
    
    var monthlyExpenses: [Expense] {
        expenseManager.getExpensesForMonth(selectedMonth)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Recent Expenses")
                .font(.headline)
                .padding(.horizontal)
            
            if monthlyExpenses.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "tray")
                        .font(.system(size: 40))
                        .foregroundColor(.secondary)
                    
                    Text("No expenses this month")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
            } else {
                LazyVStack(spacing: 8) {
                    ForEach(monthlyExpenses.prefix(5)) { expense in
                        ExpenseRow(expense: expense)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ExpenseRow: View {
    let expense: Expense
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(expense.category)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text("$\(String(format: "%.2f", expense.amount))")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemGray6))
        )
    }
} 