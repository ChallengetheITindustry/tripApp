import 'dart:async' show Future;
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
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

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
      helpText: '旅の始まり',
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
      confirmText: '決定',
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
  File? _image;
  String userProfile = '';

  void tripImageUpload() async {
// firestorageをインスタンス化
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.ref("$uid/$tripDocumentId/$concept").putFile(_image!);
    } catch (e) {
      print(e);
    }
  }

  void addTripImage() async {
    // ImagePickerで写真フォルダを開き、選択した画像をpickerFileに格納
    final pickerFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    File file = File(pickerFile!.path);
    setState(() {
      _image = file;
    });
  }

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
  String tripDocumentId = '';
  String ID = '';

  Future setTrip() async {
    final User user = await FirebaseAuth.instance.currentUser!;
    final String uid = user.uid.toString();

    // 自動で生成するIDを設定する

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('trip')
        .add({
      'concept': concept,
      'data': '$_dateStart ~ $_dateEnd',
      'imageURL': 'ng;adoshg;osdg;o',
      'contents': contents,
      'ID': ID,
    });

    await FirebaseFirestore.instance.collection('timeline').add({
      'userID': uid,
      'concept': concept,
      'data': '$_dateStart ~ $_dateEnd',
      'imageURL': 'ng;adoshg;osdg;o',
      'contents': contents,
    });
    final tripDocument = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('trip')
        .doc()
        .id;

    setState(() {
      tripDocumentId = tripDocumentId.toString();
    });
  }

  String documentNum = '';

  Future documentLength() async {
    final QuerySnapshot documentLength = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('trip')
        .get();
    final documents = documentLength.docs.length;
    setState(() {
      documentNum = documents.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    getFirestore();
    documentLength();
    download();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: timelineBackground,
        body: Stack(
          children: [
            Container(child: Image.asset('assets/images/moon.png')),
            Center(
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      //モーダルの背景の色、透過
                      backgroundColor: Colors.transparent,
                      //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: SizeConfig.blockSizeHorizontal * 20,
                              ),
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
                                  '投稿内容',
                                  style: GoogleFonts.lobster(
                                      color: Colors.white,
                                      fontSize: 20,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.favorite_border))
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                    width: SizeConfig.screenWidth * 0.2,
                    child: Image.asset('assets/images/hukidashimaruleft.png')),
              ),
            ),
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
                                            Container(
                                              width:
                                                  SizeConfig.screenWidth * 0.8,
                                              child: ListView(
                                                shrinkWrap: true,
                                                children: [
                                                  SizedBox(
                                                    height: SizeConfig
                                                            .blockSizeHorizontal *
                                                        10,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      'どんな旅だった？',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: SizeConfig
                                                            .blockSizeHorizontal *
                                                        10,
                                                  ),
                                                  Container(
                                                    child: TextFormField(
                                                      onChanged: (value) {
                                                        concept = value;
                                                      },
                                                      autofocus: true,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'ex：過酷？青春18きっぷで日本一周の旅！',
                                                        labelStyle: TextStyle(
                                                            color:
                                                                formBorderColor),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
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
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            // ignore: unnecessary_brace_in_string_interps
                                                            Text(
                                                              "始まり：${_dateStart.year}-${_dateStart.month}-${_dateStart.day} ~ ",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                            Text(
                                                              "終わり：${_dateEnd.year}-${_dateEnd.month}-${_dateEnd.day} ~ ",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        IconButton(
                                                          onPressed: () async {
                                                            _selectDateStart(
                                                                context);
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
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.white),
                                                    ),
                                                    child: ConstrainedBox(
                                                      constraints:
                                                          BoxConstraints(
                                                              maxHeight: 500),
                                                      child: Scrollbar(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0,
                                                                  right: 8.0),
                                                          child: TextField(
                                                            maxLines: 100,
                                                            minLines: 10,
                                                          ),
                                                        ),
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
                                                            0.6,
                                                    height: SizeConfig
                                                            .screenHeight *
                                                        0.05,
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          side: BorderSide(
                                                            color: Colors
                                                                .white, //枠線!
                                                            width: 1, //枠線！
                                                          ),
                                                          primary: Colors
                                                              .transparent,
                                                        ),
                                                        onPressed: () async {
                                                          // await setTrip();
                                                          // tripImageUpload();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          '投稿',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: SizeConfig
                                                            .blockSizeHorizontal *
                                                        50,
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.create_sharp,
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
                                                      'いいね一覧',
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
                                            ],
                                          ),
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.favorite,
                                size: 30,
                              )),
                          IconButton(
                              // ユーザー情報画面
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
                                            height:
                                                SizeConfig.screenHeight * 0.1,
                                          ),
                                          Stack(
                                            children: <Widget>[
                                              Center(
                                                child: CircleAvatar(
                                                  backgroundImage:
                                                      NetworkImage(userProfile),
                                                  radius: 60.0,
                                                ),
                                              ),
                                              Center(
                                                child: RawMaterialButton(
                                                  onPressed: () async {
                                                    upload();
                                                  },
                                                  child: Container(
                                                    width:
                                                        120.0, // CircleAvatarのradiusの2倍
                                                    height: 120.0,
                                                  ),
                                                  shape: new CircleBorder(),
                                                  elevation: 3.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    2,
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black12,
                                                      spreadRadius: 0,
                                                      offset: Offset(15, 15))
                                                ],
                                              ),
                                              child: Text(
                                                // ログインユーザーの名前を表示
                                                currentUserName,
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              )),
                                          SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    2,
                                          ),
                                          Container(
                                            child: Text(
                                              // ログインユーザーのメールアドレスを表示
                                              currentUserMail,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.screenHeight * 0.1,
                                          ),
                                          // PageView.builder(
                                          //   controller: controller,
                                          //   itemCount: _imageList.length,
                                          //   itemBuilder:
                                          //       (context, int currentIndex) {
                                          //     // カードの生成して返す
                                          //     return Column(
                                          //       mainAxisAlignment:
                                          //           MainAxisAlignment.center,
                                          //       children: [
                                          //         Container(
                                          //           width:
                                          //               SizeConfig.screenWidth *
                                          //                   0.7,
                                          //           decoration: BoxDecoration(
                                          //             boxShadow: [
                                          //               BoxShadow(
                                          //                   color:
                                          //                       Colors.black12,
                                          //                   blurRadius: 15.0,
                                          //                   spreadRadius: 1.0,
                                          //                   offset:
                                          //                       Offset(10, 10))
                                          //             ],
                                          //           ),
                                          //           child: ClipRRect(
                                          //             borderRadius:
                                          //                 BorderRadius.circular(
                                          //                     20.0),
                                          //             child: Image.network(
                                          //                 'https://images.unsplash.com/photo-1472740378865-80aab8e73251?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80'),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     );
                                          //   },
                                          // ),
                                          Positioned(
                                            top: SizeConfig.screenHeight * 0.7,
                                            left: SizeConfig.screenWidth * 0.3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    '投稿回数：$documentNum回',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 30,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
                                Icons.account_circle,
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
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    7,
                                          ),
                                          Center(
                                            child: Container(
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
                                                    bottom: 8.0),
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
                                                          color: Colors.white,
                                                          fontSize: 17),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.all(10.0),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                UserEditInfo()),
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
                                                          color: Colors.white,
                                                          fontSize: 17),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.all(10.0),
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
                                                      Icons.book,
                                                      color: Colors.white,
                                                    ),
                                                    title: Text(
                                                      "利用規約",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.all(10.0),
                                                    onTap: () {
                                                      Navigator.pop(context);
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
                                                          color: Colors.white,
                                                          fontSize: 17),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.all(10.0),
                                                    onTap: () {
                                                      Navigator.pop(context);
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
                                                      "このアプリについて",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.all(10.0),
                                                    onTap: () {},
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
                                                          color: Colors.white,
                                                          fontSize: 17),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.all(10.0),
                                                    onTap: () async {
                                                      Navigator.pop(context);
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
                                                        MaterialPageRoute(
                                                            builder: (context) {
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
