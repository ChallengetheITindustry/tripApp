import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<String> signUp() async {
    if (newUserName.isEmpty) {
      throw 'ユーザー名の入力忘れてない？😥';
    }
    if (newEmail.isEmpty) {
      throw 'メールアドレスの入力忘れてない？😥';
    }

    if (newPassword.isEmpty) {
      throw 'パスワードの入力忘れてない？😥';
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

    return _result.user!.uid;
  }

  // ユーザー情報をFirestoreに保存する
  // ignore: non_constant_identifier_names
  Future UserInfoAdd() async {
    await FirebaseFirestore.instance
        .collection('users')
        .add({'name': newUserName, 'mail': newEmail, 'password': newPassword});
  }

  Future getCurrentUser() async {
    return await _auth.currentUser!;
  }
}
