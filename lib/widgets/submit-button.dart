import "package:flutter/material.dart";

class F2FSubmitButton extends StatelessWidget {
  const F2FSubmitButton({
    Key key,
    @required this.text,
    @required this.iconData,
    @required this.isLoading,
    @required this.onPressed,
  }) : super(key: key);

  final IconData iconData;
  final String text;
  final bool isLoading;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24.0),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton.icon(
          icon: !isLoading
              ? Icon(
                  this.iconData,
                  size: 18.0,
                )
              : new SizedBox(
                  height: 17.0,
                  width: 17.0,
                  child: new CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
          onPressed: !isLoading ? onPressed : null,
          label: new Text(this.text),
        ),
      ),
    );
  }
}
