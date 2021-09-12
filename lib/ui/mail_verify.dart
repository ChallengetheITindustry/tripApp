import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';

// ignore: camel_case_types
class MailVerifyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: timelineBackground,
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    'メールアドレス認証\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    'お客様のメールアドレス【reeksge@gmail.com】は\nメール認証が完了していません。ログインするためにはメール認証する必要があるため、お送りしましたメールをご確認ください。\n\n',
                    style: TextStyle(color: Colors.white),
                  ),
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
                          title: Text('メールを送信しました'),
                          actions: [
                            // ボタン領域
                            ElevatedButton(
                              child: Text("閉じる"),
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
                  child: Text('メールを再送する'),
                ),
                FloatingActionButton(
                    backgroundColor: timelineBackground,
                    child: Icon(Icons.backspace),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ));
  }
}

// ignore: camel_case_types
class MailVerifyPage1 extends StatelessWidget {
  MailVerifyPage1(this.userMail);
  String userMail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: timelineBackground,
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    'メールアドレス認証\n\n',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    'お客様のメールアドレス【$userMail】に認証用のメールを送信いたしました\n\nメールに記載のURLをタップしてメールの認証を完了させてください\n（メール認証が完了しないと本アプリを利用することはできません。）\n\n',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    '▼メールが届いていない場合は下記からメールを送信することができます',
                    style: TextStyle(color: Colors.white),
                  ),
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
                          title: Text('メールを送信しました。'),
                          actions: [
                            // ボタン領域
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: timelineBackground,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text("閉じる"),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('メールを再送する'),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                ),
                FloatingActionButton(
                    backgroundColor: timelineBackground,
                    child: Icon(Icons.backspace),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ));
  }
}
