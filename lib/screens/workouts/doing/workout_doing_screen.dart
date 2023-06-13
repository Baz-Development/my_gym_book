import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_gym_book/common/filters/onlydigits.dart';
import 'package:my_gym_book/common/models/events_model.dart';
import 'package:my_gym_book/common/models/exercises_model.dart';
import 'package:my_gym_book/common/services/firebase_analytics_service.dart';
import 'package:my_gym_book/repository/firebase_history_repository.dart';
import 'package:my_gym_book/screens/workouts/doing/waiting_screen.dart';
import 'package:my_gym_book/screens/workouts/doing/workout_finished_screen.dart';
import 'dart:async';

import 'package:uuid/uuid.dart';

class WorkoutDoingScreen extends StatefulWidget {
  final List<ExercisesModel> exercices;
  String title;

  WorkoutDoingScreen({Key? key, required this.exercices, required this.title}) : super(key: key);

  @override
  _WorkoutDoingScreenState createState() => _WorkoutDoingScreenState();
}

class _WorkoutDoingScreenState extends State<WorkoutDoingScreen> {
  final TextEditingController _repetitionsController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  late Widget _atualScreen = const CircularProgressIndicator();
  final HistoryRepository _historyRepository = HistoryRepository();
  final String _screenTitle = "Bora treinar!";
  List<ExercisesModel> exercises = [];
  List<ExercisesModel> finishedExercises = [];
  late ExercisesModel _atualExercise;
  late EventModel event;
  late int _repetitions;
  late int _timerSeconds;
  bool isWaiting = false;
  int _atualSerie = 1;
  late int _weight;

  @override
  void initState() {
    super.initState();
    setState(() {
      event = EventModel(
        eventId: const Uuid().v4(),
        title: widget.title
      );
    });
    var firstExercise = widget.exercices.first;
    setState(() {
      exercises = widget.exercices;
      // seleciona o 1 exercicio
      _atualExercise = firstExercise;

      _repetitions = firstExercise.repetitionCount;
      _weight = firstExercise.weight;
      _timerSeconds = firstExercise.interval;

      // configura a 1 tela com o 1 exercicio
      _atualScreen = _exerciseScreenBuilder(exercise: firstExercise);
    });
    _repetitionsController.text = "$_repetitions";
    _weightController.text = "$_weight";
    FirebaseAnalyticsService.logEvent(
        "workout_doing",
        {}
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screenTitle),
        centerTitle: true,
      ),
      body: _atualScreen,
      floatingActionButton: Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: ElevatedButton(
          onPressed: () async {
            await floatingButtonOnClick(context);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text("Continuar"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> floatingButtonOnClick(BuildContext context) async {
    await nextScreen();
  }

  Future<void> nextScreen() async {
    setState(() {
      isWaiting = !isWaiting;
    });
    if(isWaiting) {
      var value = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WaitingScreen(duration: _timerSeconds)),
      );
      if(value == 1) {
        await nextScreen();
      } else {
        setState(() {
          isWaiting = !isWaiting;
        });
      }
    } else {
      if(_atualSerie >= _atualExercise.series) {
        var index = exercises.indexOf(_atualExercise);
        _atualExercise.repetitionCount = int.tryParse(_repetitionsController.text) ?? 0;
        _atualExercise.weight = int.tryParse(_weightController.text) ?? 0;
        finishedExercises.add(_atualExercise);
        if(index+1 >= exercises.length) { // check isFinished
          setState(() {
            event.exercises = finishedExercises;
          });
          _historyRepository.addEvent(date: DateTime.now(), event: event);
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                WorkoutFinishedScreen(),
            ),
          );
          return;
        }
        setState(() {
          _atualExercise = exercises[index+1];
          _atualSerie = 1;
          _repetitions = _atualExercise.repetitionCount;
          _weight = _atualExercise.weight;
          _timerSeconds = _atualExercise.interval;
          _atualScreen = _exerciseScreenBuilder(exercise: _atualExercise);
        });
      } else {
        setState(() {
          _atualSerie += 1;
          _atualScreen = _exerciseScreenBuilder(exercise: _atualExercise);
        });
      }
    }
  }

  Widget _exerciseScreenBuilder({required ExercisesModel exercise}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: Image(image: NetworkImage("https://i.imgur.com/2osZGYs.jpg")),
            ),
          ),
          Text(
            _atualSerie != _atualExercise.series ?  "${exercise.title} - $_atualSerie/${_atualExercise.series}" : "${exercise.title} - Ultima serie!",
            style: const TextStyle(
              fontSize: 20
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    "Repetições:",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 25,
                        child: TextFormField(
                          controller: _repetitionsController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
                          inputFormatters: <TextInputFormatter>[
                            OnlyDigits(),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MaterialButton(
                            minWidth: 5.0,
                            child: const Icon(Icons.arrow_drop_up),
                            onPressed: () {
                              int currentValue = int.parse(_repetitionsController.text);
                              setState(() {
                                currentValue++;
                                _repetitionsController.text =
                                    (currentValue).toString(); // incrementing value
                              });
                            },
                          ),
                          MaterialButton(
                            minWidth: 5.0,
                            child: const Icon(Icons.arrow_drop_down),
                            onPressed: () {
                              int currentValue = int.parse(_repetitionsController.text);
                              setState(() {
                                currentValue--;
                                _repetitionsController.text =
                                    (currentValue).toString(); // decrementing value
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    "Peso:",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 25,
                        child: TextFormField(
                          controller: _weightController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
                          inputFormatters: <TextInputFormatter>[
                            OnlyDigits(),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MaterialButton(
                            minWidth: 5.0,
                            child: const Icon(Icons.arrow_drop_up),
                            onPressed: () {
                              int currentValue = int.parse(_weightController.text);
                              setState(() {
                                currentValue++;
                                _weightController.text =
                                    (currentValue).toString(); // incrementing value
                              });
                            },
                          ),
                          MaterialButton(
                            minWidth: 5.0,
                            child: const Icon(Icons.arrow_drop_down),
                            onPressed: () {
                              int currentValue = int.parse(_weightController.text);
                              setState(() {
                                currentValue--;
                                _weightController.text =
                                    (currentValue).toString(); // decrementing value
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 25),
          graphWeights(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10 Kg';
        break;
      case 3:
        text = '30 kg';
        break;
      case 5:
        text = '50 kg';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  Widget graphWeights() {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 300,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 1,
            verticalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return const FlLine(
                color: Colors.cyan,
                strokeWidth: 1,
              );
            },
            getDrawingVerticalLine: (value) {
              return const FlLine(
                color: Colors.cyan,
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: bottomTitleWidgets,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: leftTitleWidgets,
                reservedSize: 42,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d)),
          ),
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: 6,
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 3),
                FlSpot(2.6, 2),
                FlSpot(4.9, 5),
                FlSpot(6.8, 3.1),
                FlSpot(8, 4),
                FlSpot(9.5, 3),
                FlSpot(11, 4),
              ],
              isCurved: true,
              gradient: LinearGradient(
                colors: gradientColors,
              ),
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: const FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: gradientColors
                      .map((color) => color.withOpacity(0.3))
                      .toList(),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
