import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConfigPageModel extends ChangeNotifier {
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
