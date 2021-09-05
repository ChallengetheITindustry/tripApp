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

  bool sounds = true;
  @override
  Widget build(BuildContext context) {
    AudioCache _player = AudioCache();
    _player.loop('fire.mp3');
    SizeConfig().init(context);
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
            // Positioned(
            //   top: SizeConfig.blockSizeVertical * 30,
            //   left: SizeConfig.blockSizeHorizontal * 45,
            //   child: Container(
            //       width: SizeConfig.blockSizeHorizontal * 20,
            //       child: Image.asset('assets/images/hukidashimaruleft.png')),
            // ),
            // Positioned(
            //   top: SizeConfig.blockSizeVertical * 39,
            //   left: SizeConfig.blockSizeHorizontal * 25,
            //   child: Container(
            //       width: SizeConfig.blockSizeHorizontal * 20,
            //       child: Image.asset('assets/images/hukidashimaruleft.png')),
            // ),

            Positioned(
              top: SizeConfig.blockSizeVertical * 42,
              left: SizeConfig.blockSizeHorizontal * 55,
              child: InkWell(
                onTap: () {},
                child: Container(
                    width: SizeConfig.blockSizeHorizontal * 20,
                    child: Image.asset('assets/images/hukidashimaruleft.png')),
              ),
            ),
            // Positioned(
            //   top: SizeConfig.blockSizeVertical * 27,
            //   left: SizeConfig.blockSizeHorizontal * 12,
            //   child: Container(
            //       width: SizeConfig.blockSizeHorizontal * 20,
            //       child: Image.asset('assets/images/hukidashimaruleft.png')),
            // ),
            // ListView.builder(
            //   itemCount: list.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     return Container(
            //       height: SizeConfig.blockSizeVertical * 8,
            //       child: Card(child: ListTile(leading: Text(list[index]))),
            //     );
            //   },
            // ),
            Positioned(
              top: SizeConfig.blockSizeVertical * 8,
              right: SizeConfig.blockSizeHorizontal * 80,
              child: Container(
                child: sounds != false
                    ? IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.volume_up_outlined,
                          size: 40,
                          color: Colors.white,
                        ),
                      )
                    : IconButton(
                        onPressed: () {},
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
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) {
                                    return AlertDialog(
                                      backgroundColor: Colors.transparent,
                                      title: Text(
                                        "タイトル",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: Text(
                                        "ここにユーザーさんの旅の計画を表示します。",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.transparent,
                                          ),
                                          child: Text(
                                            "閉じる",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.chat_bubble_outline,
                                size: 30,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite_border_outlined,
                                size: 30,
                              )),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MapPage()),
                                );
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
