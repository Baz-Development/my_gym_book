import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:intl/intl.dart';

class FirebaseAnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> logEvent(String eventName, Map<String, dynamic> parameters) async {
    DateTime currentTimeUTC = DateTime.now().toUtc();
    String formattedDateTimeUTC = DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(currentTimeUTC);
    parameters.addAll(
      {
        "datetimeUTC": formattedDateTimeUTC
      }
    );
    await _analytics.logEvent(
      name: eventName,
      parameters: parameters
    );
  }
}
