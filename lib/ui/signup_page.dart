import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/view_model/signup_model.dart';
import 'mail_verify.dart';

class SignupPageForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel(),
      child: Consumer<SignUpModel>(builder: (context, model, child) {
        return Align(
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
            width: SizeConfig.screenWidth * 0.8,
            height: SizeConfig.screenHeight * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: SizeConfig.screenWidth * 0.6,
                  height: SizeConfig.screenHeight * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ユーザー名",
                        style: TextStyle(
                            color: timelineBackground,
                            fontWeight: FontWeight.bold),
                      ),
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
                          model.newUserName = value;
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth * 0.6,
                  height: SizeConfig.screenHeight * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "メールアドレス",
                        style: TextStyle(
                            color: timelineBackground,
                            fontWeight: FontWeight.bold),
                      ),
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
                          model.newEmail = value;
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "パスワード",
                        style: TextStyle(
                            color: timelineBackground,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "＊6字以上",
                        style: TextStyle(
                          fontSize: 10,
                          color: formBorderColor,
                        ),
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: formBorderColor,
                              ),
                            ),
                          ),
                          obscureText: true,
                          onChanged: (String value) {
                            if (value.length >= 6) {
                              model.newPassword = value;
                              model.pswd_OK = true;
                            } else {
                              model.pswd_OK = false;
                            }
                          }),
                    ],
                  ),
                ),
                Container(
                    width: SizeConfig.screenWidth * 0.6,
                    height: SizeConfig.blockSizeVertical * 6,
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
                        try {
                          await model.signUp();
                          await model.UserInfoAdd();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MailVerifyPage1(model.newEmail)),
                          );
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text(e.toString()),
                                actions: [
                                  // ボタン領域
                                  ElevatedButton(
                                    child: Text("OK"),
                                    onPressed: () => Navigator.pop(context),
                                    style: ElevatedButton.styleFrom(
                                      primary: primaryColor, //ボタンの背景色
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text(
                        '新規会員登録',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: timelineBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          )),
                    ))
              ],
            ),
          ),
        );
      }),
    );
  }
}
