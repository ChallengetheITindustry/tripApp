import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripapp/res/const.dart';
import 'package:video_player/video_player.dart';

class TimeLinePage extends StatefulWidget {
  @override
  _TimeLinePage createState() => _TimeLinePage();
}

// ignore: must_be_immutable
class _TimeLinePage extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: timelineBackground,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 100,
              child: Text(
                '旅を共有しよう',
                style: GoogleFonts.lobster(
                    color: Colors.white,
                    fontSize: 20,
                    textStyle: Theme.of(context).textTheme.headline4),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Image.asset(
                //   'assets/images/kirakira.png',
                // ),
                Image.asset('assets/images/tamariba.png'),
              ],
            ),
          ],
        ));
  }
}
