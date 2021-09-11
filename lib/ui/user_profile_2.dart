// リファクタリングする
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripapp/config/config.dart';
import 'package:tripapp/view_model/user_profile_model.dart';

class UserProfilePage2 extends StatefulWidget {
  @override
  UserProfilePage12 createState() => UserProfilePage12();
}

class UserProfilePage12 extends State {
  String currentUserName = '';
  String currentUserMail = '';
  String uid = '';
  // ignore: unused_element
  Future getFirestore() async {
    // ignore: await_only_futures
    final User user = await FirebaseAuth.instance.currentUser!;
    // ignore: unused_local_variable
    final String uid = user.uid.toString();
    // 指定コレクションのドキュメント一覧を取得
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    setState(() {
      currentUserName = snapshot['name'];
      currentUserMail = snapshot['mail'];
      this.uid = uid;
    });
  }

  // ページコントローラ
  final PageController controller = PageController(viewportFraction: 0.8);

  // ページインデックス
  int currentPage = 0;

  // データ

  @override
  Widget build(BuildContext context) {
    getFirestore();
    SizeConfig().init(context);
    return ChangeNotifierProvider<UserProfileModel>(
      create: (context) => UserProfileModel(),
      child: Scaffold(
          body: Consumer<UserProfileModel>(builder: (context, model, child) {
        return Container(
          child: Text(''),
        );
      })),
    );
  }
}

// Container(
//   width: SizeConfig.screenWidth * 0.8,
//   child: Column(
//     children: [
//       Container(
//         width: SizeConfig.screenWidth * 0.8,
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 15.0,
//                 spreadRadius: 1.0,
//                 offset: Offset(10, 10))
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20.0),
//           child: Image.network(
//               'https://images.unsplash.com/photo-1472740378865-80aab8e73251?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80'),
//         ),
//       ),
//     ],
//   ),
// )