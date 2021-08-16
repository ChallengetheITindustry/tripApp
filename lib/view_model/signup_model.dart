import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tripapp/extension/extension.dart';

class SignUpModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signUp() async {
    if (newEmail.isEmpty) {
      throw 'メールアドレスをを入力してください';
    }

    if (newPassword.isEmpty) {
      throw 'パスワードをを入力してください';
    }

    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: newEmail,
      password: newPassword,
    ))
        .user;
  }
}
