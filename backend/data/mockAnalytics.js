// Mock analytics data for assessment
const mockAnalytics = {
  getOverview: () => {
    return {
      totalMarketCap: 2500000000000,
      totalVolume24h: 85000000000,
      activeMarkets: 1250,
      topGainer: {
        symbol: 'SOL/USD',
        change: 5.3,
        price: 98.25
      },
      topLoser: {
        symbol: 'ETH/USD',
        change: -1.2,
        price: 2650.75
      },
      marketDominance: {
        btc: 42.5,
        eth: 28.3,
        others: 29.2
      },
      lastUpdated: new Date().toISOString()
    };
  },

  getTrends: (timeframe) => {
    const trends = [];
    const now = Date.now();
    const hours = timeframe === '24h' ? 24 : timeframe === '7d' ? 168 : 720;
    const interval = hours / 20;

    for (let i = 19; i >= 0; i--) {
      const timestamp = now - (i * interval * 3600000);
      trends.push({
        timestamp: new Date(timestamp).toISOString(),
        marketCap: 2500000000000 + (Math.random() - 0.5) * 100000000000,
        volume: 85000000000 + (Math.random() - 0.5) * 10000000000,
        priceIndex: 100 + (Math.random() - 0.5) * 5
      });
    }

    return {
      timeframe,
      data: trends,
      summary: {
        change: (Math.random() - 0.5) * 10,
        volatility: Math.random() * 5 + 2
      }
    };
  },

  getSentiment: () => {
    return {
      overall: {
        score: 65, // 0-100
        label: 'Bullish',
        change24h: 5
      },
      indicators: {
        fearGreedIndex: 68,
        socialSentiment: 72,
        technicalAnalysis: 60,
        onChainMetrics: 65
      },
      breakdown: [
        { category: 'Social Media', score: 75, weight: 0.3 },
        { category: 'News', score: 58, weight: 0.25 },
        { category: 'Technical', score: 60, weight: 0.25 },
        { category: 'On-Chain', score: 65, weight: 0.2 }
      ],
      lastUpdated: new Date().toISOString()
    };
  }
};

module.exports = { mockAnalytics };
