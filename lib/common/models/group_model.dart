import 'package:my_gym_book/common/models/user_model.dart';
import 'package:my_gym_book/common/models/workouts_model.dart';

class GroupModel {
  String groupId;
  String name;
  List<UserModel> users;
  List<WorkoutModel> workouts;

  GroupModel(
      this.groupId,
      this.name,
      this.users, {
        this.workouts = const [],
      });

  GroupModel.fromJson(Map<String, dynamic> json)
      : groupId = json['groupId'],
        name = json['name'],
        users = (json['users'] as List<dynamic>)
            .map((userJson) => UserModel.fromJson(userJson))
            .toList(),
        workouts = (json['workouts'] as List<dynamic>)
            .map((workoutJson) => WorkoutModel.fromJson(workoutJson))
            .toList();

  Map<String, dynamic> toJson() => {
    'groupId': groupId,
    'name': name,
    'users': users.map((user) => user.toJson()).toList(),
    'workouts': workouts.map((workout) => workout.toJson()).toList(),
  };
}