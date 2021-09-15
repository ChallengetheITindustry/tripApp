import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/ui/user_profile.dart';
import 'package:tripapp/view_model/home_model.dart';
import 'dart:core';
import 'configuration.dart';
import 'create_trip_plan.dart';
import 'favorite_diary.dart';
import 'package:speech_balloon/speech_balloon.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

// ignore: must_be_immutable
class _HomePage extends State with SingleTickerProviderStateMixin {
  bool opaque = false;

  AnimationController? _animationController;
  Animation<Alignment>? _alignment;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _alignment = _animationController!.drive(
      AlignmentTween(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(
      create: (_) => HomeModel(),
      child: Consumer<HomeModel>(builder: (context, model, child) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: timelineBackground,
            body: Stack(
              children: [
                // 月の画像
                Container(child: Image.asset('assets/images/moon.png')),
                // 中央の文言
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
                // AlignTransition(
                //   alignment: _alignment!,
                //   child: Container(
                //     width: 100,
                //     height: 100,
                //     color: Colors.blue,
                //   ),
                // ),
                // Positioned(
                //   top: SizeConfig.blockSizeVertical * 45,
                //   right: SizeConfig.blockSizeHorizontal * 10,
                //   child: AnimatedOpacity(
                //     opacity: opaque != false ? 1 : 0,
                //     duration: const Duration(milliseconds: 5000),
                //     child: SpeechBalloon(
                //       nipLocation: NipLocation.bottom,
                //       color: Colors.red,
                //       child: InkWell(
                //         onTap: () {
                //           showModalBottomSheet(
                //               //モーダルの背景の色、透過
                //               backgroundColor: Colors.transparent,
                //               //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                //               isScrollControlled: true,
                //               context: context,
                //               builder: (BuildContext context) {
                //                 return Column(
                //                   children: [
                //                     SizedBox(
                //                       height: SizeConfig.screenHeight * 0.15,
                //                     ),
                //                     SizedBox(
                //                       height: SizeConfig.screenHeight * 0.03,
                //                     ),
                //                     Container(
                //                         decoration: BoxDecoration(
                //                           boxShadow: [
                //                             BoxShadow(
                //                                 color: Colors.black12,
                //                                 spreadRadius: 0,
                //                                 offset: Offset(15, 15))
                //                           ],
                //                         ),
                //                         child: Text(
                //                           // ログインユーザーの名前を表示
                //                           '',
                //                           style: TextStyle(
                //                             fontSize: 30,
                //                             fontWeight: FontWeight.bold,
                //                             color: Colors.white,
                //                           ),
                //                         )),
                //                     SizedBox(
                //                       height: SizeConfig.screenHeight * 0.02,
                //                     ),
                //                     Container(
                //                       child: Text(
                //                         '',
                //                         // ログインユーザーのメールアドレスを表示

                //                         style: TextStyle(
                //                           color: Colors.white,
                //                         ),
                //                       ),
                //                     ),
                //                     SizedBox(
                //                       height: SizeConfig.screenHeight * 0.02,
                //                     ),
                //                     Container(
                //                         child: Text(
                //                       '投稿数',
                //                       style: TextStyle(
                //                           color: Colors.white, fontSize: 20),
                //                     )),
                //                   ],
                //                 );
                //               });
                //         },
                //         child: Icon(
                //           Icons.favorite,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                // 溜まり場画像
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
                          // 中央下のボタン一覧
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              createTripDiary(),
                              FavoriteDiary(),
                              UserProfilePage(),
                              ConfigPage(),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 7,
                    )
                  ],
                ),
                // BGMのオン/オフを切り替えるアイコンボタン
                Positioned(
                  top: SizeConfig.blockSizeVertical * 8,
                  right: SizeConfig.blockSizeHorizontal * 80,
                  child: Container(
                    child: model.sounds != false
                        ? IconButton(
                            onPressed: () async {
                              await model.stopSound();
                            },
                            icon: Icon(
                              Icons.volume_up_outlined,
                              size: 40,
                              color: Colors.white,
                            ),
                          )
                        : IconButton(
                            onPressed: () async {
                              await model.startSound();
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
      }),
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
}
