import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// ログイン
  String email = ""; // メールアドレス
  String password = ""; // パスワード

  Future signIn() async {
    if (email.isEmpty) {
      throw 'メールアドレスの入力忘れてない？😥';
    }

    if (password.isEmpty) {
      throw 'パスワードの入力忘れてない？😥';
    }

    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result;
  }
}
