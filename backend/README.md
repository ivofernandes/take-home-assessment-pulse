# PulseNow Backend API

This is the backend API for the Flutter assessment. It provides mock data endpoints for market data, analytics, and portfolio management.

## Setup

1. Install dependencies:
```bash
npm install
```

2. Start the server:
```bash
npm start
```

For development with auto-reload:
```bash
npm run dev
```

The server will run on `http://localhost:3000`

## API Endpoints

### Market Data
- `GET /api/market-data` - Get all market symbols
- `GET /api/market-data/:symbol` - Get data for a specific symbol (e.g., BTC/USD)
- `GET /api/market-data/:symbol/history?timeframe=1h&limit=100` - Get historical data

### Analytics
- `GET /api/analytics/overview` - Get analytics overview
- `GET /api/analytics/trends?timeframe=24h` - Get market trends
- `GET /api/analytics/sentiment` - Get market sentiment

### Portfolio
- `GET /api/portfolio` - Get portfolio summary
- `GET /api/portfolio/holdings` - Get portfolio holdings
- `GET /api/portfolio/performance?timeframe=7d` - Get performance metrics
- `POST /api/portfolio/transactions` - Add a transaction

### WebSocket
- `ws://localhost:3000` - Real-time market updates

## Health Check
- `GET /health` - Server health status
