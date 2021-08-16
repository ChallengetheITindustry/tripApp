import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/ui/dots.dart';
import 'package:tripapp/ui/login_page.dart';
import 'package:tripapp/ui/login_signup_background.dart';
import 'package:tripapp/ui/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  //向き指定
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, //縦固定
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State {
  final PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'tripApp',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0.0,
        ),
        body: Stack(children: [
          Dots(),
          Background(),
          PageView(controller: controller, children: [
            LoginPageForm(),
            SignupPageForm(),
          ]),
        ]),
      ),
    );
  }
}
