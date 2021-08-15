import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 幅
    double width = MediaQuery.of(context).size.width;

// 高さ
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height * 0.8,
      color: primaryColor,
    );
  }
}
