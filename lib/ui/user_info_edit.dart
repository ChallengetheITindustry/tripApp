// ignore: unused_import
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/view_model/user_info_edit_model.dart';

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

  @override
  Widget build(BuildContext context) {
    // _getFirestore();
    // 幅
    double width = MediaQuery.of(context).size.width;
    // 高さ
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider<UserInfoEditModel>(
      create: (_) => UserInfoEditModel(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 2.0,
            title: Text('ユーザー情報編集'),
            leading: IconButton(
              icon: Icon(Icons.backspace),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Consumer<UserInfoEditModel>(builder: (context, model, child) {
            return Column(
              children: [
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
                      RawMaterialButton(
                        onPressed: () async {
                          model.upload();
                          await model.download();
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
                Align(
                  //Containerを真ん中に配置する場合、Alignウィジットで囲い、aligment: Aligment.centerと記述する
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                            offset: Offset(10, 10))
                      ],
                    ),
                    width: width * 0.8,
                    height: height * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: width * 0.6,
                          height: height * 0.1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("ユーザー名"),
                              TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: formBorderColor,
                                    ),
                                  ),
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    currentUserName = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: width * 0.6,
                          height: height * 0.1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("メールアドレス"),
                              TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: formBorderColor,
                                    ),
                                  ),
                                ),
                                onChanged: (String value) {
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                            width: width * 0.6,
                            height: 50,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10.0,
                                    spreadRadius: 1.0,
                                    offset: Offset(10, 10))
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              child: Text(
                                '更新',
                                style: TextStyle(fontSize: 20),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  )),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            );
          })),
    );
  }
}
