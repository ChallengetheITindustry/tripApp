import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 幅
    double width = MediaQuery.of(context).size.width;
    // 高さ
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        width: width,
        height: height * 0.3,
        color: primaryColor,
      ),
    );
  }
}

class LoginPageForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 幅
    double width = MediaQuery.of(context).size.width;
    // 高さ
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Align(
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
        ),
      ),
    );
  }
}
