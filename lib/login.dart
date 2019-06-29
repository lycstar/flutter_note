import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_note/network.dart';
import 'package:flutter_note/util.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  String _username, _password;
  bool _isObscure = true;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  Color _suffixIconColor = Colors.grey;

  int last = 0;

  Future<bool> doubleBackExit() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - last > 800) {
      showToast("再按一次退出应用");
      last = DateTime.now().millisecondsSinceEpoch;
      return Future.value(false);
    } else {
      cancelToast();
      return Future.value(true);
    }
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

  Padding _buildUsernameTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 48.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color.fromRGBO(255, 255, 255, 0.2),
        ),
        child: TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(10.0),
            labelText: '昵称',
            labelStyle: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          validator: (String value) {
            if (value.isEmpty) return '请输入昵称';
            if (value.length > 20) return '不超过20个字符';
          },
          style: TextStyle(color: Colors.white, fontSize: 18.0),
          cursorColor: Colors.white,
          onSaved: (String value) => _username = value,
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 48.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color.fromRGBO(255, 255, 255, 0.2),
        ),
        child: TextFormField(
          onSaved: (String value) => _password = value,
          obscureText: _isObscure,
          validator: (String value) {
            if (value.isEmpty) return '请输入密码';
            if (value.length > 20) return '不超过20个字符';
          },
          controller: _passwordController,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(10.0),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.white,
            ),
            labelText: '密码',
            labelStyle: TextStyle(color: Colors.white, fontSize: 18.0),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _suffixIconColor,
              ),
              onPressed: () {
                setState(
                  () {
                    _isObscure = !_isObscure;
                    _suffixIconColor = _isObscure ? Colors.grey : Colors.white;
                  },
                );
              },
            ),
          ),
          style: TextStyle(color: Colors.white, fontSize: 20.0),
          cursorColor: Colors.white,
        ),
      ),
    );
  }

  Container _buildLoginButton(context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: IconButton(
          highlightColor: Colors.white,
          icon: Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState.save();
//              print('username:$_username , password:$_password');
              _login(_username, _password);
            }
          }),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.2),
        shape: BoxShape.circle,
      ),
    );
  }

  Container _buildRegisterButton(context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: FlatButton(
          child: Text(
            "点击立即注册",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState.save();
//              print('username:$_username , password:$_password');
              _register(_username, _password);
            }
          }),
    );
  }

  void _login(username, password) {
    login(username, password).then((map) {
      if (verifyRequestResult(map)) {
        if (map['msg'] == "登录成功") {
          storeUser(username, map['data']).then((success) {
            getStoreUser();
            if (success) Navigator.of(context).pushReplacementNamed('/home');
          });
        }
      }
    });
  }

  void _register(username, password) {
    register(username, password).then((map) {
      if (verifyRequestResult(map)) {
        if (map['msg'] == "注册成功") {
          _login(username, password);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: doubleBackExit,
      child: Scaffold(
        body: Builder(
          builder: (context) => Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 120.0),
                        _buildLogo(),
                        SizedBox(height: 30.0),
                        _buildUsernameTextField(),
                        SizedBox(height: 30.0),
                        _buildPasswordTextField(),
                        SizedBox(height: 10.0),
                        _buildRegisterButton(context),
                        _buildLoginButton(context),
                      ],
                    ),
                  ),
                ],
              ),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
