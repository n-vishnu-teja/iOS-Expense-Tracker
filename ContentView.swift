import SwiftUI

struct ContentView: View {
    @StateObject private var expenseManager = ExpenseManager()
    @State private var showingAddExpense = false
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Dashboard Tab
            DashboardView(expenseManager: expenseManager)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Dashboard")
                }
                .tag(0)
            
            // Expenses Tab
            ExpensesListView(expenseManager: expenseManager)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Expenses")
                }
                .tag(1)
            
            // Add Expense Tab
            AddExpenseView(expenseManager: expenseManager)
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Add")
                }
                .tag(2)
            
            // Settings Tab
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(3)
        }
        .accentColor(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} 