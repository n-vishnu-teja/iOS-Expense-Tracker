import SwiftUI

struct AddExpenseView: View {
    @ObservedObject var expenseManager: ExpenseManager
    @State private var title = ""
    @State private var amount = ""
    @State private var selectedCategory = "Food & Dining"
    @State private var date = Date()
    @State private var notes = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                // Title Section
                Section(header: Text("Expense Details")) {
                    TextField("Expense title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    HStack {
                        Text("$")
                            .foregroundColor(.secondary)
                        
                        TextField("0.00", text: $amount)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                
                // Category Section
                Section(header: Text("Category")) {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(expenseManager.categories) { category in
                            HStack {
                                Image(systemName: category.icon)
                                    .foregroundColor(category.color)
                                Text(category.name)
                            }
                            .tag(category.name)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                // Date Section
                Section(header: Text("Date")) {
                    DatePicker(
                        "Date",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(CompactDatePickerStyle())
                }
                
                // Notes Section
                Section(header: Text("Notes (Optional)")) {
                    TextField("Add notes...", text: $notes, axis: .vertical)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .lineLimit(3...6)
                }
                
                // Add Button Section
                Section {
                    Button(action: addExpense) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Expense")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(isFormValid ? Color.blue : Color.gray)
                        )
                    }
                    .disabled(!isFormValid)
                }
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.large)
            .alert("Error", isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !amount.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        Double(amount) != nil &&
        Double(amount)! > 0
    }
    
    private func addExpense() {
        guard let amountValue = Double(amount) else {
            alertMessage = "Please enter a valid amount"
            showingAlert = true
            return
        }
        
        let expense = Expense(
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            amount: amountValue,
            category: selectedCategory,
            date: date,
            notes: notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : notes.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        
        expenseManager.addExpense(expense)
        
        // Reset form
        title = ""
        amount = ""
        selectedCategory = "Food & Dining"
        date = Date()
        notes = ""
        
        // Show success feedback
        alertMessage = "Expense added successfully!"
        showingAlert = true
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView(expenseManager: ExpenseManager())
    }
} 