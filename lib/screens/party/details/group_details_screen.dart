import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/group_model.dart';
import 'package:my_gym_book/common/models/workouts_model.dart';
import 'package:my_gym_book/common/services/firebase_analytics_service.dart';
import 'package:my_gym_book/repository/firebase_workout_repository.dart';
import 'package:my_gym_book/screens/search_user/search_user_screen.dart';
import 'package:my_gym_book/screens/workouts/details/workout_details_screen.dart';

class PartyDetailsScreen extends StatefulWidget {
  final GroupModel group;

  const PartyDetailsScreen({super.key, required this.group});

  @override
  _PartyDetailsScreenState createState() => _PartyDetailsScreenState();
}

class _PartyDetailsScreenState extends State<PartyDetailsScreen>{
  final _hasMemberList = false;
  final WorkoutRepository _workoutRepository = WorkoutRepository();
  final StreamController<List<WorkoutModel>> _workoutsStreamController = StreamController<List<WorkoutModel>>();
  List<WorkoutModel> workouts = [];

  @override
  void initState() {
    super.initState();
    var email = FirebaseAuth.instance.currentUser?.email;
    if (email == null) {
      return;
    }
    fetchWorkoutsData();
    FirebaseAnalyticsService.logEvent(
        "group_details",
        {
          "email": email,
          "groupId": widget.group.groupId
        }
    );
  }

  Future<void> fetchWorkoutsData() async {
    var workoutRes = await _workoutRepository.getWorkoutsByIds(widget.group.workouts);
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
    final group = widget.group;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Grupo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Image(
              image: NetworkImage("https://i.imgur.com/2osZGYs.jpg")
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  group.name,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black54
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Grupo - ",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black45
                        ),
                      ),
                      Text(
                        "${group.users.length} Membro(s)",
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black45
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          memberList(group),
          workoutHeaderList()
        ],
      ),
    );
  }

  Container memberList(GroupModel group) {
    if(_hasMemberList) {
      return Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        height: 50,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: group.users.length > 5 ? 6 : group.users.length + 1,
          separatorBuilder: (context, index) => const SizedBox(width: 25),
          itemBuilder: (context, index) {
            if (index == group.users.length || index == 5) {
              return SizedBox(
                width: 50,
                child: GestureDetector(
                  onTap: () {
                    debugPrint("Add member");
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SearchUsersScreen(group: group)));
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue, // Define a cor de fundo como azul
                      shape: BoxShape.circle, // Define a forma como circular
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white, // Define a cor do ícone como branco
                    ),
                  ),
                ),
              );
            }
            var user = group.users[index];
            return SizedBox(
              width: 50,
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.imagePath),
              ),
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }

  Widget workoutHeaderList() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Treinos do grupo",
                style: TextStyle(
                  fontSize: 24
                ),
              ),
              IconButton(
                onPressed: () {
                  debugPrint("add workout");
                },
                icon: const Icon(
                    Icons.add
                )
              ),
            ],
          ),
          workoutList(workouts: workouts)
        ],
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
    FirebaseAnalyticsService.logEvent(
        "workout_delete",
        {}
    );
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
    ); // Atualiza a lista de treinos após a atualização do treino
  }

  Widget workoutListBuilder() {
    if (workouts.isNotEmpty) {
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
    } else {
      return const Center(
        child: Text('Sem treinos disponíveis.'),
      );
    }
  }
}