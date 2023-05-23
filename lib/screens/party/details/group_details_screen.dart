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
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: group.users.length + 1,
              separatorBuilder: (context, index) => const SizedBox(width: 25),
              itemBuilder: (context, index) {
                if (index == group.users.length) {
                  return SizedBox(
                    width: 50,
                    child: GestureDetector(
                      onTap: () {
                        debugPrint("Add member");
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
          ),
        ],
      ),
    );
  }
}