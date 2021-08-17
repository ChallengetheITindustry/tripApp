import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';

class RulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 2.0,
        title: Text('利用規約'),
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
                      "利用規約",
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
                            "この利用規約（以下，「本規約」といいます。）は，＿＿＿＿＿（以下，「当社」といいます。）がこのウェブサイト上で提供するサービス（以下，「本サービス」といいます。）の利用条件を定めるものです。登録ユーザーの皆さま（以下，「ユーザー」といいます。）には，本規約に従って，本サービスをご利用いただきます。"),
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
