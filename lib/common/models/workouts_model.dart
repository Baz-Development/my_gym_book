import 'package:my_gym_book/common/models/exercices_model.dart';

class WorkoutModel {
  String workoutId;
  String name;
  String description;
  List<ExercicesModel> exercices;

  WorkoutModel(
    this.workoutId,
    this.name,
    this.exercices,
    this.description
  );

  WorkoutModel.fromJson(Map<String, dynamic> json)
      : workoutId = json['workoutId'],
        name = json['name'],
        description = json['description'],
        exercices = (json['exercices'] as List<dynamic>)
            .map((exerciceJson) => ExercicesModel.fromJson(exerciceJson))
            .toList();

  Map<String, dynamic> toJson() => {
    'workoutId': workoutId,
    'name': name,
    'description': description,
    'exercices': exercices.map((exercice) => exercice.toJson()).toList(),
  };
}