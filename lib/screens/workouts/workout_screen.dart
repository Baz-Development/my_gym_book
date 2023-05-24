import 'package:flutter/material.dart';
import 'package:my_gym_book/constant.dart';
import 'package:my_gym_book/widgets/workouts_list.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}
class _WorkoutScreenState extends State<WorkoutScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Gym Book"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: const SingleChildScrollView(
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
      ),
    );
  }

}