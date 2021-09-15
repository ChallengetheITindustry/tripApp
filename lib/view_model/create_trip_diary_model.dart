import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateTripDiaryModel extends ChangeNotifier {
  final controller = PageController(initialPage: 0);
  String concept = '';
  String contents = '';
  String tripDocumentId = '';
  String ID = '';

  DateTime dateStart = new DateTime.now();
  DateTime dateEnd = new DateTime.now();

  Future<Null> selectDateStart(BuildContext context) async {
    final DateTime? pickedStart = await showDatePicker(
      context: context,
      helpText: '旅の始まり',
      cancelText: 'キャンセル',
      confirmText: '次へ',
      initialDate: dateStart,
      firstDate: DateTime(2016),
      lastDate: DateTime.now().add(new Duration(days: 360 * 5)),
    );

    if (pickedStart != null) {
      dateStart = pickedStart;
    }

    _selectDateEnd(context);
    notifyListeners();
  }

  Future<Null> _selectDateEnd(BuildContext context) async {
    final DateTime? pickedEnd = await showDatePicker(
      context: context,
      helpText: '旅の終わりを指定',
      cancelText: 'キャンセル',
      confirmText: '決定',
      initialDate: dateEnd,
      firstDate: DateTime(2016),
      lastDate: DateTime.now().add(new Duration(days: 360 * 5)),
    );

    if (pickedEnd != null) {
      dateEnd = pickedEnd;
    }
    notifyListeners();
  }

  Future setTrip() async {
    final User user = await FirebaseAuth.instance.currentUser!;
    final String uid = user.uid.toString();

    // 自動で生成するIDを設定する
    var rand = new Random();
    var next = rand.nextDouble() * 100000000;

    while (next < 10000000) {
      next *= 10;
    }

    var numbers = next.toInt();

    if (concept.isEmpty) {
      throw 'どんな旅だったかを記入してください！';
    }

    if (contents.isEmpty) {
      throw '旅の内容を記入してください';
    }

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('trip')
        .add({
      'concept': concept,
      'data': '$dateStart ~ $dateEnd',
      // 'imageURL': 'ng;adoshg;osdg;o',
      'contents': contents,
      'ID': numbers,
    });

    await FirebaseFirestore.instance.collection('timeline').add({
      'userID': uid,
      'concept': concept,
      'data': '$dateStart ~ $dateEnd',
      // 'imageURL': 'ng;adoshg;osdg;o',
      'contents': contents,
      'ID': numbers,
    });
    final tripDocument = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('trip')
        .doc()
        .id;

    tripDocumentId = tripDocumentId.toString();
    notifyListeners();
  }

//   void tripImageUpload() async {
// // firestorageをインスタンス化
//     FirebaseStorage storage = FirebaseStorage.instance;
//     try {
//       await storage.ref("$uid/$tripDocumentId/$concept").putFile(_image!);
//     } catch (e) {
//       print(e);
//     }
//   }

//   void addTripImage() async {
//     // ImagePickerで写真フォルダを開き、選択した画像をpickerFileに格納
//     final pickerFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     File file = File(pickerFile!.path);

//     _image = file;
//   }
}
