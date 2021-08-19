import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 2.0,
          title: Text('ホーム'),
        ),
        body: Column(
          children: [
            Container(
              child: Text('ホーム画面のテストです'),
            ),
          ],
        ));
  }
}
