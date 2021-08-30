import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/ui/login_page.dart';
import 'package:tripapp/ui/login_signup_background.dart';
import 'package:tripapp/ui/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  final PageController _controller = PageController(initialPage: 0);

  // ignore: unused_field
  // この定数で現在どこのフォームにいるかを取得してdot_indicatorに伝えている
  double _currentPage = 0;

//ページの長さを設定
  final _pageLength = 2;

//main.dartに表示させるリスト
  List _pages = [LoginPageForm(), SignupPageForm()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'tripApp',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: Stack(children: [
          Background(),
          PageView.builder(
              itemCount: _pages.length,
              controller: _controller,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index.toDouble();
                });
              },
              itemBuilder: (context, index) {
                return _pages[index];
              }),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Container(
                    child: DotsIndicator(
                      dotsCount: _pageLength,
                      position: _currentPage,
                      decorator: DotsDecorator(
                        activeColor: Colors.white,
                        activeSize: const Size(15.0, 15.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
