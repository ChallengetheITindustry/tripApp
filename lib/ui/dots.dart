import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

// ignore: must_be_immutable
class Dots extends StatelessWidget {
  final _pageLength = 2;
  double _currentPosition = 0.0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: DotsIndicator(
                dotsCount: _pageLength, position: _currentPosition),
          ),
          SizedBox(
            width: double.infinity,
            height: 100,
          ),
        ],
      ),
    );
  }
}
