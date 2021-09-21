// ignore: avoid_web_libraries_in_flutter

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  AudioCache player = AudioCache();
  bool sounds = false;
  String? favoriteConcept;
  String? favoriteContents;
  String? favoriteID;

  late AudioPlayer changeTakibi;

  Future startSound() async {
    AudioPlayer audioSourceTakibi = await player.loop('fire.mp3');

    sounds = !sounds;
    changeTakibi = audioSourceTakibi;
    notifyListeners();
  }

  Future stopSound() async {
    await changeTakibi.stop();

    sounds = !sounds;
    notifyListeners();
  }

  Future addFavorite() async {
    final User user = await FirebaseAuth.instance.currentUser!;
    final String uid = user.uid.toString();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorite')
        .add({
      'concept': favoriteConcept,
      'contents': favoriteContents,
      'id': favoriteID,
    });
  }

  Future deleteFavorite() async {
    final User user = await FirebaseAuth.instance.currentUser!;
    final String uid = user.uid.toString();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorite')
        .add({
      'concept': favoriteConcept,
      'contents': favoriteContents,
    });
  }

// ボタンを押したときに定数にお気に入りしたデータを格納
  Future add() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('timeline')
        .orderBy("createTime", descending: true)
        .get();
    final data = snapshot.docs.first;
    favoriteConcept = data['concept'];
    favoriteContents = data['contents'];
    favoriteID = data['ID'].toString();
    notifyListeners();
  }
}
