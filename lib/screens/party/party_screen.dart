import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/group_model.dart';
import 'package:my_gym_book/repository/firebase_groups_repository.dart';
import 'package:my_gym_book/repository/firebase_user_repository.dart';
import 'package:my_gym_book/screens/party/details/group_details_screen.dart';
import 'package:my_gym_book/screens/party/new_party/new_party_screen.dart';

class PartyScreen extends StatefulWidget {
  const PartyScreen({Key? key}) : super(key: key);

  @override
  _PartyScreenState createState() => _PartyScreenState();
}

class _PartyScreenState extends State<PartyScreen> {
  final GroupRepository _groupRepository = GroupRepository();
  StreamController<List<GroupModel>> _groupsStreamController = StreamController<List<GroupModel>>();
  List<GroupModel> groups = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var email = FirebaseAuth.instance.currentUser?.email;
    if(email == null){
      return;
    }
    var user = await getUser(email);
    var groupRes = await _groupRepository.getMyGroups(user);
    setState(() {
      groups = groupRes;
    });
    _groupsStreamController.add(groups);
  }

  @override
  void dispose() {
    _groupsStreamController.close();
    super.dispose();
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewPartyScreen()),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<List<GroupModel>>(
        stream: _groupsStreamController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No groups available.'),
            );
          }
          groups = snapshot.data!;
          return createPartyList();
        },
      ),
    );
  }

  Widget createPartyList() {
    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (BuildContext context, int index) {
        GroupModel party = groups[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PartyDetailsScreen(group: party)),
            );
          },
          child: Card(
            child: ListTile(
              title: Text(party.name),
            ),
          ),
        );
      },
    );
  }
}
