import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/res/const.dart';
import 'package:tripapp/view_model/favorite_diary_model.dart';

class FavoriteDiary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoriteDiaryModel>(
      create: (_) => FavoriteDiaryModel(),
      child: Consumer<FavoriteDiaryModel>(builder: (context, model, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  spreadRadius: 5.0,
                  offset: Offset(10, 10))
            ],
          ),
          child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                    //モーダルの背景の色、透過
                    backgroundColor: Colors.transparent,
                    //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Stack(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.1,
                              ),
                              Center(
                                child: Container(
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
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      'いいね一覧',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    });
              },
              icon: Icon(
                Icons.favorite,
                size: 30,
                color: timelineBackground,
              )),
        );
      }),
    );
  }
}
