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

  bool hokkaido = false;
  bool aomori = false;
  bool iwate = false;
  bool miyagi = false;
  bool akita = false;
  bool yamagata = false;
  bool hukushima = false;
  bool ibaraki = false;
  bool tochigi = false;
  bool gunma = false;
  bool saitama = false;
  bool chiba = false;
  bool tokyo = false;
  bool kanagawa = false;
  bool niigata = false;
  bool toyama = false;
  bool ishikawa = false;
  bool hukui = false;
  bool yamanashi = false;
  bool nagano = false;
  bool gihu = false;
  bool shizuoka = false;
  bool aichi = false;
  bool mie = false;
  bool shiga = false;
  bool kyoto = false;
  bool osaka = false;
  bool hyogo = false;
  bool nara = false;
  bool wakayama = false;
  bool tottori = false;
  bool shimane = false;
  bool okayama = false;
  bool hiroshima = false;
  bool yamaguchi = false;
  bool tokushima = false;
  bool kagawa = false;
  bool ehime = false;
  bool kouchi = false;
  bool hukuoka = false;
  bool saga = false;
  bool nagasaki = false;
  bool kumamoto = false;
  bool oita = false;
  bool miyazaki = false;
  bool kagoshima = false;
  bool okinawa = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // コレクションIDとドキュメントIDを指定して取得

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Center(
                  child: Container(
                      decoration: BoxDecoration(),
                      child: Image.asset('assets/images/2525.png'))),

              // 北海道
              // hokkaido != false
              //     ? Positioned(
              //         // right: SizeConfig.blockSizeHorizontal,
              //         left: SizeConfig.blockSizeHorizontal * 57.5,
              //         child: Container(
              //           width: SizeConfig.blockSizeHorizontal * 42,
              //           child: ColorFiltered(
              //               colorFilter:
              //                   ColorFilter.mode(primaryColor, BlendMode.srcIn),
              //               child: Image.asset('assets/images/hokkaido.png')),
              //         ),
              //       )
              //     : Container(),
              // 青森
              // hokkaido != false
              //     ? Positioned(
              //         top: SizeConfig.blockSizeVertical * 13.2,
              //         left: SizeConfig.blockSizeHorizontal * 60.03,
              //         child: Container(
              //           width: SizeConfig.blockSizeHorizontal * 8.5,
              //           child: ColorFiltered(
              //               colorFilter:
              //                   ColorFilter.mode(primaryColor, BlendMode.srcIn),
              //               child: Image.asset('assets/images/aomori.png')),
              //         ),
              //       )
              //     : Container(),
              // // 岩手
              // hokkaido != false
              //     ? Positioned(
              //         top: SizeConfig.blockSizeVertical * 16.48,
              //         left: SizeConfig.blockSizeHorizontal * 62.2,
              //         child: Container(
              //           width: SizeConfig.blockSizeHorizontal * 10.6,
              //           child: ColorFiltered(
              //               colorFilter:
              //                   ColorFilter.mode(primaryColor, BlendMode.srcIn),
              //               child: Image.asset('assets/images/iwate.png')),
              //         ),
              //       )
              //     : Container(),
              // // 秋田
              // hokkaido != false
              //     ? Positioned(
              //         top: SizeConfig.blockSizeVertical * 16.4,
              //         left: SizeConfig.blockSizeHorizontal * 57,
              //         child: Container(
              //           width: SizeConfig.blockSizeHorizontal * 10.5,
              //           child: ColorFiltered(
              //               colorFilter:
              //                   ColorFilter.mode(primaryColor, BlendMode.srcIn),
              //               child: Image.asset('assets/images/akita.png')),
              //         ),
              //       )
              //     : Container(),
              // // 宮城
              // hokkaido != false
              //     ? Positioned(
              //         top: SizeConfig.blockSizeVertical * 20.7,
              //         left: SizeConfig.blockSizeHorizontal * 61.7,
              //         child: Container(
              //           width: SizeConfig.blockSizeHorizontal * 8,
              //           child: ColorFiltered(
              //               colorFilter:
              //                   ColorFilter.mode(primaryColor, BlendMode.srcIn),
              //               child: Image.asset('assets/images/miyagi.png')),
              //         ),
              //       )
              //     : Container(),
              // 山形
              // hokkaido != false
              //     ? Positioned(
              //         top: SizeConfig.blockSizeVertical * 20.5,
              //         left: SizeConfig.blockSizeHorizontal * 57,
              //         child: Container(
              //           width: SizeConfig.blockSizeHorizontal * 8.8,
              //           child: ColorFiltered(
              //               colorFilter:
              //                   ColorFilter.mode(primaryColor, BlendMode.srcIn),
              //               child: Image.asset('assets/images/yamagata.png')),
              //         ),
              //       )
              //     : Container(),
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
          ),
          FloatingActionButton(
              backgroundColor: timelineBackground,
              child: Icon(Icons.backspace),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
