import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/exercises_model.dart';
import 'package:my_gym_book/common/services/firebase_analytics_service.dart';

class WorkoutDoingScreen extends StatefulWidget {
  final List<ExercisesModel> exercices;

  const WorkoutDoingScreen({Key? key, required this.exercices}) : super(key: key);

  @override
  _WorkoutDoingScreenState createState() => _WorkoutDoingScreenState();
}

class _WorkoutDoingScreenState extends State<WorkoutDoingScreen> {

  @override
  void initState() {
    super.initState();
    FirebaseAnalyticsService.logEvent(
        "workout_doing",
        {}
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ExercisesModel> exercices = widget.exercices;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Gym Book"),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: ListView.builder(
        itemCount: exercices.length,
        itemBuilder: (context, index) {
          ExercisesModel cardItem = exercices[index];
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
    );
  }

  Container cardBackgroundByStatus(bool isCompleted) {
    if (isCompleted) {
      return Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16),
            child: Icon(Icons.close),
          ),
        ),
      );
    } else {
      return Container(
        color: Colors.green,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16),
            child: Icon(Icons.check),
          ),
        ),
      );
    }
  }
}
