import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/group_model.dart';
import 'package:my_gym_book/common/models/user_model.dart';
import 'package:my_gym_book/common/services/firebase_analytics_service.dart';
import 'package:my_gym_book/repository/firebase_groups_repository.dart';
import 'package:my_gym_book/repository/firebase_user_repository.dart';

class SearchUsersScreen extends StatefulWidget {
  final GroupModel group;

  const SearchUsersScreen({super.key, required this.group});

  @override
  _SearchUsersScreenState createState() => _SearchUsersScreenState();
}

class _SearchUsersScreenState extends State<SearchUsersScreen> {
  List<UserModel> userList = [];
  List<UserModel> filteredUserList = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  final GroupRepository _groupRepository = GroupRepository();

  @override
  void initState() {
    fetchAllUsers();
    super.initState();
  }

  void fetchAllUsers() async {
    userList = await getAllUsers();
    setState(() {
      filteredUserList = userList;
      isLoading = false;
    });
  }

  void filterUsers(String keyword) {
    setState(() {
      filteredUserList = userList
          .where((user) =>
          user.email.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  Future<void> addMember(String email) async {
    await addMemberInDB(email);
    // Lógica para adicionar membro
    debugPrint('Membro adicionado: $email');
    FirebaseAnalyticsService.logEvent(
        "group_add_member_success",
        {
          "groupId": widget.group.groupId,
          "user_added": email
        }
    );
    Navigator.pop(context); // Fecha o modal
  }

  Future<void> addMemberInDB(String email) async {
    var group = widget.group;
    var user = await getUser(email);
    await _groupRepository.addMember(group.groupId, user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar membro'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: filterUsers,
              decoration: const InputDecoration(
                labelText: 'Pesquisar usuários',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator()) // Exibe o indicador de progresso enquanto carrega os usuários
                : filteredUserList.isEmpty
                ? const Center(child: Text('Nenhum usuário encontrado')) // Exibe uma mensagem se a lista estiver vazia após a filtragem
                : ListView.builder(
              itemCount: filteredUserList.length,
              itemBuilder: (context, index) {
                final user = filteredUserList[index];
                return ListTile(
                  title: Text(user.email),
                  onTap: () {
                    addMember(user.email);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}