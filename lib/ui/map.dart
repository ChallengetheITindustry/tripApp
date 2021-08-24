import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPage createState() => _MapPage();
}

class _MapPage extends State {
  String dropdownValue = '北海道';

  bool hokkaido = true;
  @override
  Widget build(BuildContext context) {
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
              hokkaido != false
                  ? Positioned(
                      right: 2,
                      child: Container(
                        width: 180,
                        child: Image.asset('assets/images/hokkaido.png'),
                      ),
                    )
                  : Container(),
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
                      onPressed: () {
                        setState(() {
                          if (hokkaido == true) {
                            hokkaido = false;
                          } else {
                            hokkaido = true;
                          }
                        });
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
