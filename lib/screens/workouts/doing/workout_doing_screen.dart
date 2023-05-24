import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/exercices_model.dart';

class WorkoutDoingScreen extends StatefulWidget {
  final List<ExercicesModel> exercices;

  const WorkoutDoingScreen({Key? key, required this.exercices}) : super(key: key);

  @override
  _WorkoutDoingScreenState createState() => _WorkoutDoingScreenState();
}

class _WorkoutDoingScreenState extends State<WorkoutDoingScreen> {
  @override
  Widget build(BuildContext context) {
    List<ExercicesModel> exercices = widget.exercices;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Gym Book"),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: ListView.builder(
        itemCount: exercices.length,
        itemBuilder: (context, index) {
          ExercicesModel cardItem = exercices[index];
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 2),
                child: Container(
                  width: 5,
                  height: 75,
                  decoration: BoxDecoration(
                    color: cardItem.isCompleted ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: Dismissible(
                    key: Key(cardItem.title),
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        setState(() {
                          cardItem.isCompleted = !cardItem.isCompleted;
                        });
                        return false;
                      } else {
                        return false;
                      }
                    },
                    background: cardBackgroundByStatus(cardItem.isCompleted),
                    direction: DismissDirection.startToEnd,
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
                  ),
                ),
              ),
            ],
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
