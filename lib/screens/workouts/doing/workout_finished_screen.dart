import 'package:flutter/material.dart';
import 'package:my_gym_book/screens/home/home_screen.dart';

class WorkoutFinishedScreen extends StatefulWidget {
  @override
  _WorkoutFinishedScreenState createState() => _WorkoutFinishedScreenState();
}

class _WorkoutFinishedScreenState extends State<WorkoutFinishedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Finished'),
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
      body: const Center(
        child: Text(
          'Congratulations! Workout Finished!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
