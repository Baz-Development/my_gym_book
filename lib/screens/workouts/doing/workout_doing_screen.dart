import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/exercises_model.dart';
import 'package:my_gym_book/common/services/firebase_analytics_service.dart';
import 'package:my_gym_book/screens/workouts/doing/waiting_screen.dart';
import 'package:my_gym_book/screens/workouts/doing/workout_finished_screen.dart';

class WorkoutDoingScreen extends StatefulWidget {
  final List<ExercisesModel> exercices;

  const WorkoutDoingScreen({Key? key, required this.exercices}) : super(key: key);

  @override
  _WorkoutDoingScreenState createState() => _WorkoutDoingScreenState();
}

class _WorkoutDoingScreenState extends State<WorkoutDoingScreen> {
  final String _screenTitle = "Bora treinar!";
  List<ExercisesModel> exercises = [];
  bool isWaiting = false;
  late Widget _atualScreen = const CircularProgressIndicator();
  late ExercisesModel _atualExercise;
  int _atualSerie = 1;
  late int _repetitions;
  late int _timerSeconds;

  Widget _exerciseScreenBuilder({required ExercisesModel exercise}) {
    return Center(
      child: Text(
        "${exercise.title} Serie: $_atualSerie repetições: $_repetitions"
      )
    );
  }

  @override
  void initState() {
    super.initState();
    var firstExercise = widget.exercices.first;
    setState(() {
      exercises = widget.exercices;
      // seleciona o 1 exercicio
      _atualExercise = firstExercise;

      _repetitions = firstExercise.repetitionCount;
      _timerSeconds = firstExercise.interval;

      // configura a 1 tela com o 1 exercicio
      _atualScreen = _exerciseScreenBuilder(exercise: firstExercise);
    });
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
        leading: const BackButton(),
      ),
      body: _atualScreen,
      floatingActionButton: Visibility(
        visible: !isWaiting,
        child: Container(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> floatingButtonOnClick(BuildContext context) async {
    debugPrint("floating button on click");
    await nextScreen();
  }

  Future<void> nextScreen() async {
    setState(() {
      isWaiting = !isWaiting;
    });
    if(isWaiting) {
      // intervalo
      debugPrint("intervalo");
      // await Future.delayed(Duration(seconds: timerSeconds));
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WaitingScreen(duration: _timerSeconds)),
      );
      await nextScreen();
    } else {
      // Exercicio
      debugPrint("exercicio $_atualSerie >= ${_atualExercise.series}");
      if(_atualSerie >= _atualExercise.series) {
        debugPrint("Acabou as series");
        var index = exercises.indexOf(_atualExercise);
        debugPrint("verify: $index > ${exercises.length}");
        if(index+1 >= exercises.length) { // check isFinished
          debugPrint("Finished");
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
          _timerSeconds = _atualExercise.interval;

          _atualScreen = _exerciseScreenBuilder(exercise: _atualExercise);
        });
      } else {
        setState(() {
          _atualSerie += 1;
          _atualScreen = _exerciseScreenBuilder(exercise: _atualExercise);
        });
        debugPrint("serie: $_atualSerie");
      }
    }
  }
}
