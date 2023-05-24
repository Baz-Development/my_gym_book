import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/workouts_model.dart';
import 'dart:async';
import 'package:my_gym_book/repository/firebase_workout_repository.dart';
import 'package:my_gym_book/screens/workouts/details/workout_details_screen.dart';
import 'package:my_gym_book/screens/workouts/new_workout/new_workout_screen.dart';

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
              final value = await Navigator.push(
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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 15,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Workouts",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            workoutListBuilder()
          ],
        ),
      ),
    );
  }

  Future<void> _deleteWorkout(int index) async {
    debugPrint("Excluir treino");
    await _workoutRepository.deleteWorkout(workouts[index].workoutId);
    await fetchData(); // Atualiza a lista de treinos após a exclusão
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

  Future<void> _navigateToWorkoutDetailsScreen(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutDetailsScreen(workout: workouts[index]),
      ),
    );
    await fetchData(); // Atualiza a lista de treinos após a atualização do treino
  }

  Widget workoutListBuilder() {
    return ListView.builder(
      itemCount: workouts.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => _navigateToWorkoutDetailsScreen(index),
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