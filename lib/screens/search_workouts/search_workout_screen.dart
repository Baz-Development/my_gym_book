import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/group_model.dart';
import 'package:my_gym_book/common/models/workouts_model.dart';
import 'package:my_gym_book/common/services/firebase_analytics_service.dart';
import 'package:my_gym_book/repository/firebase_groups_repository.dart';
import 'package:my_gym_book/repository/firebase_workout_repository.dart';

class SearchWorkoutScreen extends StatefulWidget {
  final GroupModel group;

  const SearchWorkoutScreen({super.key, required this.group});

  @override
  _SearchWorkoutScreenState createState() => _SearchWorkoutScreenState();
}

class _SearchWorkoutScreenState extends State<SearchWorkoutScreen> {
  List<WorkoutModel> workoutList = [];
  List<WorkoutModel> filteredWorkoutList = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  final GroupRepository _groupRepository = GroupRepository();
  final WorkoutRepository _workoutRepository = WorkoutRepository();

  @override
  void initState() {
    super.initState();
    fetchAllWorkout();
    var email = FirebaseAuth.instance.currentUser?.email;
    if (email == null) {
      return;
    }
    FirebaseAnalyticsService.logEvent(
        "group_workout_link_start",
        {
          "email": email,
          "groupId": widget.group.groupId
        }
    );
  }

  void fetchAllWorkout() async {
    var group = await _groupRepository.getGroup(widget.group.groupId);
    if(group == null){
      return;
    }
    workoutList = await _workoutRepository.getItemsExcept(group.workouts);
    setState(() {
      filteredWorkoutList = workoutList;
      isLoading = false;
    });
  }

  void filterWorkout(String keyword) {
    setState(() {
      filteredWorkoutList = workoutList
          .where((workout) =>
          workout.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  Future<void> addWorkout(String workoutId) async {
    await addWorkoutInDB(workoutId);
    // Lógica para adicionar treino
    debugPrint('Treino adicionado: $workoutId');
    var email = FirebaseAuth.instance.currentUser!.email;
    FirebaseAnalyticsService.logEvent(
        "group_workout_link_finish",
        {
          "groupId": widget.group.groupId,
          "workoutId": workoutId,
          "email": email
        }
    );
    Navigator.pop(context); // Fecha o modal
  }

  Future<void> addWorkoutInDB(String workoutId) async {
    var group = await _groupRepository.getGroup(widget.group.groupId);
    if (group == null) {
      return;
    }
    group.workouts.add(workoutId);
    await _groupRepository.updateGroup(group.groupId, group);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar treino'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: filterWorkout,
              decoration: const InputDecoration(
                labelText: 'Pesquisar treinos',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator()) // Exibe o indicador de progresso enquanto carrega os usuários
                : filteredWorkoutList.isEmpty
                ? const Center(child: Text('Nenhum treino encontrado')) // Exibe uma mensagem se a lista estiver vazia após a filtragem
                : ListView.builder(
              itemCount: filteredWorkoutList.length,
              itemBuilder: (context, index) {
                final workout = filteredWorkoutList[index];
                return ListTile(
                  title: Text(workout.name),
                  onTap: () {
                    addWorkout(workout.workoutId);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}