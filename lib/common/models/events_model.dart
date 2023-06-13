import 'package:my_gym_book/common/models/exercises_model.dart';

class EventModel {
  String eventId;
  String title;
  List<ExercisesModel> exercises;

  EventModel({
    required this.eventId,
    required this.title,
    this.exercises = const [],
  });

  EventModel.fromJson(Map<String, dynamic> json)
      : eventId = json['eventId'],
        title = json['title'],
        exercises = (json['exercises'] as List<dynamic>)
            .map((exerciseJson) => ExercisesModel.fromJson(exerciseJson))
            .toList();

  Map<String, dynamic> toJson() => {
    'eventId': eventId,
    'title': title,
    'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
  };

  @override
  String toString() => title;
}
