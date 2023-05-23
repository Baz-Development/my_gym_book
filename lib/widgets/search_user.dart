import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/user_model.dart';

class UserSearchModal extends StatefulWidget {
  final Null Function(UserModel user) addToList;

  const UserSearchModal({super.key, required this.addToList});

  @override
  _UserSearchModalState createState() => _UserSearchModalState(this.addToList);
}

class _UserSearchModalState extends State<UserSearchModal> {
  final Null Function(UserModel user) addToList;

  String email = '';
  List<UserModel> searchResults = [];

  _UserSearchModalState(this.addToList);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            const Text(
              'Digite o email do usuário:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                List<UserModel> response = getUserSearch();
                setState(() {
                  searchResults.addAll(response);
                });
              },
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Resultados:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      addToList(searchResults[index]);
                      Navigator.of(context).pop();
                    },
                    child: ListTile(
                      title: Text(searchResults[index].fullname),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<UserModel> getUserSearch() {
    List<UserModel> items = [
      UserModel("Felipe", "fbazmitsuishi@gmail.com", "https://thumbs.dreamstime.com/z/imagem-do-perfil-do-homem-34444437.jpg"),
      UserModel("Davi Dias", "Dias@gmail.com", "https://thumbs.dreamstime.com/z/imagem-do-perfil-do-homem-34444437.jpg"),
      UserModel("Davi Giuberti", "Giuberti.com", "https://thumbs.dreamstime.com/z/imagem-do-perfil-do-homem-34444437.jpg"),
      UserModel("Lua", "Lua@gmail.com", "https://thumbs.dreamstime.com/z/imagem-do-perfil-do-homem-34444437.jpg"),
      UserModel("Henrique", "Henrique@gmail.com", "https://thumbs.dreamstime.com/z/imagem-do-perfil-do-homem-34444437.jpg"),
    ];
    return items;
  }
}