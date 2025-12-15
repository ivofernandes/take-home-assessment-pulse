# PulseNow Flutter Developer Assessment

This repository contains the take-home assessment for the Flutter Developer position at PulseNow.

## Project Structure

```
.
├── backend/              # Node.js backend API with mock data
│   ├── controllers/      # API route controllers
│   ├── data/            # Mock data generators
│   ├── middlewares/     # Express middlewares
│   └── server.js        # Main server file
│
├── flutter_app/         # Flutter application (to be completed)
│   └── lib/
│       ├── models/      # Data models
│       ├── services/    # API and WebSocket services
│       ├── providers/   # State management
│       └── screens/     # UI screens
│
└── ASSESSMENT.md        # Detailed assessment instructions
```

## Quick Start

### 1. Start the Backend

```bash
cd backend
npm install
npm start
```

The backend will run on `http://localhost:3000`

### 2. Start the Flutter App

```bash
cd flutter_app
flutter pub get
flutter run
```

## Assessment Overview

This is a focused assessment that tests your ability to:

- Integrate Flutter apps with REST APIs
- Implement state management with Provider
- Create UI components for displaying data
- Handle loading and error states
- Write clean, maintainable code

See `ASSESSMENT.md` for detailed requirements and evaluation criteria.

## Backend API

The backend provides a simple **Market Data API** endpoint:
- `GET /api/market-data` - Returns list of crypto symbols with prices and 24h changes

See `backend/README.md` for API documentation.

## Questions?

Contact the hiring team if you have any questions.

Good luck! 🚀
