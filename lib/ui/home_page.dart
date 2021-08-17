import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/ui/login_page.dart';
import 'package:tripapp/ui/signup_page.dart';
import 'package:tripapp/ui/user_profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _currentIndex = 0;
  final items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'ホーム',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.timeline),
      label: 'タイムライン',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.manage_accounts),
      label: 'ユーザー',
    ),
  ];
  final tabs = <Widget>[SignupPageForm(), LoginPageForm(), UserProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          IndexedStack(
            index: _currentIndex,
            children: tabs,
          ),
        ],
      ),
      bottomNavigationBar: _buildBttomNavigator(context),
    );
  }

// ボトムナビゲーションの型
  Widget _buildBttomNavigator(BuildContext context) {
    return BottomNavigationBar(
      items: items,
      fixedColor: primaryColor,
      currentIndex: _currentIndex,
      onTap: (index) {
        if (_currentIndex != index) {
          setState(() {
            _currentIndex = index;
          });
        }
      },
    );
  }
}
