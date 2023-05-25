import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class FirebaseAnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> logEvent(String eventName, Map<String, dynamic> parameters) async {
    DateTime currentTimeUTC = DateTime.now().toUtc();
    parameters.addAll(
      {
        "datetimeUTC": currentTimeUTC.toIso8601String()
      }
    );
    debugPrint("log - $eventName - parameters - $parameters");
    await _analytics.logEvent(
      name: eventName,
      parameters: parameters
    );
  }
}
