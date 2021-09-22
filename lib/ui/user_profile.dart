import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/view_model/user_profile_model.dart';

class UserProfilePage extends StatelessWidget {
  List docList = [];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProfileModel>(
      create: (_) => UserProfileModel()..getFirestore(),
      child: Consumer<UserProfileModel>(builder: (context, model, child) {
        model.download();
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  spreadRadius: 5.0,
                  offset: Offset(10, 10))
            ],
          ),
          child: IconButton(
              // ユーザー情報画面
              onPressed: () async {
                await model.documentLength();
                showModalBottomSheet(
                    //モーダルの背景の色、透過
                    backgroundColor: Colors.transparent,
                    //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.15,
                          ),
                          Stack(
                            children: <Widget>[
                              Center(
                                  // ignore: unnecessary_null_comparison
                                  child: model.userProfile != null
                                      ? CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage:
                                              NetworkImage(model.userProfile),
                                          radius: 60.0,
                                        )
                                      : Icon(Icons.account_circle_outlined)),
                              Positioned(
                                bottom: 0,
                                right: SizeConfig.screenWidth * 0.3,
                                child: FloatingActionButton(
                                    backgroundColor: timelineBackground,
                                    child: Icon(Icons.add),
                                    onPressed: () {
                                      model.upload();
                                      model.download();
                                    }),
                              )
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.03,
                          ),
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
                                model.currentUserName,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.02,
                          ),
                          Container(
                            child: Text(
                              // ログインユーザーのメールアドレスを表示
                              model.currentUserMail,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.02,
                          ),
                          Container(
                              child: Text(
                            '投稿数：${model.documentNum}回',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.02,
                          ),
                          Container(
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(model.uid)
                                  .collection('trip')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                return Expanded(
                                  child: ListView(
                                      children: snapshot.data!.docs
                                          .map((DocumentSnapshot document) {
                                    return InkWell(
                                      onLongPress: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog(
                                              title: Text(
                                                '【${document['concept']}】',
                                              ),
                                              content: Text(
                                                document['contents'],
                                              ),
                                              actions: <Widget>[
                                                // ボタン領域
                                                ElevatedButton(
                                                  child: Text("Cancel"),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                                ElevatedButton(
                                                    child: Text("OK"),
                                                    onPressed: () async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('users')
                                                          .doc(model.uid)
                                                          .collection('trip')
                                                          .doc(document.id)
                                                          .delete();

                                                      Navigator.pop(context);
                                                    }),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Card(
                                        color: Colors.transparent,
                                        child: ListTile(
                                          title: Text(
                                            '【${document['concept']}】',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          subtitle: Text(
                                            document['contents'],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList()),
                                );
                              },
                            ),
                          )
                        ],
                      );
                    });
              },
              icon: Icon(
                Icons.account_circle,
                size: 30,
                color: timelineBackground,
              )),
        );
      }),
    );
  }
}
