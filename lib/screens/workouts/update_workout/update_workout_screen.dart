import 'package:flutter/material.dart';

class UpdateWorkoutScreen extends StatefulWidget {
  const UpdateWorkoutScreen({super.key});

  @override
  _UpdateWorkoutScreenState createState() => _UpdateWorkoutScreenState();
}
class _UpdateWorkoutScreenState extends State<UpdateWorkoutScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Gym Book"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Update Workout page",
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
    );
  }
}