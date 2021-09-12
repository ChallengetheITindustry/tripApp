import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/ui/user_info_edit.dart';
import 'package:tripapp/view_model/config_page_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:share/share.dart';

import '../main.dart';

class ConfigPage extends StatelessWidget {
  Future share() async {
    // ここにアプリのURLを組み込む
    await Share.share("https://twitter.com/taisei59119317");
  }

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
                                    EvaIcons.twitter,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    "運営公式Twitter",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  contentPadding: EdgeInsets.all(10.0),
                                  onTap: () {
                                    Navigator.pop(context);
                                    launch(
                                        'https://twitter.com/taisei59119317');
                                    // https://forms.gle/bJndj6BKZbKiFSgi9
                                  },
                                ),
                              ),
                              Container(
                                height: 80,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    "アプリをシェアする",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  contentPadding: EdgeInsets.all(10.0),
                                  onTap: () async {
                                    await share();
                                  },
                                ),
                              ),
                              Container(
                                height: 80,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.ad_units,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    "このアプリについて",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  contentPadding: EdgeInsets.all(10.0),
                                  onTap: () {
                                    Navigator.pop(context);
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
                                                          Icons
                                                              .add_alert_outlined,
                                                          color: Colors.white,
                                                        ),
                                                        title: Text(
                                                          "お知らせ",
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
                                                          showModalBottomSheet(
                                                              //モーダルの背景の色、透過
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                                                              isScrollControlled:
                                                                  true,
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return Column(
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          SizeConfig.blockSizeVertical *
                                                                              7,
                                                                    ),
                                                                    Container(
                                                                      width: SizeConfig
                                                                              .screenWidth *
                                                                          0.8,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border:
                                                                            const Border(
                                                                          bottom:
                                                                              const BorderSide(
                                                                            color:
                                                                                Colors.white,
                                                                            width:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(bottom: 8.0),
                                                                        child:
                                                                            Text(
                                                                          'お知らせ',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
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
                                                          Icons
                                                              .rule_folder_outlined,
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
                                                          Icons.group_rounded,
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
                                                          showModalBottomSheet(
                                                              //モーダルの背景の色、透過
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                                                              isScrollControlled:
                                                                  true,
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return Column(
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          SizeConfig.blockSizeVertical *
                                                                              7,
                                                                    ),
                                                                    Container(
                                                                      width: SizeConfig
                                                                              .screenWidth *
                                                                          0.8,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border:
                                                                            const Border(
                                                                          bottom:
                                                                              const BorderSide(
                                                                            color:
                                                                                Colors.white,
                                                                            width:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(bottom: 8.0),
                                                                        child:
                                                                            Text(
                                                                          'One Trip',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          SizeConfig.blockSizeVertical *
                                                                              7,
                                                                    ),
                                                                    Container(
                                                                      width: SizeConfig
                                                                              .screenWidth *
                                                                          0.8,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          CircleAvatar(
                                                                            backgroundImage:
                                                                                NetworkImage('https://images.unsplash.com/photo-1595864735053-6cc67e8b53eb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=668&q=80'),
                                                                            radius:
                                                                                60.0,
                                                                          ),
                                                                          Spacer(),
                                                                          Column(
                                                                            children: [
                                                                              Text(
                                                                                'Taisei',
                                                                                style: TextStyle(color: Colors.white, fontSize: 30),
                                                                              ),
                                                                              Text(
                                                                                'reeksge@gmail.com',
                                                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                );
                                                              });
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
                                    model.signOut();
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
            },
            icon: Icon(
              Icons.settings_sharp,
              size: 30,
            ));
      }),
    );
  }
}
