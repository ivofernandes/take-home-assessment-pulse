const express = require('express');
const router = express.Router();
const { mockAnalytics } = require('../data/mockAnalytics');

// GET /api/analytics/overview
// Get analytics overview
router.get('/overview', (req, res) => {
  try {
    res.json({
      success: true,
      data: mockAnalytics.getOverview()
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: { message: 'Failed to fetch analytics overview' }
    });
  }
});

// GET /api/analytics/trends
// Get market trends
router.get('/trends', (req, res) => {
  try {
    const { timeframe = '24h' } = req.query;
    res.json({
      success: true,
      data: mockAnalytics.getTrends(timeframe)
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: { message: 'Failed to fetch trends' }
    });
  }
});

// GET /api/analytics/sentiment
// Get market sentiment data
router.get('/sentiment', (req, res) => {
  try {
    res.json({
      success: true,
      data: mockAnalytics.getSentiment()
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      error: { message: 'Failed to fetch sentiment data' }
    });
  }
});

module.exports = { analyticsController: router };
