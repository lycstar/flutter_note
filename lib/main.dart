import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_note/account.dart';
import 'package:flutter_note/home.dart';
import 'package:flutter_note/login.dart';
import 'package:flutter_note/splash.dart';

void main() {
  runApp(MyApp());
  SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '便签',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/splash': (_) => SplashPage(),
        '/home': (_) => HomePage(),
        '/login': (_) => LoginPage(),
        '/account': (_) => AccountPage(),
      },
    );
  }
}
