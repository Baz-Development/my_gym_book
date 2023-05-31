import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/workouts_model.dart';
import 'package:my_gym_book/common/services/firebase_analytics_service.dart';
import 'package:my_gym_book/common/theme_helper.dart';
import 'package:my_gym_book/repository/firebase_workout_repository.dart';
import 'package:uuid/uuid.dart';

class NewWorkoutScreen extends StatefulWidget {
  const NewWorkoutScreen({super.key});

  @override
  _NewWorkoutScreenState createState() => _NewWorkoutScreenState();
}
class _NewWorkoutScreenState extends State<NewWorkoutScreen>{
  final WorkoutRepository _workoutRepository = WorkoutRepository();
  final _formKey = GlobalKey<FormState>();

  TextEditingController workoutTitleController = TextEditingController();
  TextEditingController workoutDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    FirebaseAnalyticsService.logEvent(
        "workout_create_start",
        {}
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Gym Book"),
          centerTitle: true,
          leading: const BackButton(),
        ),
        body: Center(
            child: createNewWorkoutForms()
        )
    );
  }

  Widget createNewWorkoutForms() {
    return Container(
      margin: const EdgeInsets.fromLTRB(25, 25, 25, 10),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      alignment: Alignment.center,
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Cadastro",
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.grey
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  child: TextFormField(
                    controller: workoutTitleController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(labelText: 'Nome do treino', hintText: 'Insira o nome do treino'),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "A nome é obrigatório";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  child: TextFormField(
                    controller: workoutDescriptionController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(labelText: 'Descrição do treino', hintText: 'Insira uma breve descrição do treino'),
                    maxLines: null
                  ),
                ),

                const SizedBox(height: 20.0),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: Text(
                        "Salvar",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var workoutTitle = workoutTitleController.text;
                        var workoutDescription = workoutDescriptionController.text;
                        createWorkout(workoutTitle, workoutDescription);
                        Navigator.pop(context, 1);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> createWorkout(String workoutTitle, String workoutDescription) async {
    var workout = WorkoutModel(
      const Uuid().v4(),
      workoutTitle,
      [],
      workoutDescription
    );
    _workoutRepository.createWorkout(workout);
    FirebaseAnalyticsService.logEvent(
        "workout_create_finish",
        {}
    );
  }
}