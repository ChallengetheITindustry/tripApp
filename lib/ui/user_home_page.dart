import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripapp/res/const.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePage createState() => _UserHomePage();
}

class _UserHomePage extends State {
  File? imageFile;
  final picker = ImagePicker();

  //カメラ用
  Future getImageFromCamera() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  //写真ライブラリの読み込み用
  Future _getImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 2.0,
        title: Text('ホーム'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ignore: unnecessary_null_comparison
          imageFile == null
              ? Text('No image selected.')
              : Image.file(imageFile!),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: getImageFromCamera,
                child: Icon(Icons.add_a_photo),
              ),
              FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: _getImage,
                child: Icon(Icons.image),
              ),
            ],
          )
        ],
      )),
    );
  }
}
