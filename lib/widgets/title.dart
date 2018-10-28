import "package:flutter/material.dart";

class F2FTitle extends StatelessWidget {
  final String text;

  const F2FTitle({
    Key key,
    this.text,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
      child: new Text(
        this.text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }
}
