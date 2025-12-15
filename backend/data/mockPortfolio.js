// Mock portfolio data for assessment
let holdings = [
  {
    id: '1',
    symbol: 'BTC/USD',
    quantity: 0.5,
    averagePrice: 42000.00,
    currentPrice: 43250.50,
    value: 21625.25,
    pnl: 625.25,
    pnlPercent: 2.98,
    allocation: 45.2
  },
  {
    id: '2',
    symbol: 'ETH/USD',
    quantity: 5.0,
    averagePrice: 2700.00,
    currentPrice: 2650.75,
    value: 13253.75,
    pnl: -246.25,
    pnlPercent: -1.82,
    allocation: 27.7
  },
  {
    id: '3',
    symbol: 'SOL/USD',
    quantity: 100.0,
    averagePrice: 95.00,
    currentPrice: 98.25,
    value: 9825.00,
    pnl: 325.00,
    pnlPercent: 3.42,
    allocation: 20.5
  },
  {
    id: '4',
    symbol: 'ADA/USD',
    quantity: 5000.0,
    averagePrice: 0.50,
    currentPrice: 0.52,
    value: 2600.00,
    pnl: 100.00,
    pnlPercent: 4.00,
    allocation: 5.4
  }
];

let transactions = [
  {
    id: '1',
    type: 'buy',
    symbol: 'BTC/USD',
    quantity: 0.5,
    price: 42000.00,
    timestamp: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString()
  },
  {
    id: '2',
    type: 'buy',
    symbol: 'ETH/USD',
    quantity: 5.0,
    price: 2700.00,
    timestamp: new Date(Date.now() - 5 * 24 * 60 * 60 * 1000).toISOString()
  },
  {
    id: '3',
    type: 'buy',
    symbol: 'SOL/USD',
    quantity: 100.0,
    price: 95.00,
    timestamp: new Date(Date.now() - 3 * 24 * 60 * 60 * 1000).toISOString()
  },
  {
    id: '4',
    type: 'buy',
    symbol: 'ADA/USD',
    quantity: 5000.0,
    price: 0.50,
    timestamp: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000).toISOString()
  }
];

const mockPortfolio = {
  getSummary: () => {
    const totalValue = holdings.reduce((sum, h) => sum + h.value, 0);
    const totalPnl = holdings.reduce((sum, h) => sum + h.pnl, 0);
    const totalPnlPercent = (totalPnl / (totalValue - totalPnl)) * 100;

    return {
      totalValue: totalValue.toFixed(2),
      totalPnl: totalPnl.toFixed(2),
      totalPnlPercent: totalPnlPercent.toFixed(2),
      totalHoldings: holdings.length,
      lastUpdated: new Date().toISOString()
    };
  },

  getHoldings: () => {
    // Update current prices with slight variation
    return holdings.map(h => ({
      ...h,
      currentPrice: h.currentPrice * (1 + (Math.random() - 0.5) * 0.001),
      value: h.quantity * (h.currentPrice * (1 + (Math.random() - 0.5) * 0.001)),
      lastUpdated: new Date().toISOString()
    }));
  },

  getPerformance: (timeframe) => {
    const days = timeframe === '7d' ? 7 : timeframe === '30d' ? 30 : 90;
    const data = [];
    const now = Date.now();

    for (let i = days; i >= 0; i--) {
      const timestamp = now - (i * 24 * 60 * 60 * 1000);
      const baseValue = 45000;
      const variation = (Math.random() - 0.5) * 0.05;
      data.push({
        timestamp: new Date(timestamp).toISOString(),
        value: baseValue * (1 + variation),
        pnl: (baseValue * variation).toFixed(2),
        pnlPercent: (variation * 100).toFixed(2)
      });
    }

    return {
      timeframe,
      data,
      summary: {
        startValue: data[0].value.toFixed(2),
        endValue: data[data.length - 1].value.toFixed(2),
        totalReturn: ((data[data.length - 1].value - data[0].value) / data[0].value * 100).toFixed(2)
      }
    };
  },

  addTransaction: (transaction) => {
    const newTransaction = {
      id: (transactions.length + 1).toString(),
      ...transaction
    };
    transactions.push(newTransaction);
    return newTransaction;
  }
};

module.exports = { mockPortfolio };
