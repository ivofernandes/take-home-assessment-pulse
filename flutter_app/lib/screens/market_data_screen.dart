import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/market_data_provider.dart';
import '../services/analytics_service.dart';
import 'market_detail_screen.dart';

class MarketDataScreen extends StatefulWidget {
  const MarketDataScreen({super.key});

  @override
  State<MarketDataScreen> createState() => _MarketDataScreenState();
}

class _MarketDataScreenState extends State<MarketDataScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<MarketDataProvider>();
      provider.initialize();
      provider.loadMarketData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketDataProvider>(
      builder: (context, provider, child) {
        final currencyFormatter = NumberFormat.currency(symbol: '\$');
        final percentFormatter = NumberFormat('+#,##0.00;-#,##0.00');
        final compactFormatter = NumberFormat.compactCurrency(symbol: '\$');

        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = provider.filteredMarketData;

        return Column(
          children: [

            if (provider.error != null)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        provider.error!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => provider.loadMarketData(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                onChanged: provider.updateSearchQuery,
                decoration: const InputDecoration(
                  hintText: 'Search symbols',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<SortOption>(
                      value: provider.sortOption,
                      decoration: const InputDecoration(
                        labelText: 'Sort by',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: SortOption.symbol,
                          child: Text('Symbol'),
                        ),
                        DropdownMenuItem(
                          value: SortOption.price,
                          child: Text('Price'),
                        ),
                        DropdownMenuItem(
                          value: SortOption.changePercent24h,
                          child: Text('24h Change'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          provider.updateSortOption(value);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    tooltip:
                        provider.sortAscending ? 'Ascending' : 'Descending',
                    onPressed: provider.toggleSortOrder,
                    icon: Icon(
                      provider.sortAscending
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: [
                  Icon(
                    provider.isWebSocketConnected
                        ? Icons.wifi
                        : Icons.wifi_off,
                    size: 16,
                    color:
                        provider.isWebSocketConnected ? Colors.green : Colors.grey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    provider.isWebSocketConnected
                        ? 'Live updates connected'
                        : 'Live updates offline',
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: provider.loadMarketData,
                child: data.isEmpty
                    ? ListView(
                        children: const [
                          SizedBox(height: 120),
                          Center(child: Text('No market data available.')),
                        ],
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: data.length,
                        itemExtent: 120,
                        itemBuilder: (context, index) {
                          final item = data[index];
                          final isPositive = item.changePercent24h >= 0;
                          final changeColor =
                              isPositive ? Colors.green : Colors.red;
                          return Card(
                            elevation: 1,
                            child: ListTile(
                              onTap: () {
                                AnalyticsService.logEvent(
                                  'open_market_detail',
                                  parameters: {'symbol': item.symbol},
                                );
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        MarketDetailScreen(marketData: item),
                                  ),
                                );
                              },
                              title: Text(
                                item.symbol,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '24h: ${currencyFormatter.format(item.change24h)} '
                                    '(${percentFormatter.format(item.changePercent24h)}%)',
                                    style: TextStyle(color: changeColor),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Vol: ${compactFormatter.format(item.volume)}  '
                                    'MCap: ${item.marketCap == null ? '—' : compactFormatter.format(item.marketCap)}',
                                  ),
                                ],
                              ),
                              trailing: Text(
                                currencyFormatter.format(item.price),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
