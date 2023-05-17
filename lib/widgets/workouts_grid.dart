import 'package:flutter/material.dart';
import 'package:my_gym_book/common/data/data.dart';
import 'package:my_gym_book/screens/workouts/details/workout_details_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';

class WorkoutGrid extends StatelessWidget {
  const WorkoutGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: workout.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 16 / 7, crossAxisCount: 1, mainAxisSpacing: 20),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkoutDetailsScreen())),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      workout[index].name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          workout[index].exercises,
                          style: const TextStyle(color: Colors.white),
                        ),
                        CircularPercentIndicator(
                          radius: 30,
                          lineWidth: 8,
                          animation: true,
                          animationDuration: 1500,
                          circularStrokeCap: CircularStrokeCap.round,
                          percent: workout[index].percent / 100,
                          progressColor: Colors.white,
                          center: Text(
                            "${workout[index].percent}%",
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
