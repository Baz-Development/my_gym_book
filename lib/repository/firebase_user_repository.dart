import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_gym_book/common/exceptions/FirebaseCustomException.dart';
import 'package:my_gym_book/common/models/user_model.dart';


Future<void> createUser(UserModel user) async {
  await FirebaseFirestore
    .instance
    .collection("users")
    .doc(user.email)
    .set(
      {
        "fullname": user.fullname,
        "email": user.email,
        "imagePath": user.imagePath
      }
    );
}

Future<UserModel> getUser(String email) async {
  var res = await FirebaseFirestore
    .instance
    .collection("users")
    .doc(email)
    .get();
  var data = res.data();
  if (data == null) {
    throw const FirebaseCustomException("Usuário não encontrado");
  }

  UserModel user = UserModel(
    data["fullname"],
    data["email"],
    data["imagePath"]
  );
  return user;
}

Future<void> editUserdb(UserModel user) async {
  await FirebaseFirestore
    .instance
    .collection("users")
    .doc(user.email)
    .update(
      {
        "fullname": user.fullname,
        "email": user.email,
        "imagePath": user.imagePath
      }
    );
}

Future<void> deleteUser(String email) async {
  await FirebaseFirestore
      .instance
      .collection("users")
      .doc(email)
      .delete();
}

Future<List<UserModel>> getAllUsers() async {
  final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("users").get();
  return snapshot.docs
      .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
      .toList();
}

Future<List<UserModel>> getItemsExcept(List<String> excludedDocuments) async {
  List<UserModel> items = [];

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("users").get();

  for (var doc in querySnapshot.docs) {
    if (!excludedDocuments.contains(doc.id)) {
      items.add(UserModel.fromJson(doc.data() as Map<String, dynamic>));
    }
  }
  return items;
}

bool isUserInList(List<UserModel> users, String userEmail) {
  return users.any((user) => user.email == userEmail);
}

Future<List<UserCheckModel>> getMembersUsers(List<UserModel> members) async {
  List<UserCheckModel> extendedUsers = [];
  var allUsers = await getAllUsers();
  for (UserModel user in allUsers) {
    var isMember = isUserInList(members, user.email);
    UserCheckModel extendedUser = UserCheckModel(user.fullname, user.email, user.imagePath, isMember);
    extendedUsers.add(extendedUser);
  }
  return extendedUsers;
}
