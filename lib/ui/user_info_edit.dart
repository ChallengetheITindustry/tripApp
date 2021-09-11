import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/view_model/mail_password_reset_model.dart';
import 'package:tripapp/view_model/user_info_edit_model.dart';

class UserInfoEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserInfoEditModel>(
      create: (_) => UserInfoEditModel()..getFirestore(),
      child: Scaffold(
          backgroundColor: timelineBackground,
          body: Consumer<UserInfoEditModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Positioned(
                  top: SizeConfig.blockSizeVertical * 8,
                  right: SizeConfig.blockSizeHorizontal * 80,
                  child: Container(
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.backspace,
                            color: Colors.white,
                            size: 30,
                          ))),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_box_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.05,
                      ),
                      Text(
                        'ユーザー情報編集',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.05,
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.8,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'ユーザー名',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                          width: SizeConfig.screenWidth * 0.8,
                          child: TextFormField(
                            initialValue: model.currentUserName,
                            onChanged: (value) {
                              model.newUserName = value;
                            },
                          )),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.05,
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.8,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'メールアドレス',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                          width: SizeConfig.screenWidth * 0.8,
                          child: TextFormField(
                            initialValue: model.currentUserMail,
                            onChanged: (value) {
                              model.newUserMail = value;
                            },
                          )),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.05,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 5.0,
                            padding: EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 100,
                            ),
                          ),
                          onPressed: () async {
                            try {
                              model.fireStoreUpdate();
                              return showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text("更新しました。"),
                                    actions: <Widget>[
                                      // ボタン領域
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: timelineBackground,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Text("閉じる"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } catch (e) {
                              return showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text(e.toString()),
                                    actions: <Widget>[
                                      // ボタン領域
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: timelineBackground,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Text("閉じる"),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Text(
                            '更新',
                            style: TextStyle(
                                color: timelineBackground, fontSize: 15),
                          ))
                    ],
                  ),
                ),
              ],
            );
          })),
    );
  }
}
