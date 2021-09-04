import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/ui/formwidget.dart';
import 'package:tripapp/ui/login_page.dart';
import 'package:tripapp/ui/login_signup_background.dart';
import 'package:tripapp/ui/signup_page.dart';
import 'package:tripapp/view_model/main_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //向き指定
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, //縦固定
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'tripApp',
      darkTheme: ThemeData.dark(),
      home: Scaffold(
          body: Stack(children: [
        Background(),
        FormWidget(),
      ])),
    );
  }
}
