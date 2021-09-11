import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MailPasswordResetModel extends ChangeNotifier {
  String mail = '';
    final AuthService _auth = AuthService(); 
  final _formGlobalKey = GlobalKey();

    final FirebaseAuth auth = FirebaseAuth.instance;

  Future sendPasswordResetEmail(String mail) async {
    try {
      await auth.sendPasswordResetEmail(email: mail);
      return 'success';
    } catch (error) {
      return error.code;
    }
  }

       if (_formGlobalKey.currentState.validate()) {

          String _result = await _auth.sendPasswordResetEmail(_email);

          // 成功時は戻る
          if (_result == 'success') {
            Navigator.pop(context);
          } else if (_result == 'ERROR_INVALID_EMAIL') {
            Flushbar(
              message: "無効なメールアドレスです",
              backgroundColor: Colors.red,
              margin: EdgeInsets.all(8),
              borderRadius: 8,
              duration: Duration(seconds: 3),
            )..show(context);
          } else if (_result == 'ERROR_USER_NOT_FOUND') {
            Flushbar(
              message: "メールアドレスが登録されていません",
              backgroundColor: Colors.red,
              margin: EdgeInsets.all(8),
              borderRadius: 8,
              duration: Duration(seconds: 3),
            )..show(context);
          } else {
            Flushbar(
              message: "メール送信に失敗しました",
              backgroundColor: Colors.red,
              margin: EdgeInsets.all(8),
              borderRadius: 8,
              duration: Duration(seconds: 3),
            )..show(context);
          }
        }
}
