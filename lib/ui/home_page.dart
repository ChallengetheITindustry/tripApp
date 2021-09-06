import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/ui/user_edit_info.dart';
import 'package:tripapp/ui/user_profile_2.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import 'creata_plan.dart';
import 'map.dart';

class HomePage extends StatefulWidget {
  @override
  _TimeLinePage createState() => _TimeLinePage();
}

// ignore: must_be_immutable
class _TimeLinePage extends State {
  DateTime _dateStart = new DateTime.now();
  DateTime _dateEnd = new DateTime.now();

  Future<Null> _selectDateStart(BuildContext context) async {
    final DateTime? pickedStart = await showDatePicker(
      context: context,
      helpText: '旅の始まりを指定',
      cancelText: 'キャンセル',
      confirmText: '次へ',
      initialDate: _dateStart,
      firstDate: DateTime(2016),
      lastDate: DateTime.now().add(new Duration(days: 360 * 5)),
    );
    if (pickedStart != null) setState(() => _dateStart = pickedStart);
    _selectDateEnd(context);
  }

  Future<Null> _selectDateEnd(BuildContext context) async {
    final DateTime? pickedEnd = await showDatePicker(
      context: context,
      helpText: '旅の終わりを指定',
      cancelText: 'キャンセル',
      confirmText: '旅を始める',
      initialDate: _dateEnd,
      firstDate: DateTime(2016),
      lastDate: DateTime.now().add(new Duration(days: 360 * 5)),
    );
    if (pickedEnd != null) setState(() => _dateEnd = pickedEnd);
  }

