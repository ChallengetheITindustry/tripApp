// ignore: unused_import
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/ui/home_page.dart';
import 'package:tripapp/ui/mail_password_reset.dart';
import 'package:tripapp/view_model/signin_model.dart';

class LoginPageForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider<SignInModel>(
      create: (_) => SignInModel(),
      child: Consumer<SignInModel>(builder: (context, model, child) {
        return Align(
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "One Trip",
                        style: GoogleFonts.miltonian(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: timelineBackground,
                        ),
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
                  width: SizeConfig.screenWidth * 0.6,
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
                          suffixIcon: IconButton(
                              onPressed: () {
                                model.changeObscureText();
                              },
                              icon: model.obscureText == false
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off)),
                        ),
                        obscureText: model.obscureText,
                        onChanged: (String value) {
                          model.password = value;
                        },
                      ),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MailPasswordResetPage()),
                      );
                    },
                    child: Text(
                      'パスワードを忘れた場合はこちら',
                      style: TextStyle(fontSize: 13),
                    )),
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
