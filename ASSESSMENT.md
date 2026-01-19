# PulseNow Flutter Developer Assessment

## Overview

Welcome to the PulseNow Flutter Developer assessment! This is a focused assessment designed to evaluate your core Flutter development skills.

## What You'll Build

You'll be building a Flutter mobile application that displays **Market Data** - a list of crypto symbols with their current prices and 24h changes.

## Backend API

A Node.js backend is provided with mock data. The backend runs on `http://localhost:3000` and includes:

- REST API endpoints for market data, analytics, and portfolio
- WebSocket server for real-time updates (`ws://localhost:3000`)
- Mock data that simulates real trading scenarios

See `backend/README.md` for API documentation.

## Assessment Requirements

### Required (Must Complete)

These are the core requirements that must be implemented for the assessment to be considered complete.

#### 1. API Integration 

- [x] Complete `getMarketData()` method in `lib/services/api_service.dart`
- [x] Call `GET /api/market-data` endpoint
- [x] Return parsed JSON data
- [x] Basic error handling (catch exceptions)

#### 2. Data Model 

- [x] Implement `MarketData` class in `lib/models/market_data_model.dart`
- [x] Include required fields: symbol, price, change24h, changePercent24h
- [x] Add `fromJson` factory constructor
- [ ] Ensure proper null safety

#### 3. State Management 

- [x] Complete `lib/providers/market_data_provider.dart`
- [x] Add `loadMarketData()` method that calls the API service
- [x] Manage loading state (`_isLoading`)
- [x] Manage data state (`_marketData`)
- [x] Use `notifyListeners()` to update UI

#### 4. UI Screen 

- [x] Create `lib/screens/market_data_screen.dart`
- [x] Display list of crypto symbols using `ListView` or `ListView.builder`
- [x] Show symbol and price for each item
- [x] Show 24h change with color coding (green for positive, red for negative)
- [x] Display loading indicator while `isLoading` is true
- [x] Display error message when error occurs

#### 5. Code Quality

- [x] Write clean, readable code
- [x] Follow Flutter/Dart best practices
- [x] Ensure proper null safety
- [x] Code compiles and runs without errors

---

### Nice to Have (Optional)

These are enhancements that demonstrate advanced skills but are not required for completion.

#### UI/UX Enhancements

- [x] Implement pull-to-refresh functionality
- [x] Format prices as currency (e.g., $43,250.50)
- [x] Format percentages with + or - sign (e.g., +2.5%)
- [ ] Add empty state when no data is available
- [x] Improve error UI with retry button
- [x] Add smooth animations/transitions
- [x] Make the UI more visually appealing
l
#### Functionality Enhancements

- [x] Navigate to detail view when item is tapped
- [x] Display additional fields (volume, market cap, etc.)
- [x] Add search/filter functionality
- [x] Sort by price, change, or symbol
- [x] Implement WebSocket for real-time updates

#### Code Quality Enhancements

- [x] Add comprehensive error handling
- [ ] Implement proper error types/classes
- [x] Add input validation
- [x] Optimize list rendering (use `ListView.builder` with proper itemExtent)
- [x] Add code comments where helpful
- [x] Implement caching for offline support

#### Advanced Features

- [x] Add unit tests
- [x] Implement proper error recovery
- [ ] Add analytics tracking
- [x] Implement dark mode support

## Technical Constraints

- Use Flutter 3.0+
- Use Provider for state management (already set up)
- Use `http` package for REST API calls (already in dependencies)
- Follow Material Design guidelines
- Support both iOS and Android

## Evaluation Criteria

Your solution will be evaluated on:

1. **Required Features** (60%)
   - All required features are implemented and working
   - API integration is functional
   - State management is correctly implemented
   - UI displays data correctly

2. **Code Quality** (25%)
   - Clean, readable code
   - Proper null safety
   - Correct use of Flutter/Dart patterns
   - Code organization

3. **UI/UX** (15%)
   - Basic functionality works
   - Color coding for positive/negative changes
   - Loading and error states are visible
   - *Bonus points for nice-to-have UI enhancements*

**Note:** Focus on completing all required features first. Nice-to-have features are optional and will be considered as bonus points.

## Getting Started

1. Start the backend server: `cd backend && npm install && npm start`
2. Review the Flutter project structure
3. Implement the required features in this order:
   - Data model (`lib/models/market_data_model.dart`)
   - API service (`lib/services/api_service.dart`)
   - State management (`lib/providers/market_data_provider.dart`)
   - UI screen (`lib/screens/market_data_screen.dart`)
4. Update `lib/screens/home_screen.dart` to show the Market Data screen
5. Test your implementation

## Time Management Tips

**Priority Order:**
1. ✅ Get the app working with required features
2. ⭐ Add nice-to-have features only if you have extra time

## Submission

Submit your complete Flutter project. Focus on getting the core functionality working rather than perfect polish.

## Questions?

If you have any questions about the assessment, please reach out to the hiring team.

Good luck! 🚀