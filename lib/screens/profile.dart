import 'package:fight2feed/screens/login.dart';
import 'package:fight2feed/util/api.dart';
import 'package:fight2feed/util/transition.dart';
import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text("Account Info"),
        ),
        body: Container(
          child: RaisedButton.icon(
            icon: Icon(Icons.lock_open),
            label: Text("Sign Out"),
            onPressed: () {
              FlutterSecureStorage storage = new FlutterSecureStorage();
              storage.delete(key: API_REFRESH_TOKEN_STORAGE_KEY).then((_) {
                setToken(null);
                Navigator.pop(context);
              });
            },
          ),
        ));
  }
}
