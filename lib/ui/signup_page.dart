import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/view_model/signup_model.dart';

import 'home_page.dart';

class SignupPageForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 幅
    double width = MediaQuery.of(context).size.width;
    // 高さ
    double height = MediaQuery.of(context).size.height;
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
                          model.newUserName = value;
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
                          model.newEmail = value;
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("パスワード"),
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
                        try {
                          await model.signUp();
                          await model.UserInfoAdd();
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
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
                                    child: Text("ごめん🙇‍♂️"),
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
        );
      }),
    );
  }
}
