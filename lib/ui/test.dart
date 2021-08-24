import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
        ),
        body: Container(
          child: Text('テストです'),
        ));
  }
}
