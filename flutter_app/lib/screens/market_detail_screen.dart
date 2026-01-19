import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/market_data_model.dart';

class MarketDetailScreen extends StatelessWidget {
  const MarketDetailScreen({super.key, required this.marketData});

  final MarketData marketData;

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(symbol: '\$');
    final compactFormatter = NumberFormat.compactCurrency(symbol: '\$');
    final percentFormatter = NumberFormat('+#,##0.00;-#,##0.00');

    return Scaffold(
      appBar: AppBar(
        title: Text(marketData.symbol),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            currencyFormatter.format(marketData.price),
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 8),
          Text(
            '${percentFormatter.format(marketData.changePercent24h)}% '
            '(${currencyFormatter.format(marketData.change24h)})',
            style: TextStyle(
              color: marketData.changePercent24h >= 0
                  ? Colors.green
                  : Colors.red,
            ),
          ),
          const SizedBox(height: 16),
          if (marketData.description != null &&
              marketData.description!.isNotEmpty)
            Text(
              marketData.description!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          const SizedBox(height: 16),
          _DetailRow(
            label: '24h Volume',
            value: compactFormatter.format(marketData.volume),
          ),
          _DetailRow(
            label: 'Market Cap',
            value: marketData.marketCap == null
                ? '—'
                : compactFormatter.format(marketData.marketCap),
          ),
          _DetailRow(
            label: '24h High',
            value: marketData.high24h == null
                ? '—'
                : currencyFormatter.format(marketData.high24h),
          ),
          _DetailRow(
            label: '24h Low',
            value: marketData.low24h == null
                ? '—'
                : currencyFormatter.format(marketData.low24h),
          ),
          _DetailRow(
            label: 'Last Updated',
            value: marketData.lastUpdated == null
                ? '—'
                : DateFormat.yMMMd().add_jm().format(marketData.lastUpdated!),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
