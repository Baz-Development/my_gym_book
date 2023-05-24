import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/exercices_model.dart';
import 'package:my_gym_book/common/models/workouts_model.dart';
import 'package:my_gym_book/repository/firebase_workout_repository.dart';

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
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _seriesController,
              decoration: const InputDecoration(labelText: 'Séries'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _repetitionCountController,
              decoration: const InputDecoration(labelText: 'Contagem de Repetições'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(labelText: 'Peso'),
            ),
            TextField(
              controller: _intervalController,
              decoration: const InputDecoration(labelText: 'Intervalo'),
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
    final weight = _weightController.text;
    final interval = int.tryParse(_intervalController.text) ?? 0;

    if (title.isNotEmpty && series > 0 && repetitionCount > 0 && weight.isNotEmpty && interval > 0) {
      final newExercise = ExercicesModel(
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
      workout.exercices.add(newExercise);
      await _workoutRepository.updateWorkout(workoutId, workout);

      Navigator.pop(context, newExercise);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
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
        ),
      );
    }
  }
}