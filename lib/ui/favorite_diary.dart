import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(model.uid)
                                    .collection('favorite')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<
                                            QuerySnapshot<Map<String, dynamic>>>
                                        snapshot) {
                                  return Expanded(
                                    child: ListView(
                                        children: snapshot.data!.docs
                                            .map((DocumentSnapshot document) {
                                      return Card(
                                        color: Colors.transparent,
                                        child: ListTile(
                                          title: Text(
                                            '【${document['concept']}】',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          subtitle: Text(
                                            document['contents'],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      );
                                    }).toList()),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
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
