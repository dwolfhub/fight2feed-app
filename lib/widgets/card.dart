import "package:flutter/material.dart";

class F2FCard extends StatelessWidget {
  final List<Widget> children;

  const F2FCard({Key key, @required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: new Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: this.children,
        ),
      ),
    );
  }
}
