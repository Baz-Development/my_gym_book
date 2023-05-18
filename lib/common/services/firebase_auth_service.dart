import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_gym_book/common/exceptions/FirebaseCustomException.dart';


Future<String?> registerUser(String email, String password) async {
  try {
    var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user.user?.uid;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      debugPrint('The password provided is too weak.');
      throw const FirebaseCustomException('Senha muito fraca.');
    } else if (e.code == 'email-already-in-use') {
      debugPrint('The account already exists for that email.');
      throw const FirebaseCustomException('Esse email já esta em uso.');
    } else {
      debugPrint("An error occured. Please try again later.");
      throw const FirebaseCustomException('Ops!! aconteceu um erro, tente mais tarde novamente ou entre em contato com a central de atendimento ao cliente.');
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

Future<String?> signInFirebaseEmail(String email, String password) async {
  try {
    var user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    return email;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      debugPrint('Email não cadastrado.');
      throw const FirebaseCustomException('Email não cadastrado.');
    } else if (e.code == 'wrong-password') {
      debugPrint('Email ou senha incorretos.');
      throw const FirebaseCustomException('Email ou senha incorretos.');
    } else if (e.code == 'invalid-email') {
      debugPrint('Email ou senha incorretos.');
      throw const FirebaseCustomException('Email ou senha incorretos.');
    } else {
      debugPrint("An error occured. Please try again later.");
      throw const FirebaseCustomException('Ops!! aconteceu um erro, tente mais tarde novamente ou entre em contato com a central de atendimento ao cliente.');
    }
  }
}

Future<void> forgetPasswordFirebaseEmail(String email) async {
  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
}

Future<void> signout() async {
  await FirebaseAuth.instance.signOut();
}