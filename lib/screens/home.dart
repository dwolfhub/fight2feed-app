import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: new Text("Home")),
        body: SizedBox(
            height: 210.0,
            width: 60.0,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                  bottomLeft: Radius.circular(2.0),
                  bottomRight: Radius.circular(2.0),
                ),
              ),
              child: new Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.map),
                    title: Text('Map'),
                    onTap: () {
                      final snackBar = SnackBar(
                        content: Text('Yay! A SnackBar!'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {},
                        ),
                      );

                      Scaffold.of(context).showSnackBar(snackBar);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_album),
                    title: Text('Album'),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Phone'),
                  ),
                ],
              ),
            )));
  }
}
