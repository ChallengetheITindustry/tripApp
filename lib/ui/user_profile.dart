import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/view_model/user_profile_model.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProfileModel>(
      create: (_) => UserProfileModel()
        ..getFirestore()
        ..download(),
      child: Consumer<UserProfileModel>(builder: (context, model, child) {
        return IconButton(
            // ユーザー情報画面
            onPressed: () {
              model.documentLength();

              print(model.documentNum);
              // model.download();
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
                            model.userProfile != null
                                ? Container(
                                    height: SizeConfig.screenHeight * 0.2,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(200.0),
                                        child:
                                            Image.network(model.userProfile)),
                                  )
                                : Container(
                                    height: SizeConfig.screenHeight * 0.2,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(200.0),
                                        child: Image.asset(
                                            'assets/images/twitter-profile-image.png')),
                                  ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: FloatingActionButton(
                                  backgroundColor: timelineBackground,
                                  child: Icon(Icons.add),
                                  onPressed: () {
                                    model.upload();
                                  }),
                            )
                            // Container(
                            //   decoration: BoxDecoration(
                            //     shape: BoxShape.circle,
                            //   ),
                            //   child: ClipRRect(
                            //     borderRadius: BorderRadius.circular(20),
                            //     child: Image.network(
                            //       model.userProfile,
                            //     ),
                            //   ),
                            // )
                            // Center(
                            //     // ignore: unnecessary_null_comparison
                            //     child: model.userProfile != null
                            //         ? CircleAvatar(
                            //             backgroundImage:
                            //                 NetworkImage(model.userProfile),
                            //             radius: 60.0,
                            //           )
                            //         : Icon(Icons.account_circle_outlined)),
                            // Center(
                            //   child: RawMaterialButton(
                            //     onPressed: () async {
                            //       // model.upload();
                            //     },
                            //     child: model.userProfile != null
                            //         ? Container(
                            //             width: 120.0, // CircleAvatarのradiusの2倍
                            //             height: 120.0,
                            //           )
                            //         : Icon(Icons.account_circle_outlined),
                            //     shape: new CircleBorder(),
                            //     elevation: 3.0,
                            //   ),
                            // ),
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
                      ],
                    );
                  });
            },
            icon: Icon(
              Icons.account_circle,
              size: 30,
            ));
      }),
    );
  }
}
