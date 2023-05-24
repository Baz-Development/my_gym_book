import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/workouts_model.dart';
import 'package:my_gym_book/screens/workouts/doing/workout_doing_screen.dart';
import 'package:my_gym_book/screens/workouts/update_workout/update_workout_screen.dart';

class WorkoutDetailsScreen extends StatefulWidget {
  final WorkoutModel workout;

  const WorkoutDetailsScreen({Key? key, required this.workout}) : super(key: key);

  @override
  _WorkoutDetailsScreenState createState() => _WorkoutDetailsScreenState();
}

class _WorkoutDetailsScreenState extends State<WorkoutDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final workout = widget.workout;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Gym Book"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              debugPrint("edit");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UpdateWorkoutScreen()),
              );
            },
            icon: const Icon(Icons.edit),
          )
        ],
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
            child: Text(
              workout.name,
              style: const TextStyle(fontSize: 18, color: Colors.black54),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 100),
            child: Column(
              children: [
                Text(workout.description)
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WorkoutDoingScreen(exercices: workout.exercices)),
            );
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text("Começar treino"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
