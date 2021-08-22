import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tripapp/main.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/ui/privacy.dart';
import 'package:tripapp/ui/rule.dart';
import 'package:tripapp/ui/tourist_spot.dart';
import 'package:url_launcher/url_launcher.dart';

class UserEditInfo extends StatefulWidget {
  @override
  _UserEditInfo createState() => _UserEditInfo();
}

class _UserEditInfo extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Text('テストです'),
    ));
  }
}
