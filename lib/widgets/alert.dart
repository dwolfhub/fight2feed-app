import 'package:flutter/material.dart';

Future<Null> f2fShowAlert(BuildContext context, String title, String message) {
  return showDialog<Null>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void networkError(context) {
  f2fShowAlert(
    context,
    'Connection Error',
    'Unable to connect to the server. Please check your network connection and try again.',
  );
}

void serverError(context) {
  f2fShowAlert(
    context,
    'Server Error',
    'A server error has occurred. We are aware of the problem and will be fixing it as soon as possible. Thanks for your patience.',
  );
}
