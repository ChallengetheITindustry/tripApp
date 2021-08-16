import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tripapp/extension/extension.dart';

class SignUpModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 新規会員登録
  String newUserName = ""; // 登録に関する情報を表示
  String newEmail = ""; // 入力されたメールアドレス
  String newPassword = ""; // 入力されたパスワード
  bool pswd_OK = true; // パスワードが有効な文字数を満たしているかどうか

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
