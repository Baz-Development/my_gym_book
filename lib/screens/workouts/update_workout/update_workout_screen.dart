import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/workouts_model.dart';
import 'package:my_gym_book/repository/firebase_workout_repository.dart';

class UpdateWorkoutScreen extends StatefulWidget {
  final WorkoutModel workout;

  const UpdateWorkoutScreen({Key? key, required this.workout}) : super(key: key);

  @override
  _UpdateWorkoutScreenState createState() => _UpdateWorkoutScreenState();
}

class _UpdateWorkoutScreenState extends State<UpdateWorkoutScreen> {
  final WorkoutRepository _workoutRepository = WorkoutRepository();

  @override
  Widget build(BuildContext context) {
    final workout = widget.workout;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Gym Book"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            child: Image(image: NetworkImage("https://i.imgur.com/2osZGYs.jpg")),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Titulo:',
              ),
              controller: TextEditingController(text: workout.name),
              onChanged: (value) {
                // Atualizar a descrição do workout com o novo valor
                workout.name = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 100),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Descrição:',
                  ),
                  controller: TextEditingController(text: workout.description),
                  onChanged: (value) {
                    // Atualizar a descrição do workout com o novo valor
                    workout.description = value;
                  },
                  maxLines: null,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: ElevatedButton(
          onPressed: () async {
            debugPrint("Editar treino");
            _workoutRepository.updateWorkout(workout.workoutId, workout);
            Navigator.pop(context, workout);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text("Salvar"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
