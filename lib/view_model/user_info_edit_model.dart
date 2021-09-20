import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoEditModel extends ChangeNotifier {
  String currentUserName = '';
  String currentUserMail = '';
  String newUserName = '';
  String newUserMail = '';
  String uid = '';

  // ignore: unused_element
  Future getFirestore() async {
    // ignore: await_only_futures
    final User user = await FirebaseAuth.instance.currentUser!;
    // ignore: unused_local_variable
    uid = user.uid.toString();
    // 指定コレクションのドキュメント一覧を取得
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    currentUserName = snapshot['name'];
    currentUserMail = snapshot['mail'];
    notifyListeners();
  }

  Future fireStoreUpdate() async {
    if (newUserName.isEmpty) {
      throw 'ユーザー名を記入してください';
    }

    if (newUserMail.isEmpty) {
      throw 'メールアドレスを記入してください';
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'name': newUserName, 'mail': newUserMail});

    await FirebaseAuth.instance.currentUser!.updateEmail(newUserMail);
    notifyListeners();
  }

  // await FirebaseAuth.instance.currentUser.updateProfile(displayName: "JohnDoe");
}
