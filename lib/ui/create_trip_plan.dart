import 'package:flutter/material.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/ui/tourist_spot.dart';

import 'map.dart';

class CreateTripPlan extends StatelessWidget {
  final controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final width = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        Background(),
        Positioned(
          top: SizeConfig.blockSizeVertical * 8,
          left: SizeConfig.blockSizeHorizontal * 80,
          child: Container(
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage()),
                );
              },
              icon: Icon(
                Icons.map_outlined,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 20,
            ),
            Center(
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 70,
                height: SizeConfig.blockSizeVertical * 8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TouristSpot()),
                    );
                  },
                  child: Text('旅に出る',
                      style: TextStyle(
                        color: primaryColor,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            Center(
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 70,
                height: SizeConfig.blockSizeVertical * 8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TouristSpot()),
                    );
                  },
                  child: Text('目的地を探す',
                      style: TextStyle(
                        color: primaryColor,
                      )),
                ),
              ),
            ),
            Spacer(),
          ],
        )
      ],
    ));
  }
}

// ignore: must_be_immutable
class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: [
        Positioned(
          right: SizeConfig.blockSizeHorizontal * -50,
          top: SizeConfig.blockSizeVertical * -20,
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            height: 400,
            decoration: BoxDecoration(
              //モーダル自体の色
              color: primaryColor,
              //角丸にする
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    spreadRadius: 10.0,
                    offset: Offset(-5, 5))
              ],
            ),
          ),
        ),
        Positioned(
          right: SizeConfig.blockSizeHorizontal * 50,
          top: SizeConfig.blockSizeVertical * 20,
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            height: 400,
            decoration: BoxDecoration(
              //モーダル自体の色
              color: primaryColor,
              //角丸にする
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    spreadRadius: 10.0,
                    offset: Offset(5, 5))
              ],
            ),
          ),
        ),
        Positioned(
          right: SizeConfig.blockSizeHorizontal * -50,
          top: SizeConfig.blockSizeVertical * 40,
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            height: 400,
            decoration: BoxDecoration(
              //モーダル自体の色
              color: primaryColor,
              //角丸にする
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    spreadRadius: 10.0,
                    offset: Offset(-5, -5))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
