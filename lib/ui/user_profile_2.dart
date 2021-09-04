// リファクタリングする
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';

class UserProfilePage2 extends StatefulWidget {
  @override
  UserProfilePage12 createState() => UserProfilePage12();
}

class UserProfilePage12 extends State {
  String currentUserName = '';
  String currentUserMail = '';
  String uid = '';
  // nullable
  // ignore: unused_field
  Image? _img;
  String userProfile = '';
  // firestorageに画像を保存する関数
  void _upload() async {
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

  Future _download() async {
    FirebaseStorage storage = FirebaseStorage.instance;

    // 画像
    Reference imageRef = storage.ref().child("UserProfile").child("$uid");
    String imageUrl = await imageRef.getDownloadURL();

    // 画面に反映
    setState(() {
      userProfile = imageUrl.toString();
      // _img = Image.network(imageUrl);
    });
  }

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
      this.uid = uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _getFirestore();
    return Scaffold(
        body: Stack(
      children: [
        UserBackGround(),
        Column(
          children: [
            Container(
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.brown.shade800,
                          // ignore: unnecessary_null_comparison
                          backgroundImage: NetworkImage(''),
                        ),
                        // // StackでRawMaterialButtonを重ねることによりCircleAvatarをタップできるような表現に変更
                        // RawMaterialButton(
                        //   onPressed: () async {},
                        //   child: Container(
                        //     width: 200.0, // CircleAvatarのradiusの2倍
                        //     height: 200.0,
                        //   ),
                        //   shape: CircleBorder(),
                        //   elevation: 2.0,
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                                child: Text(
                              // ログインユーザーの名前を表示
                              currentUserName,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            Container(
                              child: Text(
                                // ログインユーザーのメールアドレスを表示
                                currentUserMail,
                                style: TextStyle(
                                  color: formBorderColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    ));
  }
}

class UserBackGround extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(100),
                ),
              ),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(100),
            ),
          ),
        )
      ],
    );
  }
}
