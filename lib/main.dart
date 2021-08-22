import 'package:dots_indicator/dots_indicator.dart';
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
  MyAppPage createState() => MyAppPage();
}

class MyAppPage extends State {
  final PageController _controller = PageController(initialPage: 0);

  // ignore: unused_field
  double _currentPage = 0;

  final _pageLength = 2;
  // main.dartファイルの_currentPageを参照し、これが変わることによってアクティブなdotが変更される

  List _pages = [LoginPageForm(), SignupPageForm()];
  @override
  Widget build(BuildContext context) {
    // 幅
    double width = MediaQuery.of(context).size.width;
    // 高さ
    double height = MediaQuery.of(context).size.height;
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: DotsIndicator(
                    dotsCount: _pageLength,
                    position: _currentPage,
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
          ),
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
        ]),
      ),
    );
  }
}
