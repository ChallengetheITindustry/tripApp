import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';

class TimeLinePage extends StatefulWidget {
  @override
  _TimeLinePage createState() => _TimeLinePage();
}

// ignore: must_be_immutable
class _TimeLinePage extends State {
  List<String> documentList = ['テスト'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 2.0,
          title: Text('タイムライン'),
        ),
        body: ListView.builder(
          itemCount: documentList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(documentList[index]),
              ),
            );
          },
        ));
  }
}
