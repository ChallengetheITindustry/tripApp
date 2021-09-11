import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/view_model/create_trip_diary_model.dart';

class createTripDiary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateTripDiaryModel>(
      create: (_) => CreateTripDiaryModel(),
      child: Consumer<CreateTripDiaryModel>(builder: (context, model, child) {
        return IconButton(
            onPressed: () {
              showModalBottomSheet(
                  //モーダルの背景の色、透過
                  backgroundColor: Colors.transparent,
                  //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.blockSizeHorizontal * 20,
                          ),
                          Container(
                            width: SizeConfig.screenWidth * 0.8,
                            decoration: BoxDecoration(
                              border: const Border(
                                bottom: const BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Text('旅の日記を書く',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                          Container(
                            width: SizeConfig.screenWidth * 0.8,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                SizedBox(
                                  height: SizeConfig.blockSizeHorizontal * 10,
                                ),
                                Center(
                                  child: Text(
                                    'どんな旅だった？',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeHorizontal * 10,
                                ),
                                Container(
                                  child: TextFormField(
                                    onChanged: (value) {
                                      model.concept = value;
                                    },
                                    autofocus: true,
                                    decoration: InputDecoration(
                                      labelText: 'ex：過酷？青春18きっぷで日本一周の旅！',
                                      labelStyle:
                                          TextStyle(color: formBorderColor),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeHorizontal * 10,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          // ignore: unnecessary_brace_in_string_interps
                                          Text(
                                            "From：${model.dateStart.year}-${model.dateStart.month}-${model.dateStart.day < 10 ? '0' + model.dateStart.day.toString() : model.dateStart.day} ~ ",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            "To：${model.dateEnd.year}-${model.dateEnd.month}-${model.dateEnd.day} ~ ",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          model.selectDateStart(context);
                                        },
                                        icon: Icon(
                                          Icons.timer,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeHorizontal * 10,
                                ),
                                Container(
                                  width: SizeConfig.screenWidth * 0.3,
                                  height: SizeConfig.screenHeight * 0.12,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeHorizontal * 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(maxHeight: 500),
                                    child: Scrollbar(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: TextFormField(
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                            labelStyle: TextStyle(
                                                color: formBorderColor),
                                          ),
                                          maxLines: 100,
                                          minLines: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeHorizontal * 10,
                                ),
                                Container(
                                  width: SizeConfig.screenWidth * 0.6,
                                  height: SizeConfig.screenHeight * 0.05,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        side: BorderSide(
                                          color: Colors.white, //枠線!
                                          width: 1, //枠線！
                                        ),
                                        primary: Colors.transparent,
                                      ),
                                      onPressed: () async {
                                        // await setTrip();
                                        // tripImageUpload();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        '投稿',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeHorizontal * 50,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            },
            icon: Icon(
              Icons.create_sharp,
              size: 30,
            ));
      }),
    );
  }
}
