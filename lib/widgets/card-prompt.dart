import "package:flutter/material.dart";

class F2FCardPrompt extends StatelessWidget {
  const F2FCardPrompt(
      {Key key,
      @required this.context,
      @required this.question,
      @required this.answer,
      this.onTap})
      : super(key: key);

  final BuildContext context;
  final String question;
  final String answer;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 14.0),
            child: Text(
              this.question,
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(
            height: 18.0,
            child: GestureDetector(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    this.answer,
                    textAlign: TextAlign.right,
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.red),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 18.0,
                    color: Colors.red,
                  ),
                ],
              ),
              onTap: this.onTap,
            ),
          ),
        ],
      ),
    );
  }
}
