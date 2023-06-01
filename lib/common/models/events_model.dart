import 'package:my_gym_book/common/models/exercise_status_model.dart';

class EventModel {
  String title;
  DateTime datetime;
  List<ExercisesStatusModel> exercises;

  EventModel({
    required this.title,
    required this.datetime,
    this.exercises = const []
  });

  EventModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        datetime = json['datetime'],
        exercises = (json['exercices'] as List<dynamic>)
            .map((exerciseJson) => ExercisesStatusModel.fromJson(exerciseJson))
            .toList();

  Map<String, dynamic> toJson() => {
    'title': title,
    'datetime': datetime,
    'exercises': exercises.map((exercise) => exercise.toJson()).toList()
  };

  @override
  String toString() => title;
}