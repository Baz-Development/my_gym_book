import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/user_model.dart';

class UserModal extends StatelessWidget {
  final UserModel user;

  const UserModal({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Detalhes do Usuário',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              'Nome'
            ),
            subtitle: Text(user.fullname),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text(
              'Email'
            ),
            subtitle: Text(user.email),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}