import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';

import 'map.dart';

class CreateTripPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 2.0,
          title: Text('ホーム'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapPage()),
                  );
                },
                icon: Icon(Icons.map))
          ],
        ),
        body: Center(
          child: Container(
            width: width * 0.8,
            child: Column(
              children: [
                Row(
                  children: [Container(), Spacer(), Container()],
                ),
              ],
            ),
          ),
        ));
  }
}
