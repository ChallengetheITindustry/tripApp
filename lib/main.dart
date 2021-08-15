import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/ui/login_page.dart';
import 'package:tripapp/ui/login_signup_background.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'tripApp',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0.0,
        ),
        body: Stack(children: [
          LoginPage(),
          Column(
            children: [
              Container(
                  width: 150, child: Image.asset('assets/images/airplane.png')),
              LoginPageForm(),
            ],
          )
        ]),
      ),
    );
  }
}
