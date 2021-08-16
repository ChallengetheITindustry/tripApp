import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tripapp/extension/extension.dart';

class SignInModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// ログイン
  String email = ""; // メールアドレス
  String password = ""; // パスワード

  Future signIn() async {
    if (email.isEmpty) {
      throw 'メールアドレスをを入力してください';
    }

    if (password.isEmpty) {
      throw 'パスワードをを入力してください';
    }

    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print("ログイン完了🚀");
    return result;
  }
}
