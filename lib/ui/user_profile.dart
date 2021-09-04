// リファクタリングする
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/main.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/ui/privacy.dart';
import 'package:tripapp/ui/rule.dart';
import 'package:tripapp/ui/test.dart';
import 'package:tripapp/ui/user_edit_info.dart';
import 'package:tripapp/ui/user_profile_2.dart';
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
  // ignore: unused_field
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

  String _title = '';

  void _handleText(String e) {
    setState(() {
      _title = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _getFirestore();
    _download();
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              color: primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfilePage2()),
                );
                // showDialog(
                //   context: context,
                //   barrierDismissible: false,
                //   builder: (_) {
                //     return AlertDialog(
                //       title: Text("メモ帳を追加"),
                //       content: TextFormField(
                //         onChanged: _handleText,
                //       ),
                //       actions: [
                //         ElevatedButton(
                //           child: Text("戻る"),
                //           onPressed: () => Navigator.pop(context),
                //         ),
                //         ElevatedButton(
                //           child: Text("追加"),
                //           onPressed: () async {
                //             await FirebaseFirestore.instance
                //                 .collection('timeline') // コレクションID/ ドキュメントID
                //                 .add({'title': _title}); //
                //             Navigator.pop(context);
                //           },
                //         ),
                //       ],
                //     );
                //   },
                // );
              },
              icon: Icon(Icons.add),
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            actions: <Widget>[
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
                icon: Icon(Icons.add_alert_outlined,
                    color: primaryColor, size: 35.0),
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
                                              builder: (context) =>
                                                  UserEditInfo()),
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
                                              builder: (context) =>
                                                  PribacyPage()),
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
                                        await Navigator.of(context)
                                            .pushReplacement(
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
              child: StreamBuilder<QuerySnapshot>(
                  // ★2 streamに`Stream<QuerySnapshot>`を渡す。
                  stream: FirebaseFirestore.instance
                      .collection('timeline')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // ★3 `List<DocumentSnapshot>`をsnapshotから取り出す。
                      final List<DocumentSnapshot> documents =
                          snapshot.data!.docs;
                      return ListView(
                          children: documents
                              .map((doc) => Card(
                                    child: ListTile(
                                      title: InkWell(
                                          onLongPress: () {
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (_) {
                                                return AlertDialog(
                                                  title: Text(
                                                      '以下のメモを削除してもよろしいですか？'),
                                                  content: Text(doc['title']),
                                                  actions: [
                                                    ElevatedButton(
                                                      child: Text("いいえ"),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    ),
                                                    ElevatedButton(
                                                      child: Text("はい"),
                                                      onPressed: () async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'timeline')
                                                            .doc(doc.id)
                                                            .delete();
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Text(doc['title'])),
                                    ),
                                  ))
                              .toList());
                    } else if (snapshot.hasError) {
                      return Text('エラーだよ');
                    } else {
                      throw Text('こんにちは');
                    }
                  }),
            ),
          ],
        ));
  }
}
