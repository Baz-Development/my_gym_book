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
        "email": user.email
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
    data["email"]
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
        "email": user.email
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