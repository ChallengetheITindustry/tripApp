import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';

class PribacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 2.0,
        title: Text('プライバシーポリシー'),
        leading: IconButton(
          icon: Icon(Icons.backspace),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "プライバシーポリシー",
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DefaultTextStyle(
                      style: TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 100,
                      child: Padding(
                        child: Text(
                            "＿＿＿＿＿＿＿＿（以下，「当社」といいます。）は，本ウェブサイト上で提供するサービス（以下,「本サービス」といいます。）における，ユーザーの個人情報の取扱いについて，以下のとおりプライバシーポリシー（以下，「本ポリシー」といいます。）を定めます。"),
                        padding: EdgeInsets.only(top: 10.0),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
