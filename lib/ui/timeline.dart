import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';

import 'creata_plan.dart';
import 'map.dart';

class TimeLinePage extends StatefulWidget {
  @override
  _TimeLinePage createState() => _TimeLinePage();
}

// ignore: must_be_immutable
class _TimeLinePage extends State {
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

  Future<Null> _selectDateEnd(BuildContext context) async {
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

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), _onTimer);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: timelineBackground,
        body: Stack(
          children: [
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
                CreateTripPlan(),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 7,
                )
              ],
            ),
          ],
        ));
  }
}

class CreateTripPlan extends StatelessWidget {
  DateTime _date = new DateTime.now();

  Future<Null> _selectDateStart(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      helpText: '旅の始まりを指定',
      cancelText: 'キャンセル',
      confirmText: '次へ',
      initialDate: _date,
      firstDate: DateTime(2016),
      lastDate: DateTime.now().add(new Duration(days: 360 * 5)),
    );
    // if (picked != null) setState(() => _date = picked);
    _selectDateEnd(context);
  }

  Future<Null> _selectDateEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      helpText: '旅の終わりを指定',
      cancelText: 'キャンセル',
      confirmText: '旅を始める',
      initialDate: _date,
      firstDate: DateTime(2016),
      lastDate: DateTime.now().add(new Duration(days: 360 * 5)),
    );
    // if (picked != null) setState(() => _date = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => CreatePlan()),
                    // );
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
                                  height: SizeConfig.blockSizeHorizontal * 20,
                                ),
                                Container(
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
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: Text('旅の日記を書く',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeHorizontal * 10,
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
                                SizedBox(
                                  height: SizeConfig.blockSizeHorizontal * 10,
                                ),
                                Container(
                                  width: SizeConfig.screenWidth * 0.8,
                                  child: TextFormField(
                                    autofocus: true,
                                    decoration: InputDecoration(
                                      labelText: 'ex：過酷？青春18きっぷで日本一周の旅！',
                                      labelStyle:
                                          TextStyle(color: formBorderColor),
                                      enabledBorder: OutlineInputBorder(
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
                                  height: SizeConfig.blockSizeHorizontal * 10,
                                ),
                                Container(
                                  width: SizeConfig.screenWidth * 0.8,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: <Widget>[
                                          // ignore: unnecessary_brace_in_string_interps
                                          Text(
                                            "開始日：${_date.year}-${_date.month}-${_date.day} ~ ",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),
                                          ),
                                          Text(
                                            "終了日：${_date.year}-${_date.month}-${_date.day} ~ ",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {
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
                                  height: SizeConfig.blockSizeHorizontal * 10,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: SizeConfig.screenWidth * 0.5,
                                      height: SizeConfig.screenHeight * 0.15,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(color: Colors.white),
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
                                      height:
                                          SizeConfig.blockSizeHorizontal * 10,
                                    ),
                                    Container(
                                      width: SizeConfig.screenWidth * 0.8,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          SizeConfig.blockSizeHorizontal * 10,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        )),
                                    SizedBox(
                                      height:
                                          SizeConfig.blockSizeHorizontal * 10,
                                    ),
                                    Container(
                                      width: SizeConfig.screenWidth * 0.6,
                                      height: SizeConfig.screenHeight * 0.05,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            side: BorderSide(
                                              color: Colors.white, //枠線!
                                              width: 1, //枠線！
                                            ),
                                            primary: Colors.transparent,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            '共有する',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                    SizedBox(
                                      height:
                                          SizeConfig.blockSizeHorizontal * 10,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Container(
                                      child: Text(
                                        'いいね一覧❤️',
                                        style: TextStyle(color: Colors.white),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Container(
                                      child: Text(
                                        'たくさん日記を投稿して地図を埋めよう🚀',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.05,
                                  ),
                                  Center(
                                      child: Container(
                                          decoration: BoxDecoration(),
                                          child: Image.asset(
                                              'assets/images/2525.png'))),
                                ],
                              ),
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
    );
  }
}
