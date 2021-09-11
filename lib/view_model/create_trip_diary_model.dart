import 'package:flutter/material.dart';

class CreateTripDiaryModel extends ChangeNotifier {
  String concept = '';
  String contents = '';
  String tripDocumentId = '';
  String ID = '';

  DateTime dateStart = new DateTime.now();
  DateTime dateEnd = new DateTime.now();

  Future<Null> selectDateStart(BuildContext context) async {
    final DateTime? pickedStart = await showDatePicker(
      context: context,
      helpText: '旅の始まり',
      cancelText: 'キャンセル',
      confirmText: '次へ',
      initialDate: dateStart,
      firstDate: DateTime(2016),
      lastDate: DateTime.now().add(new Duration(days: 360 * 5)),
    );

    if (pickedStart != null) {
      dateStart = pickedStart;
    }

    _selectDateEnd(context);
    notifyListeners();
  }

  Future<Null> _selectDateEnd(BuildContext context) async {
    final DateTime? pickedEnd = await showDatePicker(
      context: context,
      helpText: '旅の終わりを指定',
      cancelText: 'キャンセル',
      confirmText: '決定',
      initialDate: dateEnd,
      firstDate: DateTime(2016),
      lastDate: DateTime.now().add(new Duration(days: 360 * 5)),
    );

    if (pickedEnd != null) {
      dateEnd = pickedEnd;
    }
    notifyListeners();
  }
}
