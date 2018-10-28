import 'package:fight2feed/util/api.dart';
import 'package:fight2feed/widgets/alert.dart';
import 'package:fight2feed/widgets/card.dart';
import 'package:fight2feed/widgets/submit-button.dart';
import 'package:fight2feed/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RequestInvitePage extends StatefulWidget {
  RequestInvitePage({Key key}) : super(key: key);

  @override
  _RequestInvitePageState createState() => new _RequestInvitePageState();
}

class RequestInviteFormData {
  String name;
  String email;
  String description;
  String phoneNumber;
}

class _RequestInvitePageState extends State<RequestInvitePage> {
  final _requestInviteFormKey = new GlobalKey<FormState>();
  RequestInviteFormData formData = new RequestInviteFormData();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Request Invitation',
        ),
        elevation: 1.0,
      ),
      body: new Container(
        child: new ListView(
          padding: EdgeInsets.all(24.0),
          children: <Widget>[
            F2FTitle(context: context, text: 'Request Invite'),
            F2FCard(
              children: <Widget>[
                Form(
                  key: _requestInviteFormKey,
                  child: Column(
                    children: <Widget>[
                      _nameField(),
                      _emailField(),
                      _phoneField(),
                      _messageField(),
                    ],
                  ),
                ),
                F2FSubmitButton(
                  iconData: Icons.email,
                  text: 'SEND REQUEST',
                  isLoading: _isLoading,
                  onPressed: this._onSubmit,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmit() async {
    if (_requestInviteFormKey.currentState.validate()) {
      _requestInviteFormKey.currentState.save();

      setState(() {
        _isLoading = true;
      });

      try {
        Response res = await apiPost('/api/invitation_requests', {
          'description': formData.description,
          'email': formData.email,
          'name': formData.name,
          'phoneNumber': formData.phoneNumber,
        });

        switch (res.statusCode) {
          case 201:
            _onSuccess();
            break;
          case 400:
            _onBadRequest();
            break;
          case 500:
            serverError(context);
            break;
        }
      } on Exception {
        networkError(context);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onSuccess() async {
    Navigator.pop(context, 'Thank you. Your request has been received.');
  }

  void _onBadRequest() {
    // todo parse response and show error
    f2fShowAlert(
      context,
      'Bad Request',
      'Please check your information and try again.',
    );
  }

  TextFormField _messageField() {
    return TextFormField(
        decoration: InputDecoration(
          labelText: 'Message',
        ),
        maxLines: 4,
        validator: (val) {
          if (val.length == 0) return 'This field is required.';
          if (val.length > 1000)
            return 'This field is limited to 1000 characters.';
        },
        onSaved: (val) {
          this.formData.description = val.trim();
        });
  }

  TextFormField _phoneField() {
    // note: had to remove because it was clearing the value of the input upon blur
    // MaskedTextController maskedTextController =
    // new MaskedTextController(mask: '000-000-0000');

    return TextFormField(
      // controller: maskedTextController,
      decoration: InputDecoration(
          labelText: 'Phone',
          helperText: 'Please use the format XXX-XXX-XXXX.'),
      keyboardType: TextInputType.phone,
      validator: (val) {
        RegExp regex = new RegExp(r'^\d{3}-\d{3}-\d{4}$');

        if (!regex.hasMatch(val))
          return 'Please enter a valid phone number using format XXX-XXX-XXXX.';
      },
      onSaved: (val) {
        this.formData.phoneNumber = val.trim();
      },
    );
  }

  TextFormField _nameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Name',
      ),
      validator: (val) {
        if (val.length == 0) return 'This field is required.';
        if (val.length > 255) return 'This field is limited to 255 characters.';
      },
      onSaved: (val) {
        this.formData.name = val.trim();
      },
    );
  }

  TextFormField _emailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (val) {
        RegExp regExp = new RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
        );

        if (!regExp.hasMatch(val)) return 'Please enter a valid email address.';
      },
      onSaved: (val) {
        this.formData.email = val.trim();
      },
    );
  }
}
