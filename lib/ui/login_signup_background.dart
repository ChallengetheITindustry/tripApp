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
    // 幅
    double width = MediaQuery.of(context).size.width;
    // 高さ
    double height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          bottom: 0,
          child: Container(
            width: width,
            height: height * 0.6,
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
        // Positioned(
        //   left: SizeConfig.blockSizeHorizontal * 1,
        //   child: Container(
        //     width: 300,
        //     height: 300,
        //     decoration: const BoxDecoration(
        //       shape: BoxShape.circle,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        Positioned(
          top: 50,
          child: Column(
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal * 60,
                child: Image.asset('assets/images/top_image2.png'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
