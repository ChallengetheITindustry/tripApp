import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';
// ignore: unused_import
import 'package:dots_indicator/dots_indicator.dart';

// ignore: must_be_immutable
class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 幅
    double width = MediaQuery.of(context).size.width;
    // 高さ
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          width: width,
          height: height * 0.4,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
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
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 150,
                child: Image.asset('assets/images/hikoki_animated.gif'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
