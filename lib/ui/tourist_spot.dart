import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';

// ignore: must_be_immutable
class TouristSpot extends StatefulWidget {
  @override
  _TouristSpot createState() => _TouristSpot();
}

class _TouristSpot extends State {
  final controller = PageController(initialPage: 0);
  // ignore: unused_field
  final _hasPadding = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 2.0,
        title: Text('東京都'),
        leading: IconButton(
          icon: Icon(Icons.backspace),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: PageView(
        controller: controller,
        children: [Cards(context), Cards1(context), Cards2(context)],
      ),
    );
  }

  // 画像Widget
// ignore: non_constant_identifier_names
  Widget Cards(BuildContext context) {
    var _hasPadding = false;
    return AnimatedPadding(
      duration: const Duration(milliseconds: 80),
      padding: EdgeInsets.all(_hasPadding ? 100 : 0),
      child: GestureDetector(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                  //モーダル自体の色
                  color: Colors.white,
                  //角丸にする
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '浅草寺',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Image.network(
                    'https://images.unsplash.com/photo-1570638013975-fa2b3c9525b2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1778&q=80'),
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      //モーダル自体の色
                      color: Colors.white,
                      //角丸にする
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                            offset: Offset(10, 10))
                      ],
                    ),
                  ),
                  InkWell(
                    onTapDown: (TapDownDetails downDetails) {
                      setState(() {
                        _hasPadding = true;
                      });
                    },
                    onTap: () {
                      print('Card tapped.');
                      setState(() {
                        _hasPadding = false;
                      });
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder: (_, __, ___) => DetailPage(),
                          ));
                    },
                    onTapCancel: () {
                      setState(() {
                        _hasPadding = false;
                      });
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          //モーダル自体の色
                          color: heartColor,
                          //角丸にする
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '詳細',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Cards1(BuildContext context) {
    var _hasPadding = false;
    return AnimatedPadding(
      duration: const Duration(milliseconds: 80),
      padding: EdgeInsets.all(_hasPadding ? 100 : 0),
      child: GestureDetector(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                  //モーダル自体の色
                  color: Colors.white,
                  //角丸にする
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '東京タワー',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Image.network(
                    'https://images.unsplash.com/flagged/photo-1577734374290-ee824cc03928?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80'),
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      //モーダル自体の色
                      color: Colors.white,
                      //角丸にする
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                            offset: Offset(10, 10))
                      ],
                    ),
                  ),
                  InkWell(
                    onTapDown: (TapDownDetails downDetails) {
                      setState(() {
                        _hasPadding = true;
                      });
                    },
                    onTap: () {
                      print('Card tapped.');
                      setState(() {
                        _hasPadding = false;
                      });
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder: (_, __, ___) => DetailPage1(),
                          ));
                    },
                    onTapCancel: () {
                      setState(() {
                        _hasPadding = false;
                      });
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          //モーダル自体の色
                          color: heartColor,
                          //角丸にする
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '詳細',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Cards2(BuildContext context) {
    var _hasPadding = false;
    return AnimatedPadding(
      duration: const Duration(milliseconds: 80),
      padding: EdgeInsets.all(_hasPadding ? 100 : 0),
      child: GestureDetector(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                  //モーダル自体の色
                  color: Colors.white,
                  //角丸にする
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'みなとみらい',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Image.network(
                    'https://images.unsplash.com/photo-1593579052349-e4a296361548?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1778&q=80'),
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      //モーダル自体の色
                      color: Colors.white,
                      //角丸にする
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                            offset: Offset(10, 10))
                      ],
                    ),
                  ),
                  InkWell(
                    onTapDown: (TapDownDetails downDetails) {
                      setState(() {
                        _hasPadding = true;
                      });
                    },
                    onTap: () {
                      print('Card tapped.');
                      setState(() {
                        _hasPadding = false;
                      });
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder: (_, __, ___) => DetailPage2(),
                          ));
                    },
                    onTapCancel: () {
                      setState(() {
                        _hasPadding = false;
                      });
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          //モーダル自体の色
                          color: heartColor,
                          //角丸にする
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '詳細',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 詳細画面を押したときに画面が拡大するアニメーションを実装する
// ignore: must_be_immutable
class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              child: Image.network(
                  'https://images.unsplash.com/photo-1570638013975-fa2b3c9525b2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1778&q=80'),
            ),
            Spacer(),
            Container(
                child: Text(
              '浅草寺',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            )),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            FloatingActionButton(
                backgroundColor: primaryColor,
                child: Icon(Icons.backspace),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Spacer()
          ],
        ));
  }
}

class DetailPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              child: Image.network(
                  'https://images.unsplash.com/flagged/photo-1577734374290-ee824cc03928?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80'),
            ),
            Spacer(),
            Container(
                child: Text(
              '東京タワー',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            )),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            FloatingActionButton(
                backgroundColor: primaryColor,
                child: Icon(Icons.backspace),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Spacer()
          ],
        ));
  }
}

class DetailPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  child: Image.network(
                      'https://images.unsplash.com/photo-1611386666512-773de05f25f6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 550.0, left: 30),
                  child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10.0,
                              spreadRadius: 10.0,
                              offset: Offset(10, 10))
                        ],
                      ),
                      child: Text('みなとみらい',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white))),
                )
              ],
            ),
            Container(
              width: 400,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Container(
                      child: Text(
                        'みなとみらいでおしゃれな休日？',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      child: Text(
                        'みなとみらいでおしゃれな休日はいかがですか？\nショッピングもしてもいいしカフェでのんびりしてもいい。\n普段できないことをここみなとみらいで思いっきり楽しみましょう',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: formBorderColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          child: Icon(
                            Icons.star,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(10, 10))
                            ],
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 280,
                            height: 100,
                            child: Center(
                                child: Text(
                              '戻る',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10.0,
                                    spreadRadius: 1.0,
                                    offset: Offset(10, 10))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
