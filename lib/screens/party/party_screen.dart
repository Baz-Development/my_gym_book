import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/group_model.dart';
import 'package:my_gym_book/common/models/user_model.dart';
import 'package:my_gym_book/repository/firebase_groups_repository.dart';

class PartyScreen extends StatefulWidget {
  const PartyScreen({Key? key}) : super(key: key);

  @override
  _PartyScreenState createState() => _PartyScreenState();
}

class _PartyScreenState extends State<PartyScreen> {
  final GroupRepository _groupRepository = GroupRepository();
  List<GroupModel> groups = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      groups = await _groupRepository.getMyGroups(email);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Gym Book"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              debugPrint("Add group");
              var group = GroupModel(
                "grupo 1",
                [
                  UserModel(
                      "fullname",
                      "email"
                  )
                ]
              );
              _groupRepository.createGroup(group);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const Text(""),
    );
  }
}