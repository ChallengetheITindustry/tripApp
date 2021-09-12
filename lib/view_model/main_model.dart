import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/ui/signin_page.dart';
import 'package:tripapp/ui/signup_page.dart';

class MainModel extends ChangeNotifier {
  // 現在のページ位置
  double currentPage = 0.0;
  //ページの長さを設定
  final pageLength = 2;
// PageViewの初期ページを指定
  final PageController controller = PageController(initialPage: 0);
  //main.dartに表示させるフォーム
  List pages = [LoginPageForm(), SignupPageForm()];

  // ignore: non_constant_identifier_names
  void ChangePage(int index) {
    currentPage = index.toDouble();
    notifyListeners();
  }
}

// class UserState extends ChangeNotifier {
//   late User user;

//   void setUser(User currentUser) {
//     user = currentUser;
//     notifyListeners();
//   }

//   //ログイン状態のチェック(非同期で行う)
//   void checkUser() async {
//     final currentUser = await FirebaseAuth.instance.currentUser!;
//     if (currentUser == null) {
//     } else {
//       user.setUser(currentUser);
//       // Navigator.pushReplacementNamed(context, "/home");
//     }
//   }
// }


