import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/ui/form_widget.dart';
import 'package:tripapp/ui/background_widget.dart';
import 'package:tripapp/ui/home_page.dart';

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
  final UserState user = UserState();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserState>.value(
      value: user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'tripApp',
        darkTheme: ThemeData.dark(),
        home: LoginCheck(),
      ),
    );
  }
}

class LoginCheck extends StatefulWidget {
  @override
  _LoginCheckState createState() => _LoginCheckState();
}

class _LoginCheckState extends State {
  //ログイン状態のチェック(非同期で行う)
  void checkUser() async {
    final currentUser = await FirebaseAuth.instance.currentUser!;
    final userState = Provider.of<UserState>(context, listen: false);
    // ignore: unnecessary_null_comparison
    if (currentUser == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignInUpPage()),
      );
      print('ログイン画面に遷移しました');
    } else {
      userState.setUser(currentUser);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      print('ホーム画面に遷移しました。');
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Loading..."),
        ),
      ),
    );
  }
}

class UserState extends ChangeNotifier {
  late User user;
  void setUser(User currentUser) {
    user = currentUser;
    notifyListeners();
  }
}

class SignInUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Background(),
      FormWidget(),
    ]));
  }
}
