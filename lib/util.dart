import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

String username = "";
String token = "";

showToast(String str) {
  Fluttertoast.showToast(
      msg: str,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

cancelToast() {
  Fluttertoast.cancel();
}

bool verifyRequestResult(Map map) {
  if (map['code'] == 200) {
    showToast(map['msg']);
    return true;
  }
  return false;
}

/*存储用户*/
Future<bool> storeUser(String username, String token) async {
  bool _success = true;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('username', username).then((success) {
    if (!success) _success = false;
  });
  prefs.setString('token', token).then((success) {
    if (!success) _success = false;
  });
//  print("存储用户：" + username);
//  print("存储token：" + token);
  return _success;
}

/*获取用户*/
Future<Map> getStoreUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.get('username') == null || prefs.get('token') == null) {
  } else {
    username = prefs.get('username');
    token = prefs.get('token');
  }
//  print("获取用户：" + username);
//  print("获取token：" + token);
  return {'username': username, 'token': token};
}

/*存储用户*/
Future<bool> deleteUser() async {
  username = "";
  token = "";
  var _success = true;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('username').then((success) {
    if (!success) _success = false;
  });
  prefs.remove('token').then((success) {
    if (!success) _success = false;
  });
  return _success;
}