  String currentUserName = '';
  String currentUserMail = '';
  String uid = '';
  // nullable
  // ignore: unused_field
  Image? _img;
  String userProfile = '';
  // firestorageに画像を保存する関数
  void upload() async {
    // ImagePickerで写真フォルダを開き、選択した画像をpickerFileに格納
    final pickerFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    // pickerFileのpathをFile()に変換し、fileに格納
    File file = File(pickerFile!.path);
// firestorageをインスタンス化
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.ref("UserProfile/$uid").putFile(file);
    } catch (e) {
      print(e);
    }
  }

  Future download() async {
    FirebaseStorage storage = FirebaseStorage.instance;

    // 画像
    Reference imageRef = storage.ref().child("UserProfile").child("$uid");
    String imageUrl = await imageRef.getDownloadURL();

    // 画面に反映
    setState(() {
      userProfile = imageUrl.toString();
    });
  }

  AudioCache _player = AudioCache();
  bool sounds = false;

  late AudioPlayer changeTakibi;
  // void _onTimer() {
  //   print('時間が経過しました！');
  // }

  // ignore: unused_element
  Future getFirestore() async {
    // ignore: await_only_futures
    final User user = await FirebaseAuth.instance.currentUser!;
    // ignore: unused_local_variable
    final String uid = user.uid.toString();
    // 指定コレクションのドキュメント一覧を取得
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    setState(() {
      currentUserName = snapshot['name'];
      currentUserMail = snapshot['mail'];
      this.uid = uid;
    });
  }

  String concept = '';
  String contents = '';

  Future setTrip() async {
    final User user = await FirebaseAuth.instance.currentUser!;
    final String uid = user.uid.toString();

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('trip')
        .add({
      'concept': concept,
      'data': '$_dateStart ~ $_dateEnd',
      'imageURL': 'ng;adoshg;osdg;o',
      'contents': contents,
    });

    await FirebaseFirestore.instance.collection('timeline').add({
      'userID': uid,
      'concept': concept,
      'data': '$_dateStart ~ $_dateEnd',
      'imageURL': 'ng;adoshg;osdg;o',
      'contents': contents,
    });
  }

  // ページコントローラ
  final PageController controller = PageController(viewportFraction: 0.8);

  // ページインデックス
  int currentPage = 0;

  // データ
  List<String> _imageList = [
    "images/card_back.png",
    "images/card_j.png",
    "images/card_q.png",
    "images/card_k.png",
  ];

  @override
  Widget build(BuildContext context) {
    getFirestore();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: timelineBackground,
        body: Stack(
          children: [
            Container(child: Image.asset('assets/images/moon.png')),
            Positioned(
              top: SizeConfig.blockSizeVertical * 20,
              left: 50,
              right: 50,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 1.0,
                            offset: Offset(15, 15))
                      ],
                    ),
                    child: Text(
                      '旅を共有しよう',
                      style: GoogleFonts.lobster(
                          color: Colors.white,
                          fontSize: 20,
                          textStyle: Theme.of(context).textTheme.headline4),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset('assets/images/tamariba.png'),
                Opacity(
                  opacity: 0.3,
                  child: Container(
                      width: SizeConfig.blockSizeHorizontal * 60,
                      height: SizeConfig.blockSizeVertical * 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10.0,
                              spreadRadius: 5.0,
                              offset: Offset(10, 10))
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    //モーダルの背景の色、透過
                                    backgroundColor: Colors.transparent,
                                    //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: SizeConfig
                                                      .blockSizeHorizontal *
                                                  20,
                                            ),
                                            Container(
                                              width:
                                                  SizeConfig.screenWidth * 0.8,
                                              decoration: BoxDecoration(
                                                border: const Border(
                                                  bottom: const BorderSide(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20.0),
                                                child: Text('旅の日記を書く',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                              ),
                                            ),
                                            SizedBox(
                                              height: SizeConfig
                                                      .blockSizeHorizontal *
                                                  10,
                                            ),
                                            Container(
                                              child: Text(
                                                '🚀どんな旅だった？🚀',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: SizeConfig
                                                      .blockSizeHorizontal *
                                                  10,
                                            ),
                                            Container(
                                              width:
                                                  SizeConfig.screenWidth * 0.8,
                                              child: TextFormField(
                                                onChanged: (value) {
                                                  concept = value;
                                                },
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      'ex：過酷？青春18きっぷで日本一周の旅！',
                                                  labelStyle: TextStyle(
                                                      color: formBorderColor),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: SizeConfig
                                                      .blockSizeHorizontal *
                                                  10,
                                            ),
                                            Container(
                                              width:
                                                  SizeConfig.screenWidth * 0.8,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: <Widget>[
                                                      // ignore: unnecessary_brace_in_string_interps
                                                      Text(
                                                        "開始日：${_dateStart!.year}-${_dateStart!.month}-${_dateStart!.day} ~ ",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                      Text(
                                                        "終了日：${_dateEnd!.year}-${_dateEnd!.month}-${_dateEnd!.day} ~ ",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  IconButton(
                                                    onPressed: () async {
                                                      _selectDateStart(context);
                                                    },
                                                    icon: Icon(
                                                      Icons.timer,
                                                      color: Colors.white,
                                                      size: 40,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: SizeConfig
                                                      .blockSizeHorizontal *
                                                  10,
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.5,
                                                  height:
                                                      SizeConfig.screenHeight *
                                                          0.15,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    border: Border.all(
                                                        color: Colors.white),
                                                  ),
                                                  child: IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: SizeConfig
                                                          .blockSizeHorizontal *
                                                      10,
                                                ),
                                                Container(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.8,
                                                  child: TextField(
                                                    onChanged: (value) {
                                                      contents = value;
                                                    },
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: SizeConfig
                                                          .blockSizeHorizontal *
                                                      10,
                                                ),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    )),
                                                SizedBox(
                                                  height: SizeConfig
                                                          .blockSizeHorizontal *
                                                      10,
                                                ),
                                                Container(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.6,
                                                  height:
                                                      SizeConfig.screenHeight *
                                                          0.05,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        side: BorderSide(
                                                          color: Colors
                                                              .white, //枠線!
                                                          width: 1, //枠線！
                                                        ),
                                                        primary:
                                                            Colors.transparent,
                                                      ),
                                                      onPressed: () async {
                                                        await setTrip();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        '共有する',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      '戻る',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[400]),
                                                    )),
                                                SizedBox(
                                                  height: SizeConfig
                                                          .blockSizeHorizontal *
                                                      50,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.chat_bubble_outline,
                                size: 30,
                              )),
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    //モーダルの背景の色、透過
                                    backgroundColor: Colors.transparent,
                                    //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Stack(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Container(
                                                  child: Text(
                                                    'いいね一覧❤️',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.favorite_border_outlined,
                                size: 30,
                              )),
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    //モーダルの背景の色、透過
                                    backgroundColor: Colors.transparent,
                                    //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Stack(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Container(
                                                  child: Text(
                                                    'たくさん日記を投稿して地図を埋めよう🚀',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.05,
                                              ),
                                              Center(
                                                  child: Container(
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Image.asset(
                                                          'assets/images/2525.png'))),
                                            ],
                                          ),
                                          // 北海道
                                          Positioned(
                                            top: SizeConfig.screenHeight * 0.3,
                                            right: 1.5,
                                            child: Container(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  42,
                                              child: Image.asset(
                                                  'assets/images/hokkaido.png'),
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.map_outlined,
                                size: 30,
                              )),
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    //モーダルの背景の色、透過
                                    backgroundColor: Colors.transparent,
                                    //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                width: SizeConfig.screenWidth,
                                                height: SizeConfig
                                                        .blockSizeVertical *
                                                    35,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.transparent),
                                                  color: timelineBackground,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(150),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black12,
                                                        blurRadius: 15.0,
                                                        spreadRadius: 1.0,
                                                        offset: Offset(10, 10))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height:
                                                SizeConfig.screenHeight * 0.4,
                                            child: Stack(
                                              children: [
                                                // Container(
                                                //     width: SizeConfig.screenWidth * 0.5,
                                                //     decoration: BoxDecoration(
                                                //       color: Colors.blue,
                                                //       shape: BoxShape.circle,
                                                //     )),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          1,
                                                    ),
                                                    Center(
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            child: CircleAvatar(
                                                              radius: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  15,
                                                              backgroundColor:
                                                                  Colors.brown
                                                                      .shade800,
                                                              // ignore: unnecessary_null_comparison
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      'https://images.unsplash.com/photo-1536825211030-094de935f680?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80'),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: SizeConfig
                                                              .blockSizeVertical *
                                                          1,
                                                    ),
                                                    Container(
                                                      width: SizeConfig
                                                              .screenWidth *
                                                          0.6,
                                                      child: Column(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          color: Colors
                                                                              .black12,
                                                                          spreadRadius:
                                                                              0,
                                                                          offset: Offset(
                                                                              15,
                                                                              15))
                                                                    ],
                                                                  ),
                                                                  child: Text(
                                                                    // ログインユーザーの名前を表示
                                                                    currentUserName,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          30,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  )),
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .blockSizeVertical *
                                                                    3,
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  // ログインユーザーのメールアドレスを表示
                                                                  currentUserMail,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          PageView.builder(
                                            controller: controller,
                                            itemCount: _imageList.length,
                                            itemBuilder:
                                                (context, int currentIndex) {
                                              // カードの生成して返す
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.7,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color:
                                                                Colors.black12,
                                                            blurRadius: 15.0,
                                                            spreadRadius: 1.0,
                                                            offset:
                                                                Offset(10, 10))
                                                      ],
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: Image.network(
                                                          'https://images.unsplash.com/photo-1472740378865-80aab8e73251?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80'),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                          Positioned(
                                            top: SizeConfig.screenHeight * 0.7,
                                            left: SizeConfig.screenWidth * 0.3,
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Text(
                                                    '投稿回数：8回',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 30,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    'テスト',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: SizeConfig.blockSizeVertical *
                                                8,
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    80,
                                            child: Container(
                                              child: IconButton(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                      //モーダルの背景の色、透過
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 64),
                                                          decoration:
                                                              BoxDecoration(
                                                            //モーダル自体の色
                                                            color: Colors.white,
                                                            //角丸にする
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              topRight: Radius
                                                                  .circular(20),
                                                            ),
                                                          ),
                                                          child: ListView(
                                                            //scrollDirection: Axis.horizontal, // 横
                                                            padding:
                                                                EdgeInsets.all(
                                                                    36.0),
                                                            shrinkWrap: true,
                                                            children: [
                                                              Container(
                                                                height: 80,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .black12,
                                                                        blurRadius:
                                                                            10.0,
                                                                        spreadRadius:
                                                                            1.0,
                                                                        offset: Offset(
                                                                            5,
                                                                            5))
                                                                  ],
                                                                ),
                                                                child: Card(
                                                                  child:
                                                                      ListTile(
                                                                    leading: Icon(
                                                                        Icons
                                                                            .edit),
                                                                    title: Text(
                                                                      "ユーザー情報編集",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20),
                                                                    ),
                                                                    contentPadding:
                                                                        EdgeInsets.all(
                                                                            10.0),
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                UserEditInfo()),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 80,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .black12,
                                                                        blurRadius:
                                                                            10.0,
                                                                        spreadRadius:
                                                                            1.0,
                                                                        offset: Offset(
                                                                            5,
                                                                            5))
                                                                  ],
                                                                ),
                                                                child: Card(
                                                                  child:
                                                                      ListTile(
                                                                    leading: Icon(
                                                                        Icons
                                                                            .mail),
                                                                    title: Text(
                                                                      "お問い合わせ",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20),
                                                                    ),
                                                                    subtitle: Text(
                                                                        '外部サイト'),
                                                                    contentPadding:
                                                                        EdgeInsets.all(
                                                                            10.0),
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      launch(
                                                                          'https://forms.gle/bJndj6BKZbKiFSgi9');
                                                                      // https://forms.gle/bJndj6BKZbKiFSgi9
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 80,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .black12,
                                                                        blurRadius:
                                                                            10.0,
                                                                        spreadRadius:
                                                                            1.0,
                                                                        offset: Offset(
                                                                            5,
                                                                            5))
                                                                  ],
                                                                ),
                                                                child: Card(
                                                                  child:
                                                                      ListTile(
                                                                    leading: Icon(
                                                                        Icons
                                                                            .book),
                                                                    subtitle: Text(
                                                                        '外部サイト'),
                                                                    title: Text(
                                                                      "利用規約",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20),
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
                                                              ),
                                                              Container(
                                                                height: 80,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .black12,
                                                                        blurRadius:
                                                                            10.0,
                                                                        spreadRadius:
                                                                            1.0,
                                                                        offset: Offset(
                                                                            5,
                                                                            5))
                                                                  ],
                                                                ),
                                                                child: Card(
                                                                  child:
                                                                      ListTile(
                                                                    leading: Icon(
                                                                        Icons
                                                                            .rule),
                                                                    subtitle: Text(
                                                                        '外部サイト'),
                                                                    title: Text(
                                                                      "プライバシーポリシー",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20),
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
                                                              ),
                                                              Container(
                                                                height: 80,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .black12,
                                                                        blurRadius:
                                                                            10.0,
                                                                        spreadRadius:
                                                                            1.0,
                                                                        offset: Offset(
                                                                            5,
                                                                            5))
                                                                  ],
                                                                ),
                                                                child: Card(
                                                                  child:
                                                                      ListTile(
                                                                    leading: Icon(
                                                                        Icons
                                                                            .exit_to_app),
                                                                    title: Text(
                                                                      "ログアウト",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20),
                                                                    ),
                                                                    contentPadding:
                                                                        EdgeInsets.all(
                                                                            10.0),
                                                                    onTap:
                                                                        () async {
                                                                      Navigator.pop(
                                                                          context);
                                                                      // ログアウト処理
                                                                      // 内部で保持しているログイン情報等が初期化される
                                                                      // （現時点ではログアウト時はこの処理を呼び出せばOKと、思うぐらいで大丈夫です）
                                                                      await FirebaseAuth
                                                                          .instance
                                                                          .signOut();
                                                                      // ログイン画面に遷移＋チャット画面を破棄
                                                                      await Navigator.of(
                                                                              context)
                                                                          .pushReplacement(
                                                                        MaterialPageRoute(builder:
                                                                            (context) {
                                                                          return MyApp();
                                                                        }),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                icon: Icon(
                                                  Icons.clear_all,
                                                  size: 40,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Center(
                                          //   child: Column(
                                          //     mainAxisAlignment: MainAxisAlignment.center,
                                          //     children: [
                                          //       Text('ここにPageViewを表示させます'),
                                          //     ],
                                          //   ),
                                          // )
                                        ],
                                      );
                                    });
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => UserProfilePage2()),
                                // );
                              },
                              icon: Icon(
                                Icons.account_box_outlined,
                                size: 30,
                              )),
                        ],
                      )),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 7,
                )
              ],
            ),
            Positioned(
              top: SizeConfig.blockSizeVertical * 8,
              right: SizeConfig.blockSizeHorizontal * 80,
              child: Container(
                child: sounds != false
                    ? IconButton(
                        onPressed: () async {
                          await changeTakibi.stop();

                          setState(() {
                            sounds = !sounds;
                          });
                        },
                        icon: Icon(
                          Icons.volume_up_outlined,
                          size: 40,
                          color: Colors.white,
                        ),
                      )
                    : IconButton(
                        onPressed: () async {
                          AudioPlayer audioSourceTakibi =
                              await _player.loop('fire.mp3');

                          setState(() {
                            sounds = !sounds;
                            changeTakibi = audioSourceTakibi;
                          });
                        },
                        icon: Icon(
                          Icons.volume_off_outlined,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ));
  }
}
