import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPage createState() => _MapPage();
}

class _MapPage extends State {
  // ドロップダウンメニューの初期値
  String dropdownValue = '北海道';

  bool hokkaido = true;
  bool aomori = true;
  bool iwate = true;
  bool miyagi = true;
  bool akita = true;
  bool yamagata = true;
  bool hukushima = true;
  bool ibaraki = true;
  bool tochigi = true;
  bool gunma = true;
  bool saitama = true;
  bool chiba = true;
  bool tokyo = true;
  bool kanagawa = true;
  bool niigata = true;
  bool toyama = true;
  bool ishikawa = true;
  bool hukui = true;
  bool yamanashi = true;
  bool nagano = true;
  bool gihu = true;
  bool shizuoka = true;
  bool aichi = true;
  bool mie = true;
  bool shiga = true;
  bool kyoto = true;
  bool osaka = true;
  bool hyogo = true;
  bool nara = true;
  bool wakayama = true;
  bool tottori = true;
  bool shimane = true;
  bool okayama = true;
  bool hiroshima = true;
  bool yamaguchi = true;
  bool tokushima = true;
  bool kagawa = true;
  bool ehime = true;
  bool kouchi = true;
  bool hukuoka = true;
  bool saga = true;
  bool nagasaki = true;
  bool kumamoto = true;
  bool oita = true;
  bool miyazaki = true;
  bool kagoshima = true;
  bool okinawa = true;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // コレクションIDとドキュメントIDを指定して取得
    final document = FirebaseFirestore.instance
        .collection('users')
        .doc('apZW1DX21tOAuxF4m3nNeOARl623')
        .collection('prefecture')
        .doc('qGDMEWLapCPGoTR78CIk')
        .get();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 2.0,
        title: Text('地図'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Center(
                  child:
                      Container(child: Image.asset('assets/images/2525.png'))),
              // 北海道
              hokkaido != false
                  ? Positioned(
                      // right: SizeConfig.blockSizeHorizontal,
                      left: SizeConfig.blockSizeHorizontal * 57.5,
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 42,
                        child: ColorFiltered(
                            colorFilter:
                                ColorFilter.mode(primaryColor, BlendMode.srcIn),
                            child: Image.asset('assets/images/hokkaido.png')),
                      ),
                    )
                  : Container(),
              // 青森
              // Positioned(
              //   top: SizeConfig.blockSizeVertical * 13.2,
              //   left: SizeConfig.blockSizeHorizontal * 60,
              //   child: Container(
              //     width: SizeConfig.blockSizeHorizontal * 8.5,
              //     child: Image.asset('assets/images/aomori.png'),
              //   ),
              // ),
              // // 岩手
              // Positioned(
              //   top: SizeConfig.blockSizeVertical * 16.5,
              //   left: SizeConfig.blockSizeHorizontal * 62,
              //   child: Container(
              //     width: SizeConfig.blockSizeHorizontal * 10.5,
              //     child: Image.asset('assets/images/iwate.png'),
              //   ),
              // )
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Row(
              children: [
                Container(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(
                      Icons.arrow_downward,
                      color: primaryColor,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: primaryColor),
                    underline: Container(
                      height: 2,
                      color: primaryColor,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>[
                      '北海道',
                      '青森県',
                      '岩手県',
                      '宮城県',
                      '秋田県',
                      '山形県',
                      '福島県',
                      '茨城県',
                      '栃木県',
                      '群馬県',
                      '埼玉県',
                      '千葉県',
                      '東京都',
                      '神奈川県',
                      '新潟県',
                      '富山県',
                      '石川県',
                      '福井県',
                      '山梨県',
                      '長野県',
                      '岐阜県',
                      '静岡県',
                      '愛知県',
                      '三重県',
                      '滋賀県',
                      '京都府',
                      '大阪府',
                      '兵庫県',
                      '奈良県',
                      '和歌山県',
                      '鳥取県',
                      '島根県',
                      '岡山県',
                      '広島県',
                      '山口県',
                      '徳島県',
                      '香川県',
                      '愛媛県',
                      '高知県',
                      '福岡県',
                      '佐賀県',
                      '長崎県',
                      '熊本県',
                      '大分県',
                      '宮崎県',
                      '鹿児島県',
                      '沖縄県'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Spacer(),
                Container(
                  child: TextButton(
                      onPressed: () async {
                        setState(() {
                          if (hokkaido == true) {
                            hokkaido = false;
                          } else {
                            hokkaido = true;
                          }
                        });
                        // // ignore: await_only_futures
                        // final User user =
                        //     await FirebaseAuth.instance.currentUser!;
                        // // ignore: unused_local_variable
                        // final String uid = user.uid.toString();
                        // // サブコレクション内にドキュメント作成
                        // await FirebaseFirestore.instance
                        //     .collection('users') // コレクションID
                        //     .doc(uid) // ドキュメントID << usersコレクション内のドキュメント
                        //     .collection('prefecture') // サブコレクションID
                        //     .doc(
                        //         'qGDMEWLapCPGoTR78CIk') // ドキュメントID << サブコレクション内のドキュメント
                        //     .update({'hokkaido': true});
                      },
                      child: Text('保存')),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
