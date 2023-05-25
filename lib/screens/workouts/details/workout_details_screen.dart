import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/exercices_model.dart';
import 'package:my_gym_book/common/models/workouts_model.dart';
import 'package:my_gym_book/common/services/firebase_analytics_service.dart';
import 'package:my_gym_book/repository/firebase_workout_repository.dart';
import 'package:my_gym_book/screens/workouts/doing/workout_doing_screen.dart';
import 'package:my_gym_book/screens/workouts/update_workout/update_workout_screen.dart';

class WorkoutDetailsScreen extends StatefulWidget {
  final WorkoutModel workout;

  const WorkoutDetailsScreen({Key? key, required this.workout}) : super(key: key);

  @override
  _WorkoutDetailsScreenState createState() => _WorkoutDetailsScreenState();
}

class _WorkoutDetailsScreenState extends State<WorkoutDetailsScreen> {
  late WorkoutModel workout;
  final WorkoutRepository _workoutRepository = WorkoutRepository();

  @override
  void initState() {
    super.initState();
    workout = widget.workout;
    FirebaseAnalyticsService.logEvent(
        "workout_details",
        {}
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Gym Book"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              debugPrint("edit");
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateWorkoutScreen(workout: workout)),
              );
              var workoutResponse = await _workoutRepository.getWorkout(workout.workoutId);
              if(workoutResponse == null) {
                return;
              }
              setState(() {
                workout = workoutResponse;
              });
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
            padding: const EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                Text(workout.description),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: ListView.builder(
                itemCount: workout.exercices.length,
                itemBuilder: (context, index) {
                  ExercicesModel cardItem = workout.exercices[index];
                  return Card(
                    child: ListTile(
                      title: Text(cardItem.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Series: ${cardItem.series} Repetições: ${cardItem.repetitionCount}'),
                          Text('Intervalo: ${cardItem.interval} segundos'),
                          Text('Carga: ${cardItem.weight}'),
                        ],
                      ),
                      leading: Image(
                        image: NetworkImage(cardItem.imagePath),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
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
