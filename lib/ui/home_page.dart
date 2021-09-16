import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  AnimationController? _animationController;
  Animation<Alignment>? _alignment;

  bool opa = true;
  bool opa1 = true;

  void startTimer() {
    Timer.periodic(
      Duration(seconds: 7), //９:1秒ごとに処理
      (Timer timer) => setState(
        () {
          if (opa == true) {
            opa = false;
          } else {
            opa = true;
          }
        },
      ),
    );
    Timer.periodic(
      Duration(seconds: 1), //９:1秒ごとに処理
      (Timer timer) => setState(
        () {
          if (opa1 == true) {
            opa1 = false;
          } else {
            opa1 = true;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
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
                // Positioned(
                //     top: SizeConfig.blockSizeVertical * 50,
                //     left: SizeConfig.blockSizeHorizontal * 20,
                //     child: Container(
                //         width: SizeConfig.screenWidth * 0.2,
                //         child: AnimatedOpacity(
                //           opacity: opa == false ? 0 : 1,
                //           duration: const Duration(milliseconds: 12000),
                //           child: InkWell(
                //               onTap: () {
                //                 showModalBottomSheet(
                //                     //モーダルの背景の色、透過
                //                     backgroundColor: Colors.transparent,
                //                     //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                //                     isScrollControlled: true,
                //                     context: context,
                //                     builder: (BuildContext context) {
                //                       return Column(
                //                         children: [
                //                           SizedBox(
                //                             height:
                //                                 SizeConfig.blockSizeVertical *
                //                                     7,
                //                           ),
                //                           Container(
                //                             width: SizeConfig.screenWidth * 0.8,
                //                             decoration: BoxDecoration(
                //                               border: const Border(
                //                                 bottom: const BorderSide(
                //                                   color: Colors.white,
                //                                   width: 1,
                //                                 ),
                //                               ),
                //                             ),
                //                             child: Padding(
                //                               padding: const EdgeInsets.only(
                //                                   bottom: 8.0),
                //                               child: Text(
                //                                 'One Trip',
                //                                 textAlign: TextAlign.center,
                //                                 style: TextStyle(
                //                                     color: Colors.white,
                //                                     fontSize: 15,
                //                                     fontWeight:
                //                                         FontWeight.bold),
                //                               ),
                //                             ),
                //                           ),
                //                         ],
                //                       );
                //                     });
                //               },
                //               child:
                //                   Image.asset('assets/images/hukidashi.png')),
                //         ))),
                // Positioned(
                //     top: SizeConfig.blockSizeVertical * 50,
                //     right: SizeConfig.blockSizeHorizontal * 20,
                //     child: Container(
                //         width: SizeConfig.screenWidth * 0.2,
                //         child: AnimatedOpacity(
                //           opacity: opa == false ? 0 : 1,
                //           duration: const Duration(milliseconds: 6000),
                //           child: InkWell(
                //               onTap: () {
                //                 showModalBottomSheet(
                //                     //モーダルの背景の色、透過
                //                     backgroundColor: Colors.transparent,
                //                     //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                //                     isScrollControlled: true,
                //                     context: context,
                //                     builder: (BuildContext context) {
                //                       return Column(
                //                         children: [
                //                           SizedBox(
                //                             height:
                //                                 SizeConfig.blockSizeVertical *
                //                                     7,
                //                           ),
                //                           Container(
                //                             width: SizeConfig.screenWidth * 0.8,
                //                             decoration: BoxDecoration(
                //                               border: const Border(
                //                                 bottom: const BorderSide(
                //                                   color: Colors.white,
                //                                   width: 1,
                //                                 ),
                //                               ),
                //                             ),
                //                             child: Padding(
                //                               padding: const EdgeInsets.only(
                //                                   bottom: 8.0),
                //                               child: Text(
                //                                 'One Trip',
                //                                 textAlign: TextAlign.center,
                //                                 style: TextStyle(
                //                                     color: Colors.white,
                //                                     fontSize: 15,
                //                                     fontWeight:
                //                                         FontWeight.bold),
                //                               ),
                //                             ),
                //                           ),
                //                         ],
                //                       );
                //                     });
                //               },
                //               child:
                //                   Image.asset('assets/images/hukidashi.png')),
                //         ))),
                // Positioned(
                //     top: SizeConfig.blockSizeVertical * 30,
                //     left: SizeConfig.blockSizeHorizontal * 20,
                //     child: Container(
                //         width: SizeConfig.screenWidth * 0.2,
                //         child: AnimatedOpacity(
                //           opacity: opa == false ? 0 : 1,
                //           duration: const Duration(milliseconds: 9000),
                //           child: InkWell(
                //               onTap: () {
                //                 showModalBottomSheet(
                //                     //モーダルの背景の色、透過
                //                     backgroundColor: Colors.transparent,
                //                     //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                //                     isScrollControlled: true,
                //                     context: context,
                //                     builder: (BuildContext context) {
                //                       return Column(
                //                         children: [
                //                           SizedBox(
                //                             height:
                //                                 SizeConfig.blockSizeVertical *
                //                                     7,
                //                           ),
                //                           Container(
                //                             width: SizeConfig.screenWidth * 0.8,
                //                             decoration: BoxDecoration(
                //                               border: const Border(
                //                                 bottom: const BorderSide(
                //                                   color: Colors.white,
                //                                   width: 1,
                //                                 ),
                //                               ),
                //                             ),
                //                             child: Padding(
                //                               padding: const EdgeInsets.only(
                //                                   bottom: 8.0),
                //                               child: Text(
                //                                 'One Trip',
                //                                 textAlign: TextAlign.center,
                //                                 style: TextStyle(
                //                                     color: Colors.white,
                //                                     fontSize: 15,
                //                                     fontWeight:
                //                                         FontWeight.bold),
                //                               ),
                //                             ),
                //                           ),
                //                         ],
                //                       );
                //                     });
                //               },
                //               child:
                //                   Image.asset('assets/images/hukidashi.png')),
                //         ))),
                // Positioned(
                //     top: SizeConfig.blockSizeVertical * 30,
                //     right: SizeConfig.blockSizeHorizontal * 20,
                //     child: Container(
                //         width: SizeConfig.screenWidth * 0.2,
                //         child: AnimatedOpacity(
                //           opacity: opa == false ? 0 : 1,
                //           duration: const Duration(milliseconds: 15000),
                //           child: InkWell(
                //               onTap: () {
                //                 showModalBottomSheet(
                //                     //モーダルの背景の色、透過
                //                     backgroundColor: Colors.transparent,
                //                     //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                //                     isScrollControlled: true,
                //                     context: context,
                //                     builder: (BuildContext context) {
                //                       return Column(
                //                         children: [
                //                           SizedBox(
                //                             height:
                //                                 SizeConfig.blockSizeVertical *
                //                                     7,
                //                           ),
                //                           Container(
                //                             width: SizeConfig.screenWidth * 0.8,
                //                             decoration: BoxDecoration(
                //                               border: const Border(
                //                                 bottom: const BorderSide(
                //                                   color: Colors.white,
                //                                   width: 1,
                //                                 ),
                //                               ),
                //                             ),
                //                             child: Padding(
                //                               padding: const EdgeInsets.only(
                //                                   bottom: 8.0),
                //                               child: Text(
                //                                 'One Trip',
                //                                 textAlign: TextAlign.center,
                //                                 style: TextStyle(
                //                                     color: Colors.white,
                //                                     fontSize: 15,
                //                                     fontWeight:
                //                                         FontWeight.bold),
                //                               ),
                //                             ),
                //                           ),
                //                         ],
                //                       );
                //                     });
                //               },
                //               child:
                //                   Image.asset('assets/images/hukidashi.png')),
                //         ))),

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

                Center(
                  child: Container(
                      width: SizeConfig.screenWidth * 0.6,
                      child: AnimatedOpacity(
                        opacity: opa == false ? 0 : 1,
                        duration: const Duration(milliseconds: 3000),
                        child: Container(
                            child: InkWell(
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
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      7,
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
                                                    bottom: 8.0),
                                                child: Text(
                                                  'One Trip',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Image.asset(
                                    'assets/images/hukidashi.png'))),
                      )),
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
