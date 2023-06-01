import 'package:my_gym_book/common/models/exercises_model.dart';

class WorkoutModel {
  String workoutId;
  String name;
  String description;
  List<ExercisesModel> exercises;

  WorkoutModel(
    this.workoutId,
    this.name,
    this.exercises,
    this.description
  );

  WorkoutModel.fromJson(Map<String, dynamic> json)
      : workoutId = json['workoutId'],
        name = json['name'],
        description = json['description'],
        exercises = (json['exercises'] as List<dynamic>)
            .map((exerciceJson) => ExercisesModel.fromJson(exerciceJson))
            .toList();

  Map<String, dynamic> toJson() => {
    'workoutId': workoutId,
    'name': name,
    'description': description,
    'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
  };
}
