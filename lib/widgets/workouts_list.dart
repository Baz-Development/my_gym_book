import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/workouts_model.dart';
import 'package:my_gym_book/repository/firebase_workout_repository.dart';
import 'package:my_gym_book/screens/workouts/details/workout_details_screen.dart';

class WorkoutList extends StatefulWidget {

  const WorkoutList({Key? key}) : super(key: key);

  @override
  _WorkoutListState createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  final WorkoutRepository _workoutRepository = WorkoutRepository();
  List<WorkoutModel> workouts = [];

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    workouts = await _workoutRepository.getAllWorkouts();
    setState(() {}); // Atualiza o estado para refletir as mudanças na lista de treinos
  }

  Future<void> _deleteWorkout(int index) async {
    debugPrint("Excluir treino");
    await _workoutRepository.deleteWorkout(workouts[index].workoutId);
    await _loadWorkouts(); // Atualiza a lista de treinos após a exclusão
    _showSuccessMessage('Treino deletado com sucesso!');
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: workouts.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkoutDetailsScreen(workout: workouts[index]),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    workouts[index].name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: () => _deleteWorkout(index),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}