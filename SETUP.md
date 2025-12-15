# Setup Instructions

## Prerequisites

- Node.js (v16 or higher)
- Flutter SDK (3.0 or higher)
- Android Studio / Xcode (for mobile development)
- Git

## Backend Setup

1. Navigate to the backend directory:
```bash
cd backend
```

2. Install dependencies:
```bash
npm install
```

3. Start the server:
```bash
npm start
```

The server will run on `http://localhost:3000`

You should see:
```
Server running on http://localhost:3000
WebSocket server ready on ws://localhost:3000
```

## Flutter Setup

1. Navigate to the Flutter app directory:
```bash
cd flutter_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. **Important for Android Emulator:**
   - The Android emulator uses `10.0.2.2` to refer to the host machine's `localhost`
   - Update `lib/utils/constants.dart` to use `10.0.2.2` instead of `localhost` if testing on Android emulator
   - iOS simulator can use `localhost` directly

4. Run the app:
```bash
flutter run
```

## Testing the Backend

You can test the backend API using curl or Postman:

```bash
# Health check
curl http://localhost:3000/health

# Get market data
curl http://localhost:3000/api/market-data

# Get specific symbol
curl http://localhost:3000/api/market-data/BTC/USD

# Get portfolio
curl http://localhost:3000/api/portfolio
```

## Troubleshooting

### Backend Issues

- **Port already in use**: Change the PORT in `backend/.env` or `server.js`
- **Module not found**: Run `npm install` again

### Flutter Issues

- **Connection refused**: Make sure the backend is running
- **Android emulator connection**: Use `10.0.2.2` instead of `localhost` (see `lib/utils/constants.dart`)
- **iOS simulator connection**: `localhost` should work fine
- **Physical device**: Use your computer's IP address instead of `localhost`

### Finding Your Computer's IP Address

- **Windows**: Run `ipconfig` and look for IPv4 Address
- **Mac/Linux**: Run `ifconfig` or `ip addr`

Then update the base URL in `lib/utils/constants.dart` to use your IP address.

## Next Steps

1. Read `ASSESSMENT.md` for detailed requirements (1-hour assessment)
2. Review the backend API: `GET /api/market-data` endpoint
3. Start implementing in this order:
   - Data model (`lib/models/market_data_model.dart`)
   - API service (`lib/services/api_service.dart`)
   - State management (`lib/providers/market_data_provider.dart`)
   - UI screen (`lib/screens/market_data_screen.dart`)
4. Test your implementation

**Time Limit: 1 hour**

Good luck! 🚀
