// リファクタリング済

import 'package:flutter/material.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';
// ignore: unused_import
import 'package:dots_indicator/dots_indicator.dart';

// ignore: must_be_immutable
class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          bottom: 0,
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight * 0.55,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                    offset: Offset(10, 10))
              ],
            ),
          ),
        ),
        Positioned(
          top: 40,
          child: Column(
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal * 70,
                child: Image.asset('assets/images/top_image2.png'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
