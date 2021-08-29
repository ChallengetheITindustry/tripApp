import 'package:flutter/material.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/ui/create_trip_data.dart';

class CreatePlan extends StatefulWidget {
  @override
  _CreatePlan createState() => _CreatePlan();
}

class _CreatePlan extends State {
  String tripConcept = "";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          right: SizeConfig.blockSizeHorizontal * 50,
          top: SizeConfig.blockSizeVertical * 20,
          child: Opacity(
            opacity: 0.7,
            child: Container(
              width: SizeConfig.blockSizeHorizontal * 100,
              height: 400,
              decoration: BoxDecoration(
                //モーダル自体の色
                color: primaryColor,
                //角丸にする
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      spreadRadius: 10.0,
                      offset: Offset(5, 5))
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: SizeConfig.blockSizeVertical * 8,
          right: SizeConfig.blockSizeHorizontal * 80,
          child: Container(
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.backspace,
                size: 40,
                color: primaryColor,
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                '旅のコンセプトを決めよう',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Container(
                  width: SizeConfig.blockSizeHorizontal * 70,
                  height: SizeConfig.blockSizeVertical * 8,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        tripConcept = value;
                      });
                    },
                  )),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            Center(
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 70,
                height: SizeConfig.blockSizeVertical * 7,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () async {
                    // // ignore: await_only_futures
                    // final User user = await FirebaseAuth.instance.currentUser!;
                    // // ignore: unused_local_variable
                    // final String uid = user.uid.toString();

                    // // サブコレクション内にドキュメント作成
                    // await FirebaseFirestore.instance
                    //     .collection('users') // コレクションID
                    //     .doc(uid) // ドキュメントID << usersコレクション内のドキュメント
                    //     .collection('plan') // サブコレクションID
                    //     .add({
                    //   'concept': tripConcept,
                    // }); // データ
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateData(tripConcept)),
                    );
                  },
                  child: Text('決定',
                      style: TextStyle(
                        color: primaryColor,
                      )),
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
