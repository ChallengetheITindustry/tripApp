import 'package:flutter/material.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/ui/tourist_spot.dart';

class PrefecturePage extends StatelessWidget {
  final listItem = [
    "北海道",
    "青森県",
    "岩手県",
    "宮城県",
    "秋田県",
    "山形県",
    "福島県",
    "茨城県",
    "栃木県",
    "群馬県",
    "埼玉県",
    "千葉県",
    "東京都",
    "神奈川県",
    "新潟県",
    "富山県",
    "石川県",
    "福井県",
    "山梨県",
    "長野県",
    "岐阜県",
    "静岡県",
    "愛知県",
    "三重県",
    "滋賀県",
    "京都府",
    "大阪府",
    "兵庫県",
    "奈良県",
    "和歌山県",
    "鳥取県",
    "島根県",
    "岡山県",
    "広島県",
    "山口県",
    "徳島県",
    "香川県",
    "愛媛県",
    "高知県",
    "福岡県",
    "佐賀県",
    "長崎県",
    "熊本県",
    "大分県",
    "宮崎県",
    "鹿児島県",
    "沖縄県",
  ];

  // final listImage = [
  //   "assets/images/hokkaido.jpeg",
  //   "assets/images/aomori.jpeg",
  //   "assets/images/iwate.jpeg",
  //   "assets/images/miyagi.jpeg",
  //   "assets/images/akita.jpeg",
  //   "assets/images/yamagata.jpeg",
  //   "assets/images/hukushima.jpeg",
  //   "assets/images/ibaraki.jpeg",
  //   "assets/images/tochigi.jpeg",
  //   "assets/images/gunma.jpeg",
  //   "assets/images/saitama.jpeg",
  //   "assets/images/chiba.jpeg",
  //   "assets/images/tokyo.jpeg",
  //   "assets/images/kanagawa.jpeg",
  //   "assets/images/niigata.jpeg",
  //   "assets/images/toyama.jpeg",
  //   "assets/images/ishikawa.jpeg",
  //   "assets/images/fukui.jpeg",
  //   "assets/images/yamanashi.jpeg",
  //   "assets/images/nagano.jpeg",
  //   "assets/images/gihu.jpeg",
  //   "assets/images/shizuoka.jpeg",
  //   "assets/images/aichi.jpeg",
  //   "assets/images/mie.jpeg",
  //   "assets/images/shiga.jpeg",
  //   "assets/images/kyoto.jpeg",
  //   "assets/images/osaka.jpeg",
  //   "assets/images/hyogo.jpeg",
  //   "assets/images/nara.jpeg",
  //   "assets/images/wakayama.jpeg",
  //   "assets/images/tottori.jpeg",
  //   "assets/images/shimane.jpeg",
  //   "assets/images/okayama.jpeg",
  //   "assets/images/hiroshima.jpeg",
  //   "assets/images/yamaguchi.jpeg",
  //   "assets/images/tokushima.jpeg",
  //   "assets/images/kagawa.jpeg",
  //   "assets/images/ehime.jpeg",
  //   "assets/images/kouchi.jpeg",
  //   "assets/images/fukuoka.jpeg",
  //   "assets/images/saga.jpeg",
  //   "assets/images/nagasaki.jpeg",
  //   "assets/images/kumamoto.jpeg",
  //   "assets/images/oita.jpeg",
  //   "assets/images/miyazaki.jpeg",
  //   "assets/images/kagoshima.jpeg",
  //   "assets/images/okinawa.jpeg",
  // ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.backspace,
            color: primaryColor,
            size: 40,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          GridView.count(
            crossAxisCount: 3,
            children: List.generate(47, (index) {
              return Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TouristSpot()),
                      );
                    },
                    child: GridTile(
                        child: Icon(Icons.ac_unit),
                        footer: Center(
                          child: Text(
                            listItem[index],
                          ),
                        )),
                  ));
            }),
          ),
        ],
      ),
    );
  }
}

// Image.asset(listImage[index])