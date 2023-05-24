import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/workouts_model.dart';
import 'dart:async';
import 'package:my_gym_book/repository/firebase_workout_repository.dart';
import 'package:my_gym_book/screens/workouts/new_workout/new_workout_screen.dart';
import 'package:my_gym_book/widgets/workouts_list.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}
class _WorkoutScreenState extends State<WorkoutScreen>{
  final WorkoutRepository _workoutRepository = WorkoutRepository();
  StreamController<List<WorkoutModel>> _workoutsStreamController = StreamController<List<WorkoutModel>>();
  List<WorkoutModel> workouts = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var workoutRes = await _workoutRepository.getAllWorkouts();
    setState(() {
      workouts = workoutRes;
    });
    _workoutsStreamController.add(workouts);
  }

  @override
  void dispose() {
    _workoutsStreamController.close();
    super.dispose();
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
              debugPrint("Add workout");
              final value =  await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewWorkoutScreen()),
              );
              if (value != null) {
                debugPrint("Should Update workouts");
                fetchData();
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<List<WorkoutModel>>(
        stream: _workoutsStreamController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Sem treinos disponiveis.'),
            );
          }
          workouts = snapshot.data!;
          return workoutList(workouts: workouts);
        },
      ),
    );
  }

  SingleChildScrollView workoutList({required List<WorkoutModel> workouts}) {
    return const SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Workouts",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            WorkoutList()
          ],
        ),
      ),
    );
  }
}