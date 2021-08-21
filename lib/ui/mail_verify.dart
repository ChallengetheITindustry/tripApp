import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';

// ignore: camel_case_types
class MailVerifyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 2.0,
          title: Text('メール認証'),
          leading: IconButton(
            icon: Icon(Icons.backspace),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    'メールアドレス認証\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                      'お客様のメールアドレス【reeksge@gmail.com】は\nメール認証が完了していません。ログインするためにはメール認証する必要があるため、お送りしましたメールをご確認ください。\n\n'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text('▼メールが届いていない場合は下記からメールを送信することができます'),
                ),
                TextButton(
                  onPressed: () {
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    // もう一度メール送信
                    _auth.currentUser!.sendEmailVerification();
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text('メール送ったよ🤗'),
                          actions: [
                            // ボタン領域
                            ElevatedButton(
                              child: Text("さんきゅ✌️😇✌️"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor, //ボタンの背景色
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('認証用のメールを送信する'),
                )
              ],
            ),
          ),
        ));
  }
}

// ignore: camel_case_types
class MailVerifyPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 2.0,
          title: Text('メール認証'),
          leading: IconButton(
            icon: Icon(Icons.backspace),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    'メールアドレス認証\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                      'お客様のメールアドレス【reeksge@gmail.com】にメールを送信いたしました！\nメールに記載のURLをタップしてメールアドレスの認証を完了させてください\n（メールアドレス認証が完了しないと本アプリを利用することはできません。）\n\n'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text('▼メールが届いていない場合は下記からメールを送信することができます'),
                ),
                TextButton(
                  onPressed: () {
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    // もう一度メール送信
                    _auth.currentUser!.sendEmailVerification();
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text('メール送ったよ🤗'),
                          actions: [
                            // ボタン領域
                            ElevatedButton(
                              child: Text("さんきゅ✌️😇✌️"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor, //ボタンの背景色
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('認証用のメールを送信する'),
                )
              ],
            ),
          ),
        ));
  }
}
