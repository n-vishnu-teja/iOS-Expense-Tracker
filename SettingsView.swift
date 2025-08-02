import SwiftUI

struct SettingsView: View {
    @State private var showingExportSheet = false
    @State private var showingClearDataAlert = false
    @State private var showingAboutSheet = false
    
    var body: some View {
        NavigationView {
            List {
                // App Info Section
                Section(header: Text("App Information")) {
                    HStack {
                        Image(systemName: "dollarsign.circle.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Expense Tracker")
                                .font(.headline)
                            Text("Version 1.0.0")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 4)
                }
                
                // Data Management Section
                Section(header: Text("Data Management")) {
                    Button(action: {
                        showingExportSheet = true
                    }) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.blue)
                            Text("Export Data")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Button(action: {
                        showingClearDataAlert = true
                    }) {
                        HStack {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                            Text("Clear All Data")
                            Spacer()
                        }
                    }
                }
                
                // App Features Section
                Section(header: Text("Features")) {
                    FeatureRow(
                        icon: "chart.pie.fill",
                        title: "Expense Tracking",
                        description: "Track your daily expenses with categories"
                    )
                    
                    FeatureRow(
                        icon: "chart.bar.fill",
                        title: "Analytics",
                        description: "View spending patterns and insights"
                    )
                    
                    FeatureRow(
                        icon: "magnifyingglass",
                        title: "Search & Filter",
                        description: "Find expenses quickly with advanced search"
                    )
                    
                    FeatureRow(
                        icon: "icloud.fill",
                        title: "Data Persistence",
                        description: "Your data is saved locally on your device"
                    )
                }
                
                // About Section
                Section(header: Text("About")) {
                    Button(action: {
                        showingAboutSheet = true
                    }) {
                        HStack {
                            Image(systemName: "info.circle")
                                .foregroundColor(.blue)
                            Text("About Expense Tracker")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showingExportSheet) {
                ExportDataView()
            }
            .sheet(isPresented: $showingAboutSheet) {
                AboutView()
            }
            .alert("Clear All Data", isPresented: $showingClearDataAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Clear", role: .destructive) {
                    clearAllData()
                }
            } message: {
                Text("This will permanently delete all your expense data. This action cannot be undone.")
            }
        }
    }
    
    private func clearAllData() {
        UserDefaults.standard.removeObject(forKey: "expenses")
        // You would typically also notify the ExpenseManager to refresh
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 2)
    }
}

struct ExportDataView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                Text("Export Data")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Export your expense data as CSV or JSON format for backup or analysis.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                VStack(spacing: 12) {
                    Button(action: {
                        // Export as CSV
                    }) {
                        HStack {
                            Image(systemName: "doc.text")
                            Text("Export as CSV")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                        // Export as JSON
                    }) {
                        HStack {
                            Image(systemName: "doc.text")
                            Text("Export as JSON")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Export Data")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    Image(systemName: "dollarsign.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    
                    VStack(spacing: 8) {
                        Text("Expense Tracker")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Version 1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("About")
                            .font(.headline)
                        
                        Text("Expense Tracker is a simple and intuitive app designed to help you track your daily expenses and manage your finances effectively.")
                            .font(.body)
                        
                        Text("Features:")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            FeatureBullet("Track expenses with categories")
                            FeatureBullet("View spending analytics")
                            FeatureBullet("Search and filter expenses")
                            FeatureBullet("Data persistence")
                            FeatureBullet("Clean and modern UI")
                        }
                        
                        Text("Privacy")
                            .font(.headline)
                        
                        Text("Your expense data is stored locally on your device and is not shared with any third parties.")
                            .font(.body)
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct FeatureBullet: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .font(.body)
                .foregroundColor(.blue)
            
            Text(text)
                .font(.body)
        }
    }
} 