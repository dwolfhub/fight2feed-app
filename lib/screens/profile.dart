import 'package:fight2feed/util/api.dart';
import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String dropdownValue = 'hello';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text("Account Info"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              DropdownButton(
                value: dropdownValue,
                onChanged: (val) {
                  setState(() {
                    dropdownValue = val;
                  });
                },
                isExpanded: true,
                items: <DropdownMenuItem>[
                  new DropdownMenuItem(
                    value: 'hello',
                    child: Text('hello'),
                  ),
                  new DropdownMenuItem(
                    value: 'hi',
                    child: Text('hi'),
                  ),
                  new DropdownMenuItem(
                    value: 'whatup',
                    child: Text('whatup'),
                  ),
                ],
              ),
              RaisedButton.icon(
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
            ],
          ),
        ));
  }
}
