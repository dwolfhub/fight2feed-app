import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/login.dart';

void main() => runApp(new Fight2FeedApp());

class Fight2FeedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fight2Feed',
      theme: f2fTheme(),
      home: new LoginPage(),
    );
  }
}