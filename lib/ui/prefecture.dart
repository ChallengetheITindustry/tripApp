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

  final listImage = [
    _imageItem("hokkaido"),
    _imageItem("aomori"),
    _imageItem("iwate"),
    _imageItem("miyagi"),
    _imageItem("akita"),
    _imageItem("yamagata"),
    _imageItem("hukushima"),
    _imageItem("ibaraki"),
    _imageItem("tochigi"),
    _imageItem("gunma"),
    _imageItem("saitama"),
    _imageItem("chiba"),
    _imageItem("tokyo"),
    _imageItem("kanagawa"),
    _imageItem("niigata"),
    _imageItem("toyama"),
    _imageItem("ishikawa"),
    _imageItem("fukui"),
    _imageItem("yamanashi"),
    _imageItem("nagano"),
    _imageItem("gihu"),
    _imageItem("shizuoka"),
    _imageItem("aichi"),
    _imageItem("mie"),
    _imageItem("shiga"),
    _imageItem("kyoto"),
    _imageItem("osaka"),
    _imageItem("hyogo"),
    _imageItem("nara"),
    _imageItem("wakayama"),
    _imageItem("tottori"),
    _imageItem("shimane"),
    _imageItem("okayama"),
    _imageItem("hiroshima"),
    _imageItem("yamaguchi"),
    _imageItem("tokushima"),
    _imageItem("kagawa"),
    _imageItem("ehime"),
    _imageItem("kouchi"),
    _imageItem("fukuoka"),
    _imageItem("saga"),
    _imageItem("nagasaki"),
    _imageItem("kumamoto"),
    _imageItem("oita"),
    _imageItem("miyazaki"),
    _imageItem("kagoshima"),
    _imageItem("okinawa"),
  ];

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
                      (() {
                        // widget内にif文やswitch文を使用する場合は、即時関数を使用する。
                        // switch (listItem[index]) {
                        //   case listItem[index] == 0:
                        //     return Text('こんにちは');
                        //   case 'PENDING':
                        //     return Text('こんにちは');
                        //   case 'APPROVED':
                        //     return Text('こんにちは');
                        //   case 'DENIED':
                        //     return Text('こんにちは');
                        //   case 'OPEN':
                        //     return Text('こんにちは');
                        //   default:
                        //     return Text('こんにちは');
                        // }
                      })();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => TouristSpot()),
                      // );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.0,
                              spreadRadius: 5.0,
                              offset: Offset(5, 5))
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: GridTile(
                          footer: Center(
                            child: Text(
                              listItem[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: <Shadow>[
                                  Shadow(
                                    blurRadius: 2.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          child: listImage[index],
                        ),
                      ),
                    ),
                  ));
            }),
          ),
        ],
      ),
    );
  }
}

Widget _imageItem(String name) {
  var image = "assets/images/" + name + ".jpeg";
  return Container(
    child: Image.asset(
      image,
      fit: BoxFit.cover,
    ),
  );
}
