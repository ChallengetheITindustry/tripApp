import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class MailPasswordResetModel extends ChangeNotifier {
  String mail = '';

  final FirebaseAuth auth = FirebaseAuth.instance;
}
