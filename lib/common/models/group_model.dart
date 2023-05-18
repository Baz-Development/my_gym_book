import 'package:my_gym_book/common/models/user_model.dart';

class GroupModel {
  String name;
  List<UserModel> users;

  GroupModel(
    this.name,
    this.users
  );

  GroupModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        users = json['users'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'users': users
  };
}