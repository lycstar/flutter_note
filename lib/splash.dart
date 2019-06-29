import 'package:flutter/material.dart';
import 'package:flutter_note/login.dart';
import 'package:flutter_note/util.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Hero _buildLogo() {
    return Hero(
      tag: "Logo",
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Icon(
          Icons.event_note,
          size: 100,
          color: Colors.white,
        ),
      ),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      getStoreUser().then((map) {
        if (map['username'] != "" && map['token'] != "") {
//          print(map['username']);
//          print(map['token']);
          jump(true);
        } else
          jump(false);
      });
    });
  }

  void jump(bool isLogin) {
    if (isLogin)
      Navigator.of(context).pushReplacementNamed('/home');
    else
      Future.delayed(const Duration(seconds: 2), () {
        try {
          Navigator.of(context).pushReplacement(PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 1000),
            pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: LoginPage(),
              );
            },
          ));
        } catch (e) {}
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildLogo(),
          Text(
            "云便签",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w100, color: Colors.white),
          ),
        ],
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
