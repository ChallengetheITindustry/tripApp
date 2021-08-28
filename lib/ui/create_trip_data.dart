import 'package:flutter/material.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';

// ignore: must_be_immutable
class CreateData extends StatefulWidget {
  CreateData(this.tripConcept);
  String tripConcept;
  @override
  _CreateData createState() => _CreateData(tripConcept);
}

class _CreateData extends State {
  _CreateData(this.tripConcept);
  String tripConcept;

  DateTime _date = new DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2016),
        lastDate: DateTime.now().add(new Duration(days: 360)));
    if (picked != null) setState(() => _date = picked);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: <Widget>[
              Center(child: Text("${_date}")),
            ],
          ),
          FloatingActionButton(
              backgroundColor: primaryColor,
              child: Icon(Icons.timer),
              onPressed: () {
                _selectDate(context);
              })
        ],
      ),
    ));
  }
}
