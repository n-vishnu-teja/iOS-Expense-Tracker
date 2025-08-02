import SwiftUI

struct ExpensesListView: View {
    @ObservedObject var expenseManager: ExpenseManager
    @State private var searchText = ""
    @State private var selectedCategory = "All"
    @State private var showingSortOptions = false
    @State private var sortOption: SortOption = .date
    
    enum SortOption: String, CaseIterable {
        case date = "Date"
        case amount = "Amount"
        case title = "Title"
        case category = "Category"
    }
    
    var filteredExpenses: [Expense] {
        var expenses = expenseManager.expenses
        
        // Filter by search text
        if !searchText.isEmpty {
            expenses = expenses.filter { expense in
                expense.title.localizedCaseInsensitiveContains(searchText) ||
                expense.category.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Filter by category
        if selectedCategory != "All" {
            expenses = expenses.filter { $0.category == selectedCategory }
        }
        
        // Sort expenses
        switch sortOption {
        case .date:
            expenses.sort { $0.date > $1.date }
        case .amount:
            expenses.sort { $0.amount > $1.amount }
        case .title:
            expenses.sort { $0.title < $1.title }
        case .category:
            expenses.sort { $0.category < $1.category }
        }
        
        return expenses
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search and filter bar
                SearchFilterBar(
                    searchText: $searchText,
                    selectedCategory: $selectedCategory,
                    categories: expenseManager.categories,
                    sortOption: $sortOption,
                    showingSortOptions: $showingSortOptions
                )
                
                // Expenses list
                if filteredExpenses.isEmpty {
                    EmptyStateView(searchText: searchText)
                } else {
                    List {
                        ForEach(filteredExpenses) { expense in
                            ExpenseDetailRow(expense: expense)
                                .swipeActions(edge: .trailing) {
                                    Button("Delete", role: .destructive) {
                                        expenseManager.deleteExpense(expense)
                                    }
                                }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct SearchFilterBar: View {
    @Binding var searchText: String
    @Binding var selectedCategory: String
    let categories: [ExpenseCategory]
    @Binding var sortOption: ExpensesListView.SortOption
    @Binding var showingSortOptions: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                
                TextField("Search expenses...", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemGray6))
            )
            .padding(.horizontal)
            
            // Category filter
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    CategoryFilterButton(
                        title: "All",
                        isSelected: selectedCategory == "All"
                    ) {
                        selectedCategory = "All"
                    }
                    
                    ForEach(categories) { category in
                        CategoryFilterButton(
                            title: category.name,
                            isSelected: selectedCategory == category.name
                        ) {
                            selectedCategory = category.name
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            // Sort button
            HStack {
                Spacer()
                
                Button(action: {
                    showingSortOptions.toggle()
                }) {
                    HStack {
                        Image(systemName: "arrow.up.arrow.down")
                        Text("Sort by \(sortOption.rawValue)")
                    }
                    .font(.caption)
                    .foregroundColor(.blue)
                }
                .actionSheet(isPresented: $showingSortOptions) {
                    ActionSheet(
                        title: Text("Sort by"),
                        buttons: ExpensesListView.SortOption.allCases.map { option in
                            .default(Text(option.rawValue)) {
                                sortOption = option
                            }
                        } + [.cancel()]
                    )
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
    }
}

struct CategoryFilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(isSelected ? Color.blue : Color(.systemGray5))
                )
                .foregroundColor(isSelected ? .white : .primary)
        }
    }
}

struct ExpenseDetailRow: View {
    let expense: Expense
    
    var body: some View {
        HStack(spacing: 12) {
            // Category icon
            Circle()
                .fill(Color.blue.opacity(0.1))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: "dollarsign.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title2)
                )
            
            // Expense details
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                HStack {
                    Text(expense.category)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(dateFormatter.string(from: expense.date))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                if let notes = expense.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            // Amount
            Text("$\(String(format: "%.2f", expense.amount))")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 4)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

struct EmptyStateView: View {
    let searchText: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 50))
                .foregroundColor(.secondary)
            
            Text(searchText.isEmpty ? "No expenses yet" : "No matching expenses")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text(searchText.isEmpty ? "Add your first expense to get started" : "Try adjusting your search or filters")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
} 