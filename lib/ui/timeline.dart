import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';

import 'map.dart';

class TimeLinePage extends StatefulWidget {
  @override
  _TimeLinePage createState() => _TimeLinePage();
}

// ignore: must_be_immutable
class _TimeLinePage extends State {
  double _y = 0;

  void _onTap() {
    setState(() {
      _y = 600;
    });
  }

  DateTime _date = new DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      helpText: '旅の始まりを指定',
      cancelText: 'キャンセル',
      confirmText: '旅を始める',
      initialDate: _date,
      firstDate: DateTime(2016),
      lastDate: DateTime.now().add(new Duration(days: 360 * 5)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  AudioCache _player = AudioCache();
  bool sounds = false;

  late AudioPlayer changeTakibi;
  void _onTimer() {
    print('時間が経過しました！');
  }

  // ドロップダウンメニューの初期値
  String dropdownValue = '北海道';

  bool hokkaido = false;

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), _onTimer);
    return Scaffold(
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
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: SizeConfig.screenWidth,
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
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.blockSizeHorizontal *
                                                    10,
                                          ),
                                          Container(
                                            child: Text(
                                              '🚀コンセプトを決めよう🚀',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: SizeConfig.screenWidth * 0.8,
                                            child: TextFormField(
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          // Column(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.center,
                                          //   children: [
                                          //     Column(
                                          //       children: <Widget>[
                                          //         // ignore: unnecessary_brace_in_string_interps
                                          //         Center(
                                          //             child: Text(
                                          //                 "${_date.year}-${_date.month}-${_date.day}")),
                                          //       ],
                                          //     ),
                                          //     Container(
                                          //       width: MediaQuery.of(context)
                                          //               .size
                                          //               .width *
                                          //           0.5,
                                          //       child: Row(
                                          //         children: [
                                          //           Container(
                                          //             child: DropdownButton<
                                          //                 String>(
                                          //               value: dropdownValue,
                                          //               icon: const Icon(
                                          //                 Icons.arrow_downward,
                                          //                 color: primaryColor,
                                          //               ),
                                          //               iconSize: 24,
                                          //               elevation: 16,
                                          //               style: const TextStyle(
                                          //                   color:
                                          //                       primaryColor),
                                          //               underline: Container(
                                          //                 height: 2,
                                          //                 color: primaryColor,
                                          //               ),
                                          //               onChanged:
                                          //                   (String? newValue) {
                                          //                 setState(() {
                                          //                   dropdownValue =
                                          //                       newValue!;
                                          //                 });
                                          //               },
                                          //               items: <String>[
                                          //                 '北海道',
                                          //                 '青森県',
                                          //                 '岩手県',
                                          //                 '宮城県',
                                          //                 '秋田県',
                                          //                 '山形県',
                                          //                 '福島県',
                                          //                 '茨城県',
                                          //                 '栃木県',
                                          //                 '群馬県',
                                          //                 '埼玉県',
                                          //                 '千葉県',
                                          //                 '東京都',
                                          //                 '神奈川県',
                                          //                 '新潟県',
                                          //                 '富山県',
                                          //                 '石川県',
                                          //                 '福井県',
                                          //                 '山梨県',
                                          //                 '長野県',
                                          //                 '岐阜県',
                                          //                 '静岡県',
                                          //                 '愛知県',
                                          //                 '三重県',
                                          //                 '滋賀県',
                                          //                 '京都府',
                                          //                 '大阪府',
                                          //                 '兵庫県',
                                          //                 '奈良県',
                                          //                 '和歌山県',
                                          //                 '鳥取県',
                                          //                 '島根県',
                                          //                 '岡山県',
                                          //                 '広島県',
                                          //                 '山口県',
                                          //                 '徳島県',
                                          //                 '香川県',
                                          //                 '愛媛県',
                                          //                 '高知県',
                                          //                 '福岡県',
                                          //                 '佐賀県',
                                          //                 '長崎県',
                                          //                 '熊本県',
                                          //                 '大分県',
                                          //                 '宮崎県',
                                          //                 '鹿児島県',
                                          //                 '沖縄県'
                                          //               ].map<
                                          //                   DropdownMenuItem<
                                          //                       String>>((String
                                          //                   value) {
                                          //                 return DropdownMenuItem<
                                          //                     String>(
                                          //                   value: value,
                                          //                   child: Text(value),
                                          //                 );
                                          //               }).toList(),
                                          //             ),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //     FloatingActionButton(
                                          //         backgroundColor: primaryColor,
                                          //         child: Icon(Icons.timer),
                                          //         onPressed: () {
                                          //           _selectDate(context);
                                          //         }),
                                          //   ],
                                          // ),
                                        ],
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
                                          // hokkaido != true
                                          //     ? Positioned(
                                          //         top: SizeConfig
                                          //                 .blockSizeVertical *
                                          //             30.6,
                                          //         // right: SizeConfig.blockSizeHorizontal,
                                          //         left: SizeConfig
                                          //                 .blockSizeHorizontal *
                                          //             57.5,
                                          //         child: Container(
                                          //           width: SizeConfig
                                          //                   .blockSizeHorizontal *
                                          //               42,
                                          //           child: ColorFiltered(
                                          //               colorFilter:
                                          //                   ColorFilter.mode(
                                          //                       primaryColor,
                                          //                       BlendMode
                                          //                           .srcIn),
                                          //               child: Image.asset(
                                          //                   'assets/images/hokkaido.png')),
                                          //         ),
                                          //       )
                                          //     : Container(),
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.map_outlined,
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
          ],
        ));
  }
}

class _TestPage1 extends State {
  double _x = 0;
  double _y = 0;

  void _onTap() {
    setState(() {
      _x = 100;
      _y = 600;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
          width: 200,
          height: 200,
          color: Colors.blueAccent,
          duration: Duration(seconds: 10),
          transform: Matrix4.translationValues(_x, _y, 0)),
      floatingActionButton: FloatingActionButton(onPressed: _onTap),
    );
  }
}
