import 'package:flutter/material.dart';

class WorkoutDetailsScreen extends StatefulWidget {
  const WorkoutDetailsScreen({super.key});

  @override
  _WorkoutDetailsScreenState createState() => _WorkoutDetailsScreenState();
}
class _WorkoutDetailsScreenState extends State<WorkoutDetailsScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Gym Book"),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: const Center(
        child: Text(
          "Workout details page",
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
    );
  }

}