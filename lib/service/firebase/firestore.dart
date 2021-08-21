import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreModel extends ChangeNotifier {
  // 指定したドキュメントの情報
  String orderDocumentInfo = '';

  // 作成したドキュメント一覧
  List<DocumentSnapshot> documentList = [];

  // ignore: unused_element
  Future _fireStore() async {
    // ドキュメント作成
    await FirebaseFirestore.instance
        .collection('users') // コレクションID
        .doc('id_abc') // ドキュメントID
        .set({'name': '鈴木', 'age': 40}); // データ
  }

  // ignore: unused_element
  Future _fireStoreSub() async {
    // サブコレクション内にドキュメント作成
    await FirebaseFirestore.instance
        .collection('users') // コレクションID
        .doc('id_abc') // ドキュメントID << usersコレクション内のドキュメント
        .collection('orders') // サブコレクションID
        .doc('id_123') // ドキュメントID << サブコレクション内のドキュメント
        .set({'price': 600, 'date': '9/13'}); // データ
  }

  // ignore: unused_element
  Future _fireStoreGet() async {
    // コレクション内のドキュメント一覧を取得
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    // 取得したドキュメント一覧をUIに反映

    documentList = snapshot.docs;
    notifyListeners();
  }

  // ignore: unused_element
  Future _fireStoreOneGet() async {
    // コレクションIDとドキュメントIDを指定して取得
    final document = await FirebaseFirestore.instance
        .collection('users')
        .doc('id_abc')
        .collection('orders')
        .doc('id_123')
        .get();
    // 取得したドキュメントの情報をUIに反映

    orderDocumentInfo = '${document['date']} ${document['price']}円';
    notifyListeners();
  }

  // ignore: unused_element
  Future _fireStoreUpdate() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('id_abc')
        .update({'age': 23});
  }

  // ignore: unused_element
  Future _fireStoreDelete() async {
    // ドキュメント削除
    await FirebaseFirestore.instance
        .collection('users')
        .doc('id_abc')
        .collection('orders')
        .doc('id_123')
        .delete();
  }

  // ignore: unused_element
  Future _fireStoreDeleteDocument() async {
    await FirebaseFirestore.instance.collection('users').doc('id_abc').delete();
  }
}
