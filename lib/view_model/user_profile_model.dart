import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileModel extends ChangeNotifier {
  String currentUserName = '';
  String currentUserMail = '';
  String uid = '';
  // nullable

  // ignore: unused_element
  Future getFirestore() async {
    // ignore: await_only_futures
    final User user = await FirebaseAuth.instance.currentUser!;
    // ignore: unused_local_variable
    final String uid = user.uid.toString();
    // 指定コレクションのドキュメント一覧を取得
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    currentUserName = snapshot['name'];
    currentUserMail = snapshot['mail'];
    this.uid = uid;
    notifyListeners();
  }

  String title = '';

  void handleText(String e) {
    title = e;
    notifyListeners();
  }
}
