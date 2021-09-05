// リファクタリングする
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/ui/user_edit_info.dart';
import 'package:tripapp/view_model/user_profile_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';

class UserProfilePage2 extends StatefulWidget {
  @override
  UserProfilePage12 createState() => UserProfilePage12();
}

class UserProfilePage12 extends State {
  String currentUserName = '';
  String currentUserMail = '';
  String uid = '';
  // ignore: unused_element
  Future getFirestore() async {
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
    getFirestore();
    SizeConfig().init(context);
    return ChangeNotifierProvider<UserProfileModel>(
      create: (context) => UserProfileModel(),
      child: Scaffold(
          body: Consumer<UserProfileModel>(builder: (context, model, child) {
        return Stack(
          children: [
            Column(
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.blockSizeVertical * 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    color: timelineBackground,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(150),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15.0,
                          spreadRadius: 1.0,
                          offset: Offset(10, 10))
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: SizeConfig.screenHeight * 0.4,
              child: Stack(
                children: [
                  // Container(
                  //     width: SizeConfig.screenWidth * 0.5,
                  //     decoration: BoxDecoration(
                  //       color: Colors.blue,
                  //       shape: BoxShape.circle,
                  //     )),
                  Column(
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
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            spreadRadius: 0,
                                            offset: Offset(15, 15))
                                      ],
                                    ),
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
                                  height: SizeConfig.blockSizeVertical * 3,
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
                  icon: Icon(
                    Icons.clear_all,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ここにPageViewを表示させます'),
                ],
              ),
            )
          ],
        );
      })),
    );
  }
}

// Container(
//   width: SizeConfig.screenWidth * 0.8,
//   child: Column(
//     children: [
//       Container(
//         width: SizeConfig.screenWidth * 0.8,
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 15.0,
//                 spreadRadius: 1.0,
//                 offset: Offset(10, 10))
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20.0),
//           child: Image.network(
//               'https://images.unsplash.com/photo-1472740378865-80aab8e73251?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80'),
//         ),
//       ),
//     ],
//   ),
// )