import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            actions: <Widget>[
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
                                      onTap: () {
                                        Navigator.pop(context);
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
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.brown.shade800,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1561731172-9d906d7b13bf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1268&q=80'),
                  ),
                  // StackでRawMaterialButtonを重ねることによりCircleAvatarをタップできるような表現に変更
                  RawMaterialButton(
                    onPressed: () {
                      showAboutDialog(context: context);
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
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                  child: Text(
                                // ログインユーザーの名前を表示
                                'Taisei',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ],
                          ),
                          Container(
                            child: Text(
                              // ログインユーザーのメールアドレスを表示
                              'reeksge@gmail.com',
                              style: TextStyle(color: formBorderColor),
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Container(
                            child: IconButton(
                          onPressed: () {
                            launch('https://twitter.com/home');
                            // 10秒後にURLで開いたページを閉じる処理（何かで使えるかも？？）
                            Timer(
                              const Duration(seconds: 10),
                              () {
                                closeWebView();
                              },
                            );
                          },
                          icon: Icon(
                            EvaIcons.twitter,
                            size: 50,
                            color: twitterColor,
                          ),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Container(
                            child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            EvaIcons.heart,
                            size: 50,
                            color: heartColor,
                          ),
                        )),
                      ),
                    ],
                  ),
                  Container(
                    child: Text(
                        // ログインユーザーのプロフィールコメントを表示
                        '初めまして！現在日本一周しています！北海道→青森県→岩手県→福島県　YouTubeもやっています→https://www.youtube.com/watch?v=iSsct7423J4&t=28s'),
                  ),
                  Container(
                    child: Text(
                        // ログインユーザーのプロフィールコメントを表示
                        '初めまして！現在日本一周しています！北海道→青森県→岩手県→福島県　YouTubeもやっています→https://www.youtube.com/watch?v=iSsct7423J4&t=28s'),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                      offset: Offset(10, 10))
                ],
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Container(
                        child: Image.network(
                            'https://images.unsplash.com/photo-1561731172-e6a4d2a9a409?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1268&q=80'),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Container(
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
