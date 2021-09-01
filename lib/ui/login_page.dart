// ignore: unused_import
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/ui/home_page.dart';
import 'package:tripapp/view_model/login_model.dart';

class LoginPageForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 幅
    double width = MediaQuery.of(context).size.width;
    // 高さ
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider<SignInModel>(
      create: (_) => SignInModel(),
      child: Consumer<SignInModel>(builder: (context, model, child) {
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
                // スペースを開けたいときはSizedBoxを記述する
                Container(
                  width: width * 0.6,
                  height: height * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "One Trip",
                        style: GoogleFonts.miltonian(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
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
                        initialValue: 'reeksge@gmail.com',
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: formBorderColor,
                            ),
                          ),
                        ),
                        onChanged: (String value) {
                          model.email = value;
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
                        initialValue: '123456',
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
                          model.password = value;
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
                        // // メール認証していないユーザーの場合はメール認証画面へ飛ばすように設定する
                        // final FirebaseAuth _auth = FirebaseAuth.instance;
                        // // メール認証完了しているか取得
                        // final _isVerified =
                        //     // ignore: await_only_futures
                        //     await _auth.currentUser!.emailVerified;

                        // if (!_isVerified) {
                        //   // サインアウトする
                        //   await _auth.signOut();
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => MailVerifyPage()),
                        //   );
                        // } else {
                        try {
                          await model.signIn();
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
                      // },
                      child: Text(
                        'ログイン',
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
