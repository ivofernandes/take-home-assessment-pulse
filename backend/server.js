const express = require('express');
const cors = require('cors');
const http = require('http');
const WebSocket = require('ws');
const { marketDataController } = require('./controllers/marketDataController');
const { analyticsController } = require('./controllers/analyticsController');
const { portfolioController } = require('./controllers/portfolioController');
const { errorHandler } = require('./middlewares/errorHandler');
const { requestLogger } = require('./middlewares/requestLogger');
const { rateLimiter } = require('./middlewares/rateLimiter');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(requestLogger);
app.use(rateLimiter);

// Routes
app.use('/api/market-data', marketDataController);
app.use('/api/analytics', analyticsController);
app.use('/api/portfolio', portfolioController);

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// Error handling
app.use(errorHandler);

// Create HTTP server
const server = http.createServer(app);

// WebSocket server for real-time updates
const wss = new WebSocket.Server({ server });

wss.on('connection', (ws) => {
  console.log('WebSocket client connected');
  
  // Send initial market data
  const initialData = {
    type: 'market_update',
    data: {
      symbol: 'BTC/USD',
      price: 43250.50,
      change24h: 2.5,
      volume: 1250000000,
      timestamp: new Date().toISOString()
    }
  };
  ws.send(JSON.stringify(initialData));

  // Simulate real-time updates every 2 seconds
  const interval = setInterval(() => {
    const update = {
      type: 'market_update',
      data: {
        symbol: 'BTC/USD',
        price: (43250 + Math.random() * 1000 - 500).toFixed(2),
        change24h: (2.5 + Math.random() * 2 - 1).toFixed(2),
        volume: (1250000000 + Math.random() * 100000000).toFixed(0),
        timestamp: new Date().toISOString()
      }
    };
    
    if (ws.readyState === WebSocket.OPEN) {
      ws.send(JSON.stringify(update));
    }
  }, 2000);

  ws.on('close', () => {
    console.log('WebSocket client disconnected');
    clearInterval(interval);
  });

  ws.on('error', (error) => {
    console.error('WebSocket error:', error);
    clearInterval(interval);
  });
});

server.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
  console.log(`WebSocket server ready on ws://localhost:${PORT}`);
});
