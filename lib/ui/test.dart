import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tripapp/ui/test1.dart';

// ignore: must_be_immutable
class TestPage extends StatelessWidget {
  List planList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        StreamBuilder<QuerySnapshot>(
            // ★2 streamに`Stream<QuerySnapshot>`を渡す。
            stream:
                FirebaseFirestore.instance.collection('timeline').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // ★3 `List<DocumentSnapshot>`をsnapshotから取り出す。
                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                return ListView(
                    children: documents
                        .map((doc) => Card(
                              child: ListTile(
                                title: Text(doc['title']),
                              ),
                            ))
                        .toList());
              } else if (snapshot.hasError) {
                return Text('エラーだよ');
              } else {
                throw Text('こんにちは');
              }
            }),
        Center(
            child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TestPage1()),
                  );
                }))
      ],
    ));
  }
}
