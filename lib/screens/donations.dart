import 'dart:convert';

import 'package:fight2feed/models/donation.dart';
import 'package:fight2feed/screens/create.dart';
import 'package:fight2feed/screens/donation.dart';
import 'package:fight2feed/screens/login.dart';
import 'package:fight2feed/screens/profile.dart';
import 'package:fight2feed/util/api.dart';
import 'package:fight2feed/util/transition.dart';
import 'package:fight2feed/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:http/http.dart';

class DonationsPage extends StatefulWidget {
  DonationsPage({Key key}) : super(key: key);

  @override
  _DonationsPageState createState() => new _DonationsPageState();
}

class _DonationsPageState extends State<DonationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        child: Icon(Icons.add_box),
        backgroundColor: Colors.red,
        tooltip: "Submit Donation",
        onPressed: () {
          Navigator.of(this.context).push(
            pageRouteBuilderTo(
              new CreatePage(),
            ),
          );
        },
      ),
      appBar: AppBar(
        title: new Text("Donations"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // todo navigate to profile settings
              Navigator.of(this.context).push(
                pageRouteBuilderTo(new ProfilePage()),
              );
            },
          )
        ],
      ),
      body: FutureBuilder<List<Donation>>(
        future: getDonations(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Donation>> snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
                onRefresh: () {
                  // todo refresh list
                  return apiGet('/api/donations');
                },
                child: ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  children: snapshot.data
                      .map(
                        (Donation donation) => ListTile(
                              onTap: () async {
                                final result = await Navigator.of(
                                  this.context,
                                ).push(
                                  pageRouteBuilderTo(
                                    new DonationPage(
                                      donation: donation,
                                    ),
                                  ),
                                );

                                if (result != null) {
                                  Scaffold.of(
                                    context,
                                  ).showSnackBar(
                                    SnackBar(content: Text("$result")),
                                  );
                                }
                              },
                              trailing: Icon(Icons.chevron_right),
                              leading: Image.network(
                                getMediaUrl(donation.photo),
                                width: 48.0,
                                height: 48.0,
                              ),
                              title: Text(donation.title),
                              subtitle: Text(
                                donation.address.city +
                                    ', ' +
                                    donation.address.state,
                              ),
                            ),
                      )
                      .toList(),
                ));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 48.0,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'Nothing Available\nCheck back later!',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 24.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return Container(
            alignment: AlignmentDirectional.center,
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          );
        },
      ),
    );
  }

  Future<List<Donation>> getDonations() async {
    try {
      Response res = await apiGet('/api/donations');
      List<Donation> list = new List<Donation>();

      if (res.statusCode == 401) {
        Navigator.pushReplacement(
          context,
          pageRouteBuilderTo(LoginPage()),
        );
      } else if (res.statusCode == 200) {
        List<dynamic> resData = json.decode(res.body);
        resData.forEach((item) => list.add(Donation.fromJson(item)));
      }

      return list;
    } on Exception {
      networkError(context);
    }

    return new List<Donation>();
  }
}
