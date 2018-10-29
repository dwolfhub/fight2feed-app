import 'dart:convert';

import 'package:fight2feed/screens/home.dart';
import 'package:fight2feed/screens/request-invite.dart';
import 'package:fight2feed/util/api.dart';
import 'package:fight2feed/widgets/alert.dart';
import 'package:fight2feed/widgets/card-prompt.dart';
import 'package:fight2feed/widgets/card.dart';
import 'package:fight2feed/widgets/submit-button.dart';
import 'package:fight2feed/widgets/title.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginData {
  String email;
  String password;
}

class _LoginPageState extends State<LoginPage> {
  final loginFormKey = new GlobalKey<FormState>();
  _LoginData _loginFormData = new _LoginData();
  bool _isLoading = false;
  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Fight2Feed"),
        elevation: 1.0,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return FutureBuilder<String>(
            future: storage.read(key: API_REFRESH_TOKEN_STORAGE_KEY),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != '') {
                  apiPost(
                    '/api/token/refresh',
                    {"refresh_token": snapshot.data},
                  ).then((Response res) {
                    if (res.statusCode == 200) {
                      Map<String, dynamic> resData = json.decode(res.body);
                      setToken(resData['token']);

                      storage.write(
                        key: API_REFRESH_TOKEN_STORAGE_KEY,
                        value: resData['refresh_token'],
                      );

                      goHome();
                    }
                  });
                }
              } else if (snapshot.connectionState == ConnectionState.done) {
                return new Container(
                  // decoration: new BoxDecoration(
                  //   image: new DecorationImage(
                  //     image: new AssetImage("assets/preparing-food.jpg"),
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  child: new ListView(
                    padding: EdgeInsets.all(24.0),
                    children: <Widget>[
                      _header(),
                      _loginCard(context),
                    ],
                  ),
                );
              }

              return Container(
                alignment: AlignmentDirectional.center,
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _header() {
    return new F2FTitle(context: context, text: 'Welcome!');
  }

  Widget _loginCard(BuildContext context) {
    return F2FCard(
      children: <Widget>[
        Form(
          key: loginFormKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Login',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val.length == 0)
                    return 'Please enter your username or email.';
                  if (val.length > 255)
                    return 'This field is limited to 255 characters.';
                },
                onSaved: (val) {
                  this._loginFormData.email = val.trim();
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (val) {
                  return (val.trim() == '') ? 'Please enter a password.' : null;
                },
                onSaved: (val) {
                  this._loginFormData.password = val.trim();
                },
              ),
            ],
          ),
        ),
        new F2FSubmitButton(
          iconData: Icons.verified_user,
          text: 'LOGIN',
          isLoading: _isLoading,
          onPressed: this._onLoginPressed,
        ),
        _prompt(
          "Forgot your login info?",
          "Reset Password",
          () {
            // todo
          },
        ),
        _requestInvitePrompt(context),
      ],
    );
  }

  Widget _requestInvitePrompt(BuildContext context) {
    return _prompt(
      "Not a member?",
      "Request Invitation",
      () async {
        final result = await Navigator.of(this.context).push(
          new PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 250),
              pageBuilder: (BuildContext context, _, __) =>
                  new RequestInvitePage(),
              transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
                return new SlideTransition(
                  child: child,
                  position: new Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                );
              }),
        );

        if (result != null)
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("$result")));
      },
    );
  }

  void _onLoginPressed() async {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();

      setState(() {
        _isLoading = true;
      });

      try {
        Response res = await apiPost('/api/login', {
          'username': this._loginFormData.email,
          'password': this._loginFormData.password,
        });

        switch (res.statusCode) {
          case 200:
            Map<String, dynamic> data = json.decode(res.body);

            if (!(data['token'] is String) || data['token'].length == 0)
              serverError(context);

            if (data['refresh_token'] is String) {
              await storage.write(
                key: API_REFRESH_TOKEN_STORAGE_KEY,
                value: data['refresh_token'],
              );
            }

            setToken(data['token']);

            goHome();

            break;
          case 401:
            f2fShowAlert(
              context,
              'Invalid Credentials',
              'Please check your information and try again',
            );
            break;
          default:
            serverError(context);
            break;
        }
      } on Exception {
        networkError(context);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void goHome() {
    Navigator.pushReplacement(
      context,
      new PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 250),
          pageBuilder: (BuildContext context, _, __) => new HomePage(),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return new SlideTransition(
              child: child,
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
            );
          }),
    );
  }

  Widget _prompt(String question, String answer, onTap) {
    return new F2FCardPrompt(
        context: context, question: question, answer: answer, onTap: onTap);
  }

  Future<Null> _showLoginError() async {
    return showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Invalid Credentials'),
          content: new SingleChildScrollView(
            child: new Text(
              'Plese verify your email and password and try again.',
            ),
          ),
          actions: <Widget>[
            new RaisedButton(
                child: new Text(
                  'OK',
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }
}
