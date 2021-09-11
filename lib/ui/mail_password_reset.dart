import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/view_model/mail_password_reset_model.dart';

class MailPasswordResetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MailPasswordResetModel>(
      create: (_) => MailPasswordResetModel(),
      child: Scaffold(
          backgroundColor: timelineBackground,
          body: Consumer<MailPasswordResetModel>(
              builder: (context, model, child) {
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
                        Icons.vpn_key_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.1,
                      ),
                      Text(
                        'パスワード再設定',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.07,
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
                            onChanged: (value) {
                              model.mail = value;
                            },
                            decoration: InputDecoration(
                              hintText: "test@sample.com",
                              hintStyle: TextStyle(color: Colors.white),
                            ),
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
                              await model.auth
                                  .sendPasswordResetEmail(email: model.mail);

                              return showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text("メールを送信しました。"),
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
                            'メールを送信',
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
