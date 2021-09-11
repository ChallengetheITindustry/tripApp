import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/ui/user_edit_info.dart';
import 'package:tripapp/ui/user_info_edit.dart';
import 'package:tripapp/view_model/config_page_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class ConfigPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConfigPageModel>(
      create: (_) => ConfigPageModel(),
      child: Consumer<ConfigPageModel>(builder: (context, model, child) {
        return IconButton(
            onPressed: () {
              showModalBottomSheet(
                  //モーダルの背景の色、透過
                  backgroundColor: Colors.transparent,
                  //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 7,
                        ),
                        Center(
                          child: Container(
                            width: SizeConfig.screenWidth * 0.8,
                            decoration: BoxDecoration(
                              border: const Border(
                                bottom: const BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                '設定',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: ListView(
                            //scrollDirection: Axis.horizontal, // 横
                            padding: EdgeInsets.all(36.0),
                            shrinkWrap: true,
                            children: [
                              Container(
                                height: 80,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    "ユーザー情報編集",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  contentPadding: EdgeInsets.all(10.0),
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserInfoEditPage()),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                height: 80,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.mail,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    "お問い合わせ",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  contentPadding: EdgeInsets.all(10.0),
                                  onTap: () {
                                    Navigator.pop(context);
                                    launch(
                                        'https://forms.gle/bJndj6BKZbKiFSgi9');
                                    // https://forms.gle/bJndj6BKZbKiFSgi9
                                  },
                                ),
                              ),
                              Container(
                                height: 80,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.rule,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    "このアプリについて",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  contentPadding: EdgeInsets.all(10.0),
                                  onTap: () {
                                    showModalBottomSheet(
                                        //モーダルの背景の色、透過
                                        backgroundColor: Colors.transparent,
                                        //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Column(
                                            children: [
                                              SizedBox(
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    7,
                                              ),
                                              Center(
                                                child: Container(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.8,
                                                  decoration: BoxDecoration(
                                                    border: const Border(
                                                      bottom: const BorderSide(
                                                        color: Colors.white,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: Text(
                                                      'このアプリについて',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: ListView(
                                                  //scrollDirection: Axis.horizontal, // 横
                                                  padding: EdgeInsets.all(36.0),
                                                  shrinkWrap: true,
                                                  children: [
                                                    Container(
                                                      height: 80,
                                                      child: ListTile(
                                                        leading: Icon(
                                                          Icons.book,
                                                          color: Colors.white,
                                                        ),
                                                        title: Text(
                                                          "利用規約",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 17),
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.all(
                                                                10.0),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          launch(
                                                              'https://polyester-clave-a16.notion.site/10b6e2bb52af49e1a051e0f44b5c2408');
                                                        },
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 80,
                                                      child: ListTile(
                                                        leading: Icon(
                                                          Icons.rule,
                                                          color: Colors.white,
                                                        ),
                                                        title: Text(
                                                          "プライバシーポリシー",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 17),
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.all(
                                                                10.0),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          launch(
                                                              'https://polyester-clave-a16.notion.site/6664b852b1c34ecb98774711566e4c29');
                                                        },
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 80,
                                                      child: ListTile(
                                                        leading: Icon(
                                                          Icons.rule,
                                                          color: Colors.white,
                                                        ),
                                                        title: Text(
                                                          "One Tripとは？",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 17),
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.all(
                                                                10.0),
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          launch(
                                                              'https://polyester-clave-a16.notion.site/6664b852b1c34ecb98774711566e4c29');
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                ),
                              ),
                              Container(
                                height: 80,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.exit_to_app,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    "ログアウト",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  contentPadding: EdgeInsets.all(10.0),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    // ログアウト処理
                                    // 内部で保持しているログイン情報等が初期化される
                                    // （現時点ではログアウト時はこの処理を呼び出せばOKと、思うぐらいで大丈夫です）
                                    await FirebaseAuth.instance.signOut();
                                    // ログイン画面に遷移＋チャット画面を破棄
                                    await Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                        return MyApp();
                                      }),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
              // showModalBottomSheet(
              //     //モーダルの背景の色、透過
              //     backgroundColor: Colors.transparent,
              //     //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
              //     isScrollControlled: true,
              //     context: context,
              //     builder: (BuildContext context) {
              //       return Stack(
              //         children: [
              //           Column(
              //             mainAxisAlignment:
              //                 MainAxisAlignment.center,
              //             children: [
              //               Center(
              //                 child: Container(
              //                   child: Text(
              //                     'たくさん日記を投稿して地図を埋めよう🚀',
              //                     style: TextStyle(
              //                         color: Colors.white),
              //                   ),
              //                 ),
              //               ),
              //               SizedBox(
              //                 height:
              //                     SizeConfig.screenHeight *
              //                         0.05,
              //               ),
              //               Center(
              //                   child: Container(
              //                       decoration:
              //                           BoxDecoration(),
              //                       child: Image.asset(
              //                           'assets/images/2525.png'))),
              //             ],
              //           ),
              //           // 北海道
              //           Positioned(
              //             top: SizeConfig.screenHeight * 0.3,
              //             right: 1.5,
              //             child: Container(
              //               width: SizeConfig
              //                       .blockSizeHorizontal *
              //                   42,
              //               child: Image.asset(
              //                   'assets/images/hokkaido.png'),
              //             ),
              //           )
              //         ],
              //       );
              //     });
            },
            icon: Icon(
              Icons.settings_sharp,
              size: 30,
            ));
      }),
    );
  }
}
