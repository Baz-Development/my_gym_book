import 'package:my_gym_book/common/models/exercices_model.dart';
import 'package:my_gym_book/common/models/workouts_model.dart';

final List<WorkoutModel> workout = [
  WorkoutModel(
    "123-123-123-123-123-123",
    "Leg Day",
    [
      ExercicesModel(
        title: "Agachamento sumo",
        imagePath: "https://treinomestre.com.br/wp-content/uploads/2015/11/agachamento-sumo-musculos-.jpg",
        series: 3,
        repetitionCount: 12,
        weight: "50 kg",
        interval: 30
      ),
      ExercicesModel(
          title: "Extensora",
          imagePath: "https://treinomestre.com.br/wp-content/uploads/2016/08/cadeira-extensora-execucao-correta-.jpg",
          series: 3,
          repetitionCount: 12,
          weight: "75 kg",
          interval: 30
      ),
      ExercicesModel(
          title: "Abdutora",
          imagePath: "https://img.irroba.com.br/filters:fill(fff):quality(80)/naturalf/catalog/linha-s/linha-p/q21.jpg",
          series: 3,
          repetitionCount: 12,
          weight: "80 kg",
          interval: 30
      )
    ]
  ),
  WorkoutModel(
    "122-123-133-133-123-123",
    "Biceps Day",
    [
      ExercicesModel(
          title: "Rosca direta",
          imagePath: "https://treinomestre.com.br/wp-content/uploads/2015/11/agachamento-sumo-musculos-.jpg",
          series: 3,
          repetitionCount: 12,
          weight: "12 kg",
          interval: 30
      ),
      ExercicesModel(
          title: "Rosca concentrada",
          imagePath: "https://treinomestre.com.br/wp-content/uploads/2016/08/cadeira-extensora-execucao-correta-.jpg",
          series: 3,
          repetitionCount: 12,
          weight: "75 kg",
          interval: 30
      ),
    ]
  ),
];