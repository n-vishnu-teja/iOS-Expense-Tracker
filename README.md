# Expense Tracker iOS App

A beautiful and modern iOS expense tracking app built with SwiftUI. Track your daily expenses, view spending analytics, and manage your finances effectively.

## Features

### 📊 Dashboard
- **Total Expenses Overview**: See your total spending at a glance
- **Monthly Navigation**: Browse expenses by month with easy navigation
- **Category Breakdown**: Visual representation of spending by category with progress bars
- **Recent Expenses**: Quick view of your latest expenses

### 📝 Expense Management
- **Add Expenses**: Simple form to add new expenses with title, amount, category, date, and notes
- **Categories**: Pre-defined categories including Food & Dining, Transportation, Shopping, Entertainment, Healthcare, Utilities, Education, and Other
- **Data Persistence**: All data is saved locally using UserDefaults

### 🔍 Search & Filter
- **Search Expenses**: Find expenses by title or category
- **Category Filtering**: Filter expenses by specific categories
- **Sort Options**: Sort by date, amount, title, or category
- **Swipe to Delete**: Easy expense deletion with swipe gestures

### ⚙️ Settings
- **App Information**: Version and app details
- **Data Management**: Export data and clear all expenses
- **Features Overview**: Learn about app capabilities
- **About Section**: App description and privacy information

## Technical Details

### Architecture
- **SwiftUI**: Modern declarative UI framework
- **MVVM Pattern**: Clean separation of concerns
- **ObservableObject**: Reactive data management
- **UserDefaults**: Local data persistence

### File Structure
```
iOSApp/
├── MyApp.swift              # App entry point
├── ContentView.swift        # Main tab view
├── ExpenseManager.swift     # Data management and business logic
├── DashboardView.swift      # Dashboard with charts and analytics
├── ExpensesListView.swift   # List view with search and filtering
├── AddExpenseView.swift     # Add expense form
├── SettingsView.swift       # Settings and app information
└── README.md               # This file
```

### Data Models
- **Expense**: Core data model with id, title, amount, category, date, and optional notes
- **ExpenseCategory**: Category model with name, icon, and color
- **ExpenseManager**: ObservableObject managing all expense operations

## Getting Started

### Prerequisites
- Xcode 15.0 or later
- iOS 17.0 or later
- macOS (for development)

### Installation
1. Open the project in Xcode
2. Select your target device or simulator
3. Build and run the project (⌘+R)

### Usage
1. **Add Expenses**: Tap the "+" tab to add new expenses
2. **View Dashboard**: See spending overview and analytics
3. **Browse Expenses**: Use the "Expenses" tab to view and search all expenses
4. **Manage Settings**: Access app settings and data management options

## Features in Detail

### Dashboard Analytics
- **Total Spending**: Real-time calculation of all expenses
- **Category Distribution**: Visual breakdown of spending by category
- **Monthly Trends**: Navigate through months to see spending patterns
- **Progress Indicators**: Visual progress bars showing category percentages

### Expense Categories
- 🍽️ **Food & Dining**: Restaurants, groceries, coffee shops
- 🚗 **Transportation**: Gas, public transit, ride-sharing
- 🛍️ **Shopping**: Clothing, electronics, general purchases
- 🎮 **Entertainment**: Movies, games, hobbies
- 🏥 **Healthcare**: Medical expenses, prescriptions
- ⚡ **Utilities**: Electricity, water, internet, phone
- 📚 **Education**: Books, courses, training
- 📦 **Other**: Miscellaneous expenses

### Search & Filter Capabilities
- **Real-time Search**: Instant results as you type
- **Category Filters**: Quick filtering by expense category
- **Multiple Sort Options**: Sort by date, amount, title, or category
- **Combined Filters**: Use search and category filters together

### Data Management
- **Local Storage**: All data stored locally on device
- **Export Options**: Export data as CSV or JSON (UI ready)
- **Clear Data**: Option to reset all expenses
- **Privacy Focused**: No data shared with third parties

## UI/UX Features

### Modern Design
- **Clean Interface**: Minimalist design with clear hierarchy
- **Color Coding**: Each category has its own color for easy identification
- **Responsive Layout**: Works on all iPhone sizes
- **Dark Mode Support**: Automatic adaptation to system appearance

### User Experience
- **Intuitive Navigation**: Tab-based navigation for easy access
- **Form Validation**: Real-time validation for expense entry
- **Success Feedback**: Confirmation messages for user actions
- **Empty States**: Helpful messages when no data is available

### Accessibility
- **VoiceOver Support**: Full accessibility for screen readers
- **Dynamic Type**: Text scales with system font size
- **High Contrast**: Works with accessibility settings

## Future Enhancements

### Planned Features
- **Budget Tracking**: Set monthly budgets and track progress
- **Recurring Expenses**: Automatically add regular expenses
- **Photo Receipts**: Attach photos to expense records
- **Export Functionality**: Complete CSV/JSON export implementation
- **iCloud Sync**: Cross-device synchronization
- **Widgets**: Home screen widgets for quick expense entry
- **Charts**: More detailed spending analytics and charts

### Technical Improvements
- **Core Data**: Migrate from UserDefaults to Core Data for better performance
- **Unit Tests**: Comprehensive test coverage
- **UI Tests**: Automated UI testing
- **Performance Optimization**: Optimize for large datasets

## Privacy & Security

- **Local Storage**: All data stored locally on your device
- **No Network Access**: App doesn't require internet connection
- **No Analytics**: No tracking or analytics collection
- **User Control**: Full control over data with export and clear options

## Support

For questions or issues:
1. Check the app settings for information
2. Use the "About" section for app details
3. Clear and reset data if needed through settings

## License

This project is created for educational and personal use.

---

**Expense Tracker** - Your personal finance companion 📱💰 