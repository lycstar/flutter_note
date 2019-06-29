import 'package:flutter/material.dart';
import 'package:flutter_note/util.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("用户"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: "account",
                child: Icon(
                  Icons.face,
                  size: 100,
                  color: Colors.redAccent,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 60.0),
                child: ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text("昵称"),
                  trailing: Text(username),
                ),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("退出登录"),
                onTap: () {
                  deleteUser().then((success) {
                    if (success)
                      Navigator.of(context).pushReplacementNamed('/login');
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
