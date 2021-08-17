import 'package:flutter/material.dart';
import 'package:tripapp/res/const.dart';

class ConfigurationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            Card(
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text("ListTile with selected true"),
                trailing: Icon(Icons.more_vert),
                subtitle: Text("This is subtitle."),
                selected: true,
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text("ListTile with contentPadding all 10.0"),
                trailing: Icon(Icons.more_vert),
                subtitle: Text("This is subtitle."),
                onTap: () {},
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text("ListTile with contentPadding all 10.0"),
                trailing: Icon(Icons.more_vert),
                subtitle: Text("This is subtitle."),
                onTap: () {},
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text("ListTile with contentPadding all 10.0"),
                trailing: Icon(Icons.more_vert),
                subtitle: Text("This is subtitle."),
                onTap: () {},
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text("ListTile with contentPadding all 10.0"),
                trailing: Icon(Icons.more_vert),
                subtitle: Text("This is subtitle."),
                onTap: () {},
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text("ListTile with contentPadding all 10.0"),
                trailing: Icon(Icons.more_vert),
                subtitle: Text("This is subtitle."),
                onTap: () {},
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text("ListTile with contentPadding all 10.0"),
                trailing: Icon(Icons.more_vert),
                subtitle: Text("This is subtitle."),
                onTap: () {},
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text("ListTile with contentPadding all 10.0"),
                trailing: Icon(Icons.more_vert),
                subtitle: Text("This is subtitle."),
                onTap: () {},
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text("ListTile with contentPadding all 10.0"),
                trailing: Icon(Icons.more_vert),
                subtitle: Text("This is subtitle."),
                onTap: () {},
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text("ListTile with contentPadding all 10.0"),
                trailing: Icon(Icons.more_vert),
                subtitle: Text("This is subtitle."),
                onTap: () {},
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
