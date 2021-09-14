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
  // ignore: unused_field

  String userProfile = '';

  // firestorageに画像を保存する関数
  void upload() async {
    // ImagePickerで写真フォルダを開き、選択した画像をpickerFileに格納
    final pickerFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    // pickerFileのpathをFile()に変換し、fileに格納
    File file = File(pickerFile!.path);
// firestorageをインスタンス化
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.ref("UserProfile/$uid").putFile(file);
    } catch (e) {
      print(e);
    }
  }

  Future download() async {
    FirebaseStorage storage = FirebaseStorage.instance;

    // 画像
    Reference imageRef = storage.ref().child("UserProfile").child("$uid");
    if (imageRef != null) {
      String imageUrl = await imageRef.getDownloadURL();

      userProfile = imageUrl.toString();
    } else {
      return Icon(Icons.account_circle_outlined);
    }
    notifyListeners();
  }

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

  String documentNum = '';

  Future documentLength() async {
    final QuerySnapshot documentLength = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('trip')
        .get();
    final documents = documentLength.docs.length;

    documentNum = documents.toString();
    notifyListeners();
  }
}
