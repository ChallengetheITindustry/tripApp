import 'package:flutter/material.dart';

class TestPage1 extends StatefulWidget {
  @override
  _TestPage1 createState() => _TestPage1();
}

// ignore: must_be_immutable
class _TestPage1 extends State {
  double _x = 0;
  double _y = 0;

  void _onTap() {
    setState(() {
      _x = 100;
      _y = 600;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
          width: 200,
          height: 200,
          color: Colors.blueAccent,
          duration: Duration(seconds: 10),
          transform: Matrix4.translationValues(_x, _y, 0)),
      floatingActionButton: FloatingActionButton(onPressed: _onTap),
    );
  }
}
