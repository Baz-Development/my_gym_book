import 'package:my_gym_book/common/models/exercices_model.dart';

class WorkoutModel {
  String workoutId;
  String name;
  List<ExercicesModel> exercices;

  WorkoutModel(
      this.workoutId,
      this.name,
      this.exercices,
      );

  WorkoutModel.fromJson(Map<String, dynamic> json)
      : workoutId = json['workoutId'],
        name = json['name'],
        exercices = (json['exercices'] as List<dynamic>)
            .map((exerciceJson) => ExercicesModel.fromJson(exerciceJson))
            .toList();

  Map<String, dynamic> toJson() => {
    'groupId': workoutId,
    'name': name,
    'exercices': exercices.map((exercice) => exercice.toJson()).toList(),
  };
}
