import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoEditModel extends ChangeNotifier {
  // ignore: await_only_futures
  final User user = FirebaseAuth.instance.currentUser!;
  // ignore: unused_local_variable
  final String uid = user.uid.toString();
  // ignore: unused_field
  Image? _img;
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
    String imageUrl = await imageRef.getDownloadURL();

    // 画面に反映

    userProfile = imageUrl.toString();
    // _img = Image.network(imageUrl);
    notifyListeners();
  }
}
