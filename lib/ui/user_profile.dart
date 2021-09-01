import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/main.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/ui/privacy.dart';
import 'package:tripapp/ui/rule.dart';
import 'package:tripapp/ui/test.dart';
import 'package:tripapp/ui/user_edit_info.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfilePage extends StatefulWidget {
  @override
  UserProfilePage1 createState() => UserProfilePage1();
}

class UserProfilePage1 extends State {
  String currentUserName = '';
  String currentUserMail = '';
  String uid = '';
  // nullable
  Image? _img;
  String userProfile = '';

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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _getFirestore();
    _download();
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.white, elevation: 0.0, actions: <
            Widget>[
          Container(
              child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestPage()),
              );
              // showDialog(
              //     context: context,
              //     builder: (_) => CupertinoAlertDialog(
              //           title: Text("ここに通知欄を表示します。"),
              //           actions: [
              //             CupertinoDialogAction(
              //                 child: Text('実装したらgithubに挙げる'),
              //                 isDestructiveAction: true,
              //                 onPressed: () {
              //                   Navigator.of(context).pop();
              //                 }),
              //           ],
              //         ));
            },
            icon:
                Icon(Icons.add_alert_outlined, color: primaryColor, size: 35.0),
          )),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RulePage()),
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
                                  leading: Icon(Icons.rule),
                                  title: Text(
                                    "プライバシーポリシー",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  contentPadding: EdgeInsets.all(10.0),
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PribacyPage()),
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
              icon: Icon(Icons.clear_all, color: primaryColor, size: 40.0),
            ),
          ),
        ]),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.brown.shade800,
                    // ignore: unnecessary_null_comparison
                    backgroundImage: NetworkImage(userProfile),
                  ),
                  // StackでRawMaterialButtonを重ねることによりCircleAvatarをタップできるような表現に変更
                  RawMaterialButton(
                    onPressed: () async {
                      _upload();
                      await _download();
                    },
                    child: Container(
                      width: 200.0, // CircleAvatarのradiusの2倍
                      height: 200.0,
                    ),
                    shape: CircleBorder(),
                    elevation: 2.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: SizeConfig.blockSizeVertical * 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0)),
                color: primaryColor,
              ),
              // ユーザーが投稿した日記をここに表示させる
              child: ListView(
                //scrollDirection: Axis.horizontal, // 横
                padding: EdgeInsets.all(36.0),
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10.0,
                                spreadRadius: 1.0,
                                offset: Offset(10, 10))
                          ],
                          color: primaryColor,
                        ),
                        child: Image.network(
                            'https://images.unsplash.com/photo-1563284223-333497472e88?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1510&q=80'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10.0,
                                spreadRadius: 1.0,
                                offset: Offset(10, 10))
                          ],
                          color: primaryColor,
                        ),
                        child: Image.network(
                            'https://images.unsplash.com/photo-1561731172-e6a4d2a9a409?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1268&q=80'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10.0,
                                spreadRadius: 1.0,
                                offset: Offset(10, 10))
                          ],
                          color: primaryColor,
                        ),
                        child: Image.network(
                            'https://images.unsplash.com/photo-1597395529362-361ba4b8ec24?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1267&q=80'),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
