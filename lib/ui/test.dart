import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tripapp/res/const.dart';

class TestPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
  Image? _img;
  Text? _text;

  Future<void> _download() async {
    // ログイン処理
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "reeksge@gmail.com", password: "123456");

    // ファイルのダウンロード
    // テキスト
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference textRef = storage.ref().child("DL").child("hello.txt");
    //Reference ref = storage.ref("DL/hello.txt"); // refで一度に書いてもOK

    var data = await textRef.getData();

    // 画像
    Reference imageRef = storage.ref().child("DL").child("icon.png");
    String imageUrl = await imageRef.getDownloadURL();

    // 画面に反映
    setState(() {
      _img = Image.network(imageUrl);
      _text = Text(ascii.decode(data!));
    });

    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File("${appDocDir.path}/download-logo.png");
    try {
      await imageRef.writeToFile(downloadToFile);
    } catch (e) {
      print(e);
    }
  }

  void _upload() async {
    // imagePickerで画像を選択する
    // upload
    PickedFile pickerFile = (await ImagePicker()
        .pickImage(source: ImageSource.gallery)) as PickedFile;
    File file = File(pickerFile.path);

    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.ref("UL/upload-pic.png").putFile(file);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text('テスト'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ignore: unnecessary_null_comparison
              if (_text != null) Center(child: _text),
              // ignore: unnecessary_null_comparison
              if (_img != null) Center(child: _img),
            ],
          ),
        ),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: _download,
            child: Icon(Icons.download_outlined),
          ),
          FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: _upload,
            child: Icon(Icons.upload_outlined),
          ),
        ]));
  }
}
