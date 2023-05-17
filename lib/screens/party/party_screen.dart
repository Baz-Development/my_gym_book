import 'package:flutter/material.dart';
import 'package:my_gym_book/common/models/user_model.dart';
import 'package:my_gym_book/widgets/search_user.dart';
import 'package:my_gym_book/widgets/user_modal.dart';

class PartyScreen extends StatefulWidget {
  const PartyScreen({super.key});

  @override
  _PartyScreenState createState() => _PartyScreenState();
}
class _PartyScreenState extends State<PartyScreen>{
  List<UserModel> items = [
    UserModel("Felipe", "fbazmitsuishi@gmail.com"),
    UserModel("Davi Dias", "Dias@gmail.com"),
    UserModel("Davi Giuberti", "Giuberti.com"),
    UserModel("Lua", "Lua@gmail.com"),
    UserModel("Henrique", "Henrique@gmail.com"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: itemList(
        items: items,
        onItemDismissed: (index) {
          removeFriendParty(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Botão + pressionado');
          searchFriendParty();
        },
        child: const Icon(
          Icons.add,
          size: 36,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget itemList({required List<UserModel> items, required Null Function(dynamic index) onItemDismissed}) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              builder: (BuildContext context) {
                return UserModal(user: item);
              }
            );
          },
          child: Dismissible(
            key: Key(item.email),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                onItemDismissed(index);
              }
            },
            child: ListTile(
              title: Text(item.fullname),
              trailing: const Icon(Icons.drag_handle),
            ),
          ),
        );
      },
    );
  }

  searchFriendParty() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return UserSearchModal(
          addToList: (UserModel user) {
            addFriendParty(user);
          },
        );
      }
    );
  }

  addFriendParty(UserModel user) {
    setState(() {
      items.add(user);
    });
  }

  removeFriendParty(dynamic index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${items[index].fullname} removido'),
        duration: const Duration(seconds: 1),
      ),
    );
    items.removeAt(index);
  }
}