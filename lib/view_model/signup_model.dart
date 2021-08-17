import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  // 新規会員登録
  String newUserName = ""; // 登録に関する情報を表示
  String newEmail = ""; // 入力されたメールアドレス
  String newPassword = ""; // 入力されたパスワード
  // ignore: non_constant_identifier_names
  bool pswd_OK = true; // パスワードが有効な文字数を満たしているかどうか

// FirebaseUser has been changed to User
// AuthResult has been changed to UserCredential

  late UserCredential _result;
  late User _user;

  Future signUp() async {
    if (newEmail.isEmpty) {
      throw 'メールアドレスをを入力してください';
    }

    if (newPassword.isEmpty) {
      throw 'パスワードをを入力してください';
    }

    try {
      // バリデーション後のメールアドレスとパスワードでアカウント登録
      _result = await _auth.createUserWithEmailAndPassword(
        email: newEmail,
        password: newPassword,
      );

      // 登録成功
      _user = _result.user!; // 登録したユーザー情報
      _user.sendEmailVerification(); // Email確認のメールを送信

    } catch (error) {
      throw error;
    }
  }
}
