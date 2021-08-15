import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:tripapp/res/const.dart';

// ignore: must_be_immutable
class Dots extends StatelessWidget {
  final _pageLength = 2;
  double _currentPosition = 0;
  @override
  Widget build(BuildContext context) {
    // 幅
    double width = MediaQuery.of(context).size.width;
    // 高さ
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: DotsIndicator(
              dotsCount: _pageLength,
              position: _currentPosition,
              decorator: DotsDecorator(
                activeColor: primaryColor,
              ),
            ),
          ),
          SizedBox(
            width: width,
            height: height * 0.1,
          ),
        ],
      ),
    );
  }
}
