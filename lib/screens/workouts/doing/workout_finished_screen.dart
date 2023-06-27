import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/exercises_model.dart';
import 'package:my_gym_book/screens/home/home_screen.dart';

class WorkoutFinishedScreen extends StatefulWidget {
  final List<ExercisesModel> finishedExercises;

  const WorkoutFinishedScreen({super.key, required this.finishedExercises});

  @override
  _WorkoutFinishedScreenState createState() => _WorkoutFinishedScreenState();
}

class _WorkoutFinishedScreenState extends State<WorkoutFinishedScreen> {
  late List<ExercisesModel> _finishedExercises;

  @override
  void initState() {
    super.initState();
    _finishedExercises = widget.finishedExercises;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Treino finalizado'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const HomeScreen(),
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 25.0, left:20, right: 20),
            child: SizedBox(
              width: double.infinity,
              child: Image(image: NetworkImage("https://i.imgur.com/2osZGYs.jpg")),
            ),
          ),
          const SizedBox(height: 25),
          const Column(
            children: [
              Text(
                'Bom Trabalho!',
                style: TextStyle(fontSize: 24),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'N',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    '° dia de trabalho concluido',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: const Column(
                      children: [
                        Icon(
                            Icons.directions_run_outlined
                        ),
                        Text(
                            "6.123"
                        ),
                        Text(
                            "Calorias"
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: const Column(
                      children: [
                        Icon(
                            Icons.directions_run_outlined
                        ),
                        Text(
                            "6.123"
                        ),
                        Text(
                            "Calorias"
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: const Column(
                      children: [
                        Icon(
                            Icons.directions_run_outlined
                        ),
                        Text(
                            "6.123"
                        ),
                        Text(
                            "Calorias"
                        ),
                      ],
                    ),
                  )
                ]
            ),
          ),
          const SizedBox(height: 25),
          const Text("Estatisticas de hoje"),
          Expanded(
            child: ListView.builder(
              itemCount: _finishedExercises.length,
              itemBuilder: (context, index) {
                ExercisesModel cardItem = _finishedExercises[index];
                double energyExpenditure = 5 * cardItem.weight * ((cardItem.duration ?? 0/60)/60);
                return Card(
                  color: Colors.blue,
                  child: ListTile(
                    title: Text(cardItem.title),
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.schedule),
                            Row(
                              children: [
                                Text((cardItem.duration ?? 0).toString()),
                                const Text(' segundos'),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.bolt),
                            Row(
                              children: [
                                Text(energyExpenditure.toStringAsFixed(1)),
                                const Text(' calorias'),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.fitness_center),
                            Row(
                              children: [
                                Text(cardItem.weight.toString()),
                                const Text(' Kg'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    leading: Image(
                      image: NetworkImage(cardItem.imagePath),
                    ),
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}
