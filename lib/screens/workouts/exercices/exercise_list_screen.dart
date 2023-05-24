import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/exercices_model.dart';
import 'package:my_gym_book/repository/firebase_workout_repository.dart';
import 'package:my_gym_book/screens/workouts/exercices/new_exercice/exercise_creation_screen.dart';
import 'package:my_gym_book/screens/workouts/exercices/update_exercice/exercise_update_screen.dart';

class ExerciseListScreen extends StatefulWidget {
  final String workoutId;

  ExerciseListScreen({required this.workoutId});

  @override
  _ExerciseListScreenState createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
  List<ExercicesModel> exercises = [];
  final WorkoutRepository _workoutRepository = WorkoutRepository();

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch the exercises when the screen initializes
  }

  void fetchData() async {
    final workoutResponse = await _workoutRepository.getWorkout(widget.workoutId);
    setState(() {
      exercises = workoutResponse!.exercices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Exercícios'),
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return ListTile(
            leading: Image(
              image: NetworkImage(exercises[index].imagePath),
            ),
            title: Text(exercise.title),
            subtitle: Text('Séries: ${exercise.series}'),
            trailing: exercise.isCompleted
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(Icons.check_circle_outline, color: Colors.grey),
            onTap: () {
              _navigateToExerciseUpdateScreen(exercises[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _navigateToExerciseCreationScreen();
        },
      ),
    );
  }

  void _navigateToExerciseCreationScreen() async {
    final newExercise = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExerciseCreationScreen(workoutId: widget.workoutId)),
    );

    if (newExercise != null) {
      fetchData();
    }
  }

  void _navigateToExerciseUpdateScreen(ExercicesModel exercise) async {
    final newExercise = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExerciseUpdateScreen(workoutId: widget.workoutId, exercice: exercise)),
    );

    if (newExercise != null) {
      fetchData();
    }
  }
}
