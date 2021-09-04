import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// ログイン
  String email = ""; // メールアドレス
  String password = ""; // パスワード

  bool obscureText = false;

  void changeObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }

  Future signIn() async {
    if (email.isEmpty) {
      throw 'メールアドレスを入力してください';
    }

    if (password.isEmpty) {
      throw 'パスワードを入力してください';
    }

    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result;
  }
}
