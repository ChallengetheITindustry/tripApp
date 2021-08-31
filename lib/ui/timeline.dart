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
  // AudioCache _player = AudioCache();
  // _player.loop('fire.mp3');

  bool sounds = false;
  @override
  Widget build(BuildContext context) {
    AudioCache _player = AudioCache();
    final play = _player.loop('fire.mp3');

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
            Positioned(
              top: SizeConfig.blockSizeVertical * 30,
              left: SizeConfig.blockSizeHorizontal * 45,
              child: Container(
                  width: SizeConfig.blockSizeHorizontal * 20,
                  child: Image.asset('assets/images/hukidashimaruleft.png')),
            ),
            Positioned(
              top: SizeConfig.blockSizeVertical * 39,
              left: SizeConfig.blockSizeHorizontal * 25,
              child: Container(
                  width: SizeConfig.blockSizeHorizontal * 20,
                  child: Image.asset('assets/images/hukidashimaruleft.png')),
            ),
            Positioned(
              top: SizeConfig.blockSizeVertical * 42,
              left: SizeConfig.blockSizeHorizontal * 55,
              child: Container(
                  width: SizeConfig.blockSizeHorizontal * 20,
                  child: Image.asset('assets/images/hukidashimaruleft.png')),
            ),
            Positioned(
              top: SizeConfig.blockSizeVertical * 27,
              left: SizeConfig.blockSizeHorizontal * 12,
              child: Container(
                  width: SizeConfig.blockSizeHorizontal * 20,
                  child: Image.asset('assets/images/hukidashimaruleft.png')),
            ),
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
                        onPressed: () {
                          setState(() async {
                            sounds = false;
                          });
                        },
                        icon: Icon(
                          Icons.volume_up_outlined,
                          size: 40,
                          color: Colors.white,
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            sounds = true;
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
                              onPressed: () {},
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
