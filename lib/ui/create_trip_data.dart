import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';

class CreateData extends StatefulWidget {
  CreateData(this.tripConcept);
  String tripConcept;

  @override
  _CreateData createState() => _CreateData(tripConcept);
}

class _CreateData extends State {
  _CreateData(this.tripConcept);
  String tripConcept;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Center(
      child: Container(
        child: Text(tripConcept),
      ),
    ));
  }
}
