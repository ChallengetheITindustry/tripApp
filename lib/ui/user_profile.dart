import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.clear_all,
                  color: primaryColor,
                ),
              ),
            ]),
        body: Column(
          children: [],
        ));
  }
}
