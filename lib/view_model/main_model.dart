import 'package:flutter/material.dart';
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

  void ChangePage(int index) {
    currentPage = index.toDouble();
    notifyListeners();
  }
}
