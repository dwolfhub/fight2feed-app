import 'package:flutter/material.dart';

class F2FTextFormField extends StatelessWidget {
  const F2FTextFormField({
    Key key,
    @required String labelText,
    @required Function validator,
    @required Function setter,
    bool obscureText = false,
    keyboardType,
  })  : _keyboardType = keyboardType,
        _labelText = labelText,
        _obscureText = obscureText,
        _setter = setter,
        _validator = validator,
        super(key: key);

  final String _labelText;
  final Function _validator;
  final Function _setter;
  final _keyboardType;
  final bool _obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: _labelText,
      ),
      obscureText: _obscureText,
      keyboardType: _keyboardType,
      validator: _validator,
      onSaved: (val) {
        _setter(val.trim());
      },
    );
  }
}
