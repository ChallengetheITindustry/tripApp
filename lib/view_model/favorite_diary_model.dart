import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteDiaryModel extends ChangeNotifier {
  String? uid;

  // ignore: unused_element
  Future addFavorite() async {
    // ignore: await_only_futures
    final User user = await FirebaseAuth.instance.currentUser!;
    // ignore: unused_local_variable
    final String uid = user.uid.toString();

    FirebaseFirestore.instance.collection('timeline').doc();

    // 指定コレクションのドキュメント一覧を取得
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorite')
        .add({});

    this.uid = uid.toString();
    notifyListeners();
  }
}
