import 'package:flutter/material.dart';
import 'package:tripapp/ui/login_page.dart';
import 'package:tripapp/ui/signup_page.dart';

class MainModel extends ChangeNotifier {
  double currentPage = 0.0;
  //ページの長さを設定
  final pageLength = 2;

  final PageController controller = PageController(initialPage: 0);

  //main.dartに表示させるリスト
  List pages = [LoginPageForm(), SignupPageForm()];

  void ChangePage(int index) {
    currentPage = index.toDouble();
    notifyListeners();
  }
}
