import 'package:my_gym_book/common/models/events_model.dart';

class HistoryModel {
  String userEmail;
  String historyId;
  List<EventModel> events;

  HistoryModel({
    required this.userEmail,
    required this.historyId,
    this.events = const []
  });

  HistoryModel.fromJson(Map<String, dynamic> json)
      : userEmail = json['userId'],
        historyId = json['historyId'],
        events = (json['events'] as List<dynamic>)
            .map((eventsJson) => EventModel.fromJson(eventsJson))
            .toList();

  Map<String, dynamic> toJson() => {
    'userId': userEmail,
    'historyId': historyId,
    'events': events.map((event) => event.toJson()).toList()
  };
}
