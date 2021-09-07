// ignore: unused_import
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripapp/config/config.dart';

class UserEditInfo extends StatefulWidget {
  @override
  _UserEditInfo createState() => _UserEditInfo();
}

class _UserEditInfo extends State {
  String currentUserName = '';
  String currentUserMail = '';

  // ignore: unused_element
  Future _getFirestore() async {
    // ignore: await_only_futures
    final User user = await FirebaseAuth.instance.currentUser!;
    // ignore: unused_local_variable
    final String uid = user.uid.toString();
    // 指定コレクションのドキュメント一覧を取得
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    setState(() {
      currentUserName = snapshot['name'];
      currentUserMail = snapshot['mail'];
    });
  }

  File? _image;
  String userProfile = '';
  // firestorageに画像を保存する関数
  void selectProfileImage() async {
    final User user = await FirebaseAuth.instance.currentUser!;
    final String uid = user.uid.toString();
    // ImagePickerで写真フォルダを開き、選択した画像をpickerFileに格納
    final pickerFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    // pickerFileのpathをFile()に変換し、fileに格納
    File file = File(pickerFile!.path);
    setState(() {
      _image = file;
    });
  }

  // firestorageに画像を保存する関数
  void uploadProfileImage() async {
    final User user = await FirebaseAuth.instance.currentUser!;
    final String uid = user.uid.toString();

// firestorageをインスタンス化
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.ref("UserProfile/$uid").putFile(_image!);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: <Widget>[
            Center(
              child: CircleAvatar(
                // child: _image != null
                //     ? Image.file(_image!)
                //     : Icon(Icons.account_circle_rounded),
                radius: 60.0,
              ),
            ),
            Center(
              child: RawMaterialButton(
                onPressed: () async {
                  selectProfileImage();
                },
                child: Container(
                  width: 120.0, // CircleAvatarのradiusの2倍
                  height: 120.0,
                ),
                shape: new CircleBorder(),
                elevation: 3.0,
              ),
            ),
          ],
        ),
        ElevatedButton(
            onPressed: () async {
              uploadProfileImage();
            },
            child: Text('更新'))
      ],
    ));
  }
}
