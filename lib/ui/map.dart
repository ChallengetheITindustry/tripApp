import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 2.0,
        title: Text('地図'),
      ),
      body: Container(
        child: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.backspace),
        ),
      ),
    );
  }
}
