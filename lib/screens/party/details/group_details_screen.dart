import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/group_model.dart';

class PartyDetailsScreen extends StatefulWidget {
  final GroupModel group;

  const PartyDetailsScreen({super.key, required this.group});

  @override
  _PartyDetailsScreenState createState() => _PartyDetailsScreenState();
}

class _PartyDetailsScreenState extends State<PartyDetailsScreen>{

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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Grupo: ${group.name}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: group.users.length,
              itemBuilder: (context, index) {
                final member = group.users[index];
                return ListTile(
                  title: Text(member.fullname),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}