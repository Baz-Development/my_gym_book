import 'package:my_gym_book/common/models/events_model.dart';

class HistoryModel {
  String userEmail;
  String historyId;
  List<EventDateModel> historyEvents;

  HistoryModel({
    required this.userEmail,
    required this.historyId,
    this.historyEvents = const []
  });

  HistoryModel.fromJson(Map<String, dynamic> json)
      : userEmail = json['userId'],
        historyId = json['historyId'],
        historyEvents = (json['historyEvents'] as List<dynamic>)
            .map((eventDateJson) => EventDateModel.fromJson(eventDateJson))
            .toList();

  Map<String, dynamic> toJson() => {
    'userId': userEmail,
    'historyId': historyId,
    'historyEvents': historyEvents.map((eventDate) => eventDate.toJson()).toList()
  };
}

class EventDateModel {
  String date;
  List<EventModel> events;

  EventDateModel(
    {
      required this.date,
      this.events = const []
    }
  );

  EventDateModel.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        events = (json['events'] as List<dynamic>)
            .map((eventsJson) => EventModel.fromJson(eventsJson))
            .toList();

  Map<String, dynamic> toJson() => {
    'date': date,
    'events': events.map((event) => event.toJson()).toList()
  };
}