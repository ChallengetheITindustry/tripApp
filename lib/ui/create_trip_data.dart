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
      helpText: '旅の始まりを指定',
      cancelText: 'キャンセル',
      confirmText: '旅を始める',
      initialDate: _date,
      firstDate: DateTime(2016),
      lastDate: DateTime.now().add(new Duration(days: 360 * 5)),
    );
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
              // ignore: unnecessary_brace_in_string_interps
              Center(child: Text("${_date.year}-${_date.month}-${_date.day}")),
            ],
          ),
          FloatingActionButton(
              backgroundColor: primaryColor,
              child: Icon(Icons.timer),
              onPressed: () {
                _selectDate(context);
              }),
        ],
      ),
    ));
  }
}
