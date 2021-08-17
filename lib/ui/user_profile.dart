import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        //モーダルの背景の色、透過
                        backgroundColor: Colors.transparent,
                        //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            margin: EdgeInsets.only(top: 64),
                            decoration: BoxDecoration(
                              //モーダル自体の色
                              color: Colors.white,
                              //角丸にする
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: ListView(
                              //scrollDirection: Axis.horizontal, // 横
                              padding: EdgeInsets.all(36.0),
                              shrinkWrap: true,
                              children: [
                                SizedBox(
                                  height: 100,
                                  child: Card(
                                    child: ListTile(
                                      leading: Icon(Icons.exit_to_app),
                                      title: Text(
                                        "ログアウト",
                                        style: TextStyle(fontSize: 30),
                                      ),
                                      trailing: Icon(Icons.more_vert),
                                      contentPadding: EdgeInsets.all(10.0),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: Icon(Icons.people),
                                    title: Text("ListTile with subTitle"),
                                    trailing: Icon(Icons.more_vert),
                                    subtitle: Text("This is subtitle."),
                                    onTap: () {},
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: Icon(Icons.people),
                                    title: Text("ListTile with long subTitle"),
                                    trailing: Icon(Icons.more_vert),
                                    subtitle: Text(
                                        "This is subtitle. Subtitle is very long and use three lines"),
                                    onTap: () {},
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: Icon(Icons.people),
                                    title:
                                        Text("ListTile with isThreeLine true"),
                                    trailing: Icon(Icons.more_vert),
                                    subtitle: Text(
                                        "This is subtitle. Subtitle is very long and use three lines."),
                                    onTap: () {},
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: Icon(Icons.people),
                                    title: Text("ListTile with dense true"),
                                    trailing: Icon(Icons.more_vert),
                                    subtitle: Text("This is subtitle."),
                                    onTap: () {},
                                    dense: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: Icon(Icons.people),
                                    title: Text("ListTile with enabled false"),
                                    trailing: Icon(Icons.more_vert),
                                    subtitle: Text("This is subtitle."),
                                    enabled: false,
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  icon: Icon(Icons.clear_all, color: primaryColor, size: 40.0),
                ),
              ),
            ]),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.brown.shade800,
                    child: Text('tripApp'),
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1561731172-9d906d7b13bf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1268&q=80'),
                  ),
                  // StackでRawMaterialButtonを重ねることによりCircleAvatarをタップできるような表現に変更
                  RawMaterialButton(
                    onPressed: () {
                      showAboutDialog(context: context);
                    },
                    child: Container(
                      width: 200.0, // CircleAvatarのradiusの2倍
                      height: 200.0,
                    ),
                    shape: CircleBorder(),
                    elevation: 2.0,
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                            'Taisei',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          Container(
                            child: Text(
                              'reeksge@gmail.com',
                              style: TextStyle(color: formBorderColor),
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      Container(
                        child: Icon(Icons.ten_k),
                      ),
                      Container(
                        child: Icon(Icons.ten_k),
                      ),
                    ],
                  ),
                  Container(
                    child: Text(
                        'あとは公共交通機関のルート・時間を気を付ければいいだけですからね、簡単に旅をアップグレードできます。'),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                      offset: Offset(10, 10))
                ],
                color: primaryColor,
              ),
              child: ListView(
                //scrollDirection: Axis.horizontal, // 横
                padding: EdgeInsets.all(36.0),
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10.0,
                                spreadRadius: 1.0,
                                offset: Offset(10, 10))
                          ],
                          color: primaryColor,
                        ),
                        child: Image.network(
                            'https://images.unsplash.com/photo-1563284223-333497472e88?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1510&q=80'),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Container(
                        child: Image.network(
                            'https://images.unsplash.com/photo-1561731172-e6a4d2a9a409?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1268&q=80'),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Container(
                        child: Image.network(
                            'https://images.unsplash.com/photo-1597395529362-361ba4b8ec24?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1267&q=80'),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
