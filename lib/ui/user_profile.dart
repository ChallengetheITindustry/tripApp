import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/view_model/user_profile_model.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final UserProfileModel data = Provider.of<UserProfileModel>(context);
    // data.getFirestore();
    // data.documentLength();
    // data.download();

    return ChangeNotifierProvider<UserProfileModel>(
      create: (_) => UserProfileModel()
        ..documentLength()
        ..download()
        ..getFirestore(),
      child: Consumer<UserProfileModel>(builder: (context, model, child) {
        return IconButton(
            // ユーザー情報画面
            onPressed: () {
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
                          height: SizeConfig.screenHeight * 0.1,
                        ),
                        Stack(
                          children: <Widget>[
                            Center(
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(model.userProfile),
                                radius: 60.0,
                              ),
                            ),
                            Center(
                              child: RawMaterialButton(
                                onPressed: () async {
                                  model.upload();
                                },
                                child: Container(
                                  width: 120.0, // CircleAvatarのradiusの2倍
                                  height: 120.0,
                                ),
                                shape: new CircleBorder(),
                                elevation: 3.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2,
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
                          height: SizeConfig.blockSizeVertical * 2,
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
                          height: SizeConfig.screenHeight * 0.1,
                        ),
                        // PageView.builder(
                        //   controller: controller,
                        //   itemCount: _imageList.length,
                        //   itemBuilder:
                        //       (context, int currentIndex) {
                        //     // カードの生成して返す
                        //     return Column(
                        //       mainAxisAlignment:
                        //           MainAxisAlignment.center,
                        //       children: [
                        //         Container(
                        //           width:
                        //               SizeConfig.screenWidth *
                        //                   0.7,
                        //           decoration: BoxDecoration(
                        //             boxShadow: [
                        //               BoxShadow(
                        //                   color:
                        //                       Colors.black12,
                        //                   blurRadius: 15.0,
                        //                   spreadRadius: 1.0,
                        //                   offset:
                        //                       Offset(10, 10))
                        //             ],
                        //           ),
                        //           child: ClipRRect(
                        //             borderRadius:
                        //                 BorderRadius.circular(
                        //                     20.0),
                        //             child: Image.network(
                        //                 'https://images.unsplash.com/photo-1472740378865-80aab8e73251?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80'),
                        //           ),
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // ),
                        Positioned(
                          top: SizeConfig.screenHeight * 0.7,
                          left: SizeConfig.screenWidth * 0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  '投稿回数：$model.documentNum回',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
