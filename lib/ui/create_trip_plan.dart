import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';

class CreateTripPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 2.0,
          title: Text('ホーム'),
        ),
        body: Container(
          child: Text('テストです'),
        ));
  }
}
