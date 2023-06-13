import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/exercises_model.dart';
import 'package:my_gym_book/common/models/workouts_model.dart';
import 'package:my_gym_book/common/services/firebase_analytics_service.dart';
import 'package:my_gym_book/repository/firebase_workout_repository.dart';
import 'package:uuid/uuid.dart';

class ExerciseCreationScreen extends StatelessWidget {
  final WorkoutRepository _workoutRepository = WorkoutRepository();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _seriesController = TextEditingController();
  final TextEditingController _repetitionCountController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _intervalController = TextEditingController();
  final String workoutId;

  ExerciseCreationScreen({super.key, required this.workoutId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Exercício'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                  hintText: "Insira um nome para o exercício"
              ),
            ),
            TextField(
              controller: _seriesController,
              decoration: const InputDecoration(
                labelText: 'Séries',
                hintText: "Insira a quantidade de séries"
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _repetitionCountController,
              decoration: const InputDecoration(
                labelText: 'Contagem de Repetições',
                  hintText: "Insira quantas repetições devem ser feitas por série"
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(
                labelText: 'Peso',
                hintText: "Insira o peso inicial para o exercício, ex: 10 Kg"
              ),
            ),
            TextField(
              controller: _intervalController,
              decoration: const InputDecoration(
                labelText: 'Intervalo',
                hintText: "Insira a quantidade de segundos entre exercícios"
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _createExercise(context);
              },
              child: const Text('Criar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createExercise(BuildContext context) async {
    final title = _titleController.text;
    final series = int.tryParse(_seriesController.text) ?? 0;
    final repetitionCount = int.tryParse(_repetitionCountController.text) ?? 0;
    final weight = int.tryParse(_weightController.text) ?? 0;
    final interval = int.tryParse(_intervalController.text) ?? 0;

    if (title.isNotEmpty && series > 0 && repetitionCount > 0 && weight > 0 && interval > 0) {
      final newExercise = ExercisesModel(
        exercisesId: const Uuid().v4(),
        title: title,
        imagePath: 'https://i.imgur.com/2osZGYs.jpg',
        series: series,
        repetitionCount: repetitionCount,
        weight: weight,
        interval: interval,
      );
      WorkoutModel? workout = await _workoutRepository.getWorkout(workoutId);
      if (workout == null) {
        return;
      }
      workout.exercises.add(newExercise);
      await _workoutRepository.updateWorkout(workoutId, workout);
      FirebaseAnalyticsService.logEvent(
          "exercises_create_finish",
          {}
      );
      Navigator.pop(context, newExercise);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          FirebaseAnalyticsService.logEvent(
              "exercises_create_bad_request",
              {
                "title": title,
                "series": series,
                "repetitionCount": repetitionCount,
                "weight": weight,
                "interval": interval
              }
          );
          return AlertDialog(
            title: const Text('Campos inválidos'),
            content: const Text('Preencha todos os campos corretamente.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        }
      );
    }
  }
}