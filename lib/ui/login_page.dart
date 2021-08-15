import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 幅
    double width = MediaQuery.of(context).size.width;
    // 高さ
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        width: width,
        height: height * 0.4,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            )),
      ),
    );
  }
}

class LoginPageForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 幅
    double width = MediaQuery.of(context).size.width;
    // 高さ
    double height = MediaQuery.of(context).size.height;
    return Align(
      //Containerを真ん中に配置する場合、Alignウィジットで囲い、aligment: Aligment.centerと記述する
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                spreadRadius: 1.0,
                offset: Offset(10, 10))
          ],
        ),
        width: width * 0.8,
        height: height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(width: width, height: height * 0.1),
            Container(
              width: width * 0.6,
              height: height * 0.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("MAIL"),
                  TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: formBorderColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("PASSWORD"),
                  TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: formBorderColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                width: width * 0.6,
                height: 50,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                        offset: Offset(10, 10))
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('ログインする'),
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
