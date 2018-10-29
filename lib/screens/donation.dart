import 'package:fight2feed/models/donation.dart';
import 'package:flutter/material.dart';

class DonationPage extends StatefulWidget {
  final Donation donation;

  DonationPage({Key key, this.donation}) : super(key: key);

  @override
  _DonationPageState createState() =>
      new _DonationPageState(donation: this.donation);
}

class _DonationPageState extends State<DonationPage> {
  Donation donation;

  _DonationPageState({this.donation}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Donation"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // todo navigate to profile settings
              print('person pressed');
            },
          )
        ],
      ),
      body: Text(this.donation.title),
    );
  }
}
