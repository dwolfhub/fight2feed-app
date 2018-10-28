import 'package:flutter/material.dart';

ThemeData f2fTheme() {
  return new ThemeData(
    primarySwatch: Colors.red,
    accentColor: Colors.black,
    fontFamily: 'Raleway',
    buttonColor: Colors.red,
    buttonTheme: ButtonThemeData(
      padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
      textTheme: ButtonTextTheme.primary,
      shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
    ),
    textTheme: TextTheme(
      button: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white
      ),
      headline: TextStyle(
        fontWeight: FontWeight.w200,
        fontSize: 36.0,
      ),
    ),
    inputDecorationTheme: new InputDecorationTheme(
      labelStyle: new TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: new TextStyle(
        color: Colors.red,
      ),
      border: new UnderlineInputBorder(
        borderSide: new BorderSide(
          color: Colors.black,
        ),
      ),
      focusedBorder: new UnderlineInputBorder(
        borderSide: new BorderSide(
          color: Colors.black,
        ),
      ),
    ),
  );
}
