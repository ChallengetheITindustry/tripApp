import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/main.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/ui/privacy.dart';
import 'package:tripapp/ui/rule.dart';
import 'package:tripapp/ui/test.dart';
import 'package:tripapp/ui/user_info_edit.dart';
import 'package:tripapp/view_model/user_profile_model.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfilePage extends StatefulWidget {
  @override
  UserProfilePage1 createState() => UserProfilePage1();
}

class UserProfilePage1 extends State {
  @override
  void initState() {
    super.initState();
    Future(() {
      final UserProfileModel data = Provider.of<UserProfileModel>(context);
      data.getFirestore();
      // data.download();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider<UserProfileModel>(
      create: (_) => UserProfileModel(),
      child: Consumer<UserProfileModel>(builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  color: primaryColor,
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        return AlertDialog(
                          title: Text("メモ帳を追加"),
                          content: TextFormField(
                            onChanged: model.handleText,
                          ),
                          actions: [
                            ElevatedButton(
                              child: Text("戻る"),
                              onPressed: () => Navigator.pop(context),
                            ),
                            ElevatedButton(
                              child: Text("追加"),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection(
                                        'timeline') // コレクションID/ ドキュメントID
                                    .add({'title': model.title}); //
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
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
                                                  builder: (context) =>
                                                      RulePage()),
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
                                            await FirebaseAuth.instance
                                                .signOut();
                                            // ログイン画面に遷移＋チャット画面を破棄
                                            await Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) {
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
                      icon: Icon(Icons.clear_all,
                          color: primaryColor, size: 40.0),
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
                        backgroundImage: NetworkImage(''),
                      ),
                      // StackでRawMaterialButtonを重ねることによりCircleAvatarをタップできるような表現に変更
                      Container(
                        width: 200.0, // CircleAvatarのradiusの2倍
                        height: 200.0,
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
                            model.currentUserName,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          Container(
                            child: Text(
                              // ログインユーザーのメールアドレスを表示
                              model.currentUserMail,
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
                                                      content:
                                                          Text(doc['title']),
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
                                                            Navigator.pop(
                                                                context);
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
      }),
    );
  }
}
