import 'package:flutter/material.dart';
import 'package:my_gym_book/common/data/data.dart';
import 'package:my_gym_book/screens/workouts/details/workout_details_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';

class WorkoutList extends StatelessWidget {
  const WorkoutList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: workout.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkoutDetailsScreen(workout: workout[index]),
              ),
            ),
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
                    workout[index].name,
                    style: const TextStyle(color: Colors.white),
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
