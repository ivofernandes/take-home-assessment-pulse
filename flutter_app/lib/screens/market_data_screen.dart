import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/market_data_provider.dart';

class MarketDataScreen extends StatefulWidget {
  const MarketDataScreen({super.key});

  @override
  State<MarketDataScreen> createState() => _MarketDataScreenState();
}

class _MarketDataScreenState extends State<MarketDataScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: Load market data when screen initializes
    // Provider.of<MarketDataProvider>(context, listen: false).loadMarketData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketDataProvider>(
      builder: (context, provider, child) {
        // TODO: Implement the UI
        // Show loading indicator when provider.isLoading is true
        // Show error message when provider.error is not null
        // Show list of market data when provider.marketData is available
        // Each list item should show:
        //   - Symbol (e.g., "BTC/USD")
        //   - Price (formatted as currency)
        //   - 24h change (with color: green for positive, red for negative)
        // Implement pull-to-refresh using RefreshIndicator
        
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${provider.error}'),
                ElevatedButton(
                  onPressed: () => provider.loadMarketData(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        
        // TODO: Replace this placeholder with actual list implementation
        return const Center(
          child: Text('Market Data Screen - To be implemented'),
        );
      },
    );
  }
}
