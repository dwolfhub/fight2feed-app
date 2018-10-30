import 'package:fight2feed/models/donation.dart';
import 'package:fight2feed/util/api.dart';
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
      ),
      body: ListView(
        padding: EdgeInsets.all(24.0),
        children: <Widget>[
          Image.network(
            getMediaUrl(
              this.donation.photo,
            ),
            height: 256.0,
          ),
          Text(
            this.donation.title,
            style: Theme.of(context).textTheme.title,
          ),
          Text(
            this.donation.description,
            style: Theme.of(context).textTheme.body1,
          )
        ],
      ),
    );
  }
}
