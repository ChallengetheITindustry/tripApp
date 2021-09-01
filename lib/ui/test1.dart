import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestPage1 extends StatefulWidget {
  @override
  _TestPage1 createState() => _TestPage1();
}

// ignore: must_be_immutable
class _TestPage1 extends State {
  double _margin = 20;
  void _onTap() => setState(() => _margin = 100);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        width: 200,
        height: 200,
        color: Colors.blueAccent,
        margin: EdgeInsets.all(_margin),
        duration: Duration(seconds: 10),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _onTap),
    );
  }
}
