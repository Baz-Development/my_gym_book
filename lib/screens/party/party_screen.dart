import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/group_model.dart';
import 'package:my_gym_book/repository/firebase_groups_repository.dart';
import 'package:my_gym_book/screens/party/details/group_details_screen.dart';

class PartyScreen extends StatefulWidget {
  const PartyScreen({super.key});

  @override
  _PartyScreenState createState() => _PartyScreenState();
}
class _PartyScreenState extends State<PartyScreen>{
  final GroupRepository _groupRepository = GroupRepository();
  List<GroupModel> groups = [];

  @override
  Future<void> initState() async {
    super.initState();
    var email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      groups = await _groupRepository.getMyGroups(email);
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
              _groupRepository.createGroup(group)
            },
            icon: const Icon(
              Icons.add
            ),
          ),
        ],
      ),
      body:  ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          final group = groups[index];
          return ListTile(
            title: Text(group.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroupDetailsScreen(group: group),
                ),
              );
            },
          );
        },
      ),
    );
  }
}