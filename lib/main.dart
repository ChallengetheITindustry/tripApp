import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/ui/login_page.dart';

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
        body: Stack(children: [LoginPage(), LoginPageForm()]),
      ),
    );
  }
}
