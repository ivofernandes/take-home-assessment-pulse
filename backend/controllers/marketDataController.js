const express = require('express');
const router = express.Router();
const { mockMarketData } = require('../data/mockMarketData');

// GET /api/market-data
// Get all market data
router.get('/', (req, res) => {
  try {
    res.json({
      success: true,
      data: mockMarketData.getAllSymbols()
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: { message: 'Failed to fetch market data' }
    });
  }
});

// GET /api/market-data/:symbol
// Get market data for a specific symbol
router.get('/:symbol', (req, res) => {
  try {
    const { symbol } = req.params;
    const data = mockMarketData.getSymbol(symbol.toUpperCase());

    if (!data) {
      return res.status(404).json({
        success: false,
        error: { message: `Symbol ${symbol} not found` }
      });
    }

    res.json({
      success: true,
      data
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: { message: 'Failed to fetch market data' }
    });
  }
});

// GET /api/market-data/:symbol/history
// Get historical price data for a symbol
router.get('/:symbol/history', (req, res) => {
  try {
    const { symbol } = req.params;
    const { timeframe = '1h', limit = 100 } = req.query;
    
    const history = mockMarketData.getHistory(symbol.toUpperCase(), timeframe, parseInt(limit));

    if (!history) {
      return res.status(404).json({
        success: false,
        error: { message: `History not found for symbol ${symbol}` }
      });
    }

    res.json({
      success: true,
      data: history
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: { message: 'Failed to fetch historical data' }
    });
  }
});

module.exports = { marketDataController: router };
