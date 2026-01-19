import 'package:flutter/foundation.dart';

class AnalyticsService {
  static void logEvent(String name, {Map<String, Object?>? parameters}) {
    if (kDebugMode) {
      //TODO integrate with real analytics service like firebase before going to production
      debugPrint('Analytics event: $name ${parameters ?? {}}');
    }
  }
}
