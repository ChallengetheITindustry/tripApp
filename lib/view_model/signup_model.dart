import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUpModel extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  // 新規会員登録
  String newUserName = ""; // 入力されたユーザー名
  String newEmail = ""; // 入力されたメールアドレス
  String newPassword = ""; // 入力されたパスワード
  String createdAt = "";
  // ignore: non_constant_identifier_names
  bool pswd_OK = true; // パスワードが有効な文字数を満たしているかどうか

// FirebaseUser has been changed to User
// AuthResult has been changed to UserCredential

  late UserCredential _result;
  late User _user;

  Future<String> signUp() async {
    if (newUserName.isEmpty) {
      throw 'ユーザー名を入力してください';
    }
    if (newEmail.isEmpty) {
      throw 'メールアドレスを入力してください';
    }

    if (newPassword.isEmpty) {
      throw 'パスワードを入力してください';
    }

    if (newUserName.length > 8) {
      throw 'ユーザー名は8文字以下で入力してください';
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
    // ignore: await_only_futures
    final User user = await FirebaseAuth.instance.currentUser!;
    // ignore: unused_local_variable
    final String uid = user.uid.toString();

    DateTime now = DateTime.now();
    DateFormat outputFormat = DateFormat('yyyy-MM-dd(E) hh:mm');
    String date = outputFormat.format(now);
    createdAt = date.toString();

    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': newUserName,
      'mail': newEmail,
      'password': newPassword,
      'createdAt': createdAt,
    });
  }
}
