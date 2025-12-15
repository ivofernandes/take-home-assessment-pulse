const express = require('express');
const router = express.Router();
const { mockPortfolio } = require('../data/mockPortfolio');

// GET /api/portfolio
// Get portfolio summary
router.get('/', (req, res) => {
  try {
    res.json({
      success: true,
      data: mockPortfolio.getSummary()
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: { message: 'Failed to fetch portfolio' }
    });
  }
});

// GET /api/portfolio/holdings
// Get portfolio holdings
router.get('/holdings', (req, res) => {
  try {
    res.json({
      success: true,
      data: mockPortfolio.getHoldings()
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: { message: 'Failed to fetch holdings' }
    });
  }
});

// GET /api/portfolio/performance
// Get portfolio performance metrics
router.get('/performance', (req, res) => {
  try {
    const { timeframe = '7d' } = req.query;
    res.json({
      success: true,
      data: mockPortfolio.getPerformance(timeframe)
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: { message: 'Failed to fetch performance data' }
    });
  }
});

// POST /api/portfolio/transactions
// Add a transaction (for testing purposes)
router.post('/transactions', (req, res) => {
  try {
    const { type, symbol, quantity, price } = req.body;

    if (!type || !symbol || !quantity || !price) {
      return res.status(400).json({
        success: false,
        error: { message: 'Missing required fields: type, symbol, quantity, price' }
      });
    }

    const transaction = mockPortfolio.addTransaction({
      type,
      symbol,
      quantity: parseFloat(quantity),
      price: parseFloat(price),
      timestamp: new Date().toISOString()
    });

    res.status(201).json({
      success: true,
      data: transaction
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: { message: 'Failed to add transaction' }
    });
  }
});

module.exports = { portfolioController: router };
