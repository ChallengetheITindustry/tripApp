import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';

class TimeLinePage extends StatefulWidget {
  @override
  _TimeLinePage createState() => _TimeLinePage();
}

// ignore: must_be_immutable
class _TimeLinePage extends State {
  List<String> documentList = ['こんにちは'];

  String test = '';

  // ignore: unused_element
  Future _fireStoreGet() async {
    // コレクション内のドキュメント一覧を取得
    // ignore: unused_local_variable
    final snapshot =
        await FirebaseFirestore.instance.collection('timeline').get();
    // 取得したドキュメント一覧をUIに反映

    documentList = snapshot.docs.cast<String>();

    setState(() {});
  }

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
