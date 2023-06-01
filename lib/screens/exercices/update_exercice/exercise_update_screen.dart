import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/exercises_model.dart';
import 'package:my_gym_book/common/models/workouts_model.dart';
import 'package:my_gym_book/repository/firebase_workout_repository.dart';

class ExerciseUpdateScreen extends StatelessWidget {
  final ExercisesModel exercice;
  final String workoutId;
  final WorkoutRepository _workoutRepository = WorkoutRepository();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _seriesController = TextEditingController();
  final TextEditingController _repetitionCountController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _intervalController = TextEditingController();

  ExerciseUpdateScreen({Key? key, required this.exercice, required this.workoutId}) : super(key: key) {
    _titleController.text = exercice.title;
    _seriesController.text = exercice.series.toString();
    _repetitionCountController.text = exercice.repetitionCount.toString();
    _weightController.text = exercice.weight;
    _intervalController.text = exercice.interval.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Exercício'),
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
                _updateExercise(context);
              },
              child: const Text('Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateExercise(BuildContext context) async {
    final title = _titleController.text;
    final series = int.tryParse(_seriesController.text) ?? 0;
    final repetitionCount = int.tryParse(_repetitionCountController.text) ?? 0;
    final weight = _weightController.text;
    final interval = int.tryParse(_intervalController.text) ?? 0;

    if (title.isNotEmpty && series > 0 && repetitionCount > 0 && weight.isNotEmpty && interval > 0) {
      final updatedExercise = ExercisesModel(
        exercisesId: exercice.exercisesId,
        title: title,
        imagePath: 'https://i.imgur.com/2osZGYs.jpg',
        series: series,
        repetitionCount: repetitionCount,
        weight: weight,
        interval: interval,
      );

      WorkoutModel? fetchedWorkout = await _workoutRepository.getWorkout(workoutId);
      if (fetchedWorkout == null) {
        return;
      }

      fetchedWorkout.exercices.removeWhere((x) => x.exercisesId == exercice.exercisesId);
      fetchedWorkout.exercices.add(updatedExercise);

      await _workoutRepository.updateWorkout(workoutId, fetchedWorkout);

      Navigator.pop(context, updatedExercise);
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
