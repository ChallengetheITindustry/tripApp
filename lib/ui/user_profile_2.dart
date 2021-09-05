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
import 'package:tripapp/ui/user_edit_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import 'map.dart';

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
        Container(
          height: SizeConfig.screenHeight * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  'プロフィール',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      child: CircleAvatar(
                        radius: SizeConfig.blockSizeHorizontal * 15,
                        backgroundColor: Colors.brown.shade800,
                        // ignore: unnecessary_null_comparison
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1536825211030-094de935f680?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              Container(
                width: SizeConfig.screenWidth * 0.6,
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
                            color: Colors.white,
                          ),
                        )),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        Container(
                          child: Text(
                            // ログインユーザーのメールアドレスを表示
                            currentUserMail,
                            style: TextStyle(
                              color: Colors.white,
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
        Positioned(
          top: SizeConfig.blockSizeVertical * 8,
          left: SizeConfig.blockSizeHorizontal * 80,
          child: Container(
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                    //モーダルの背景の色、透過
                    backgroundColor: Colors.transparent,
                    //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        margin: EdgeInsets.only(top: 64),
                        decoration: BoxDecoration(
                          //モーダル自体の色
                          color: Colors.white,
                          //角丸にする
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: ListView(
                          //scrollDirection: Axis.horizontal, // 横
                          padding: EdgeInsets.all(36.0),
                          shrinkWrap: true,
                          children: [
                            Container(
                              height: 80,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(5, 5))
                                ],
                              ),
                              child: Card(
                                child: ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text(
                                    "ユーザー情報編集",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  contentPadding: EdgeInsets.all(10.0),
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserEditInfo()),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Container(
                              height: 80,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(5, 5))
                                ],
                              ),
                              child: Card(
                                child: ListTile(
                                  leading: Icon(Icons.mail),
                                  title: Text(
                                    "お問い合わせ",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text('外部サイト'),
                                  contentPadding: EdgeInsets.all(10.0),
                                  onTap: () {
                                    Navigator.pop(context);
                                    launch(
                                        'https://forms.gle/bJndj6BKZbKiFSgi9');
                                    // https://forms.gle/bJndj6BKZbKiFSgi9
                                  },
                                ),
                              ),
                            ),
                            Container(
                              height: 80,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(5, 5))
                                ],
                              ),
                              child: Card(
                                child: ListTile(
                                  leading: Icon(Icons.book),
                                  title: Text(
                                    "利用規約",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  contentPadding: EdgeInsets.all(10.0),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                            Container(
                              height: 80,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(5, 5))
                                ],
                              ),
                              child: Card(
                                child: ListTile(
                                  leading: Icon(Icons.rule),
                                  title: Text(
                                    "プライバシーポリシー",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  contentPadding: EdgeInsets.all(10.0),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                            Container(
                              height: 80,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(5, 5))
                                ],
                              ),
                              child: Card(
                                child: ListTile(
                                  leading: Icon(Icons.exit_to_app),
                                  title: Text(
                                    "ログアウト",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  contentPadding: EdgeInsets.all(10.0),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    // ログアウト処理
                                    // 内部で保持しているログイン情報等が初期化される
                                    // （現時点ではログアウト時はこの処理を呼び出せばOKと、思うぐらいで大丈夫です）
                                    await FirebaseAuth.instance.signOut();
                                    // ログイン画面に遷移＋チャット画面を破棄
                                    await Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                        return MyApp();
                                      }),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              icon: Icon(
                Icons.clear_all,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: SizeConfig.screenWidth * 0.5,
              color: timelineBackground,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: SizeConfig.screenWidth * 0.5,
              height: SizeConfig.screenHeight * 0.35,
              color: Colors.white,
            ),
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.blockSizeVertical * 50,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.transparent),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(100),
                ),
              ),
            ),
          ],
        ),
        // 左上のContainer
        Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.blockSizeVertical * 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            color: timelineBackground,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(100),
            ),
          ),
        )
      ],
    );
  }
}
