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
              IconButton(
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
                                  title: Text("ListTile with isThreeLine true"),
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
                icon: Icon(
                  Icons.clear_all,
                  color: primaryColor,
                ),
              ),
            ]),
        body: Column(
          children: [],
        ));
  }
}
