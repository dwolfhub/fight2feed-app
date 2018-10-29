import 'dart:convert';

import 'package:fight2feed/models/donation.dart';
import 'package:fight2feed/screens/donation.dart';
import 'package:fight2feed/util/api.dart';
import 'package:fight2feed/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Donations"),
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
      body: FutureBuilder<List<Donation>>(
        future: getDonations(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Donation>> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data
                  .map(
                    (Donation donation) => ListTile(
                          onTap: () async {
                            final result =
                                await Navigator.of(this.context).push(
                              new PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 250),
                                  pageBuilder: (BuildContext context, _, __) =>
                                      new DonationPage(donation: donation,),
                                  transitionsBuilder: (_,
                                      Animation<double> animation,
                                      __,
                                      Widget child) {
                                    return new SlideTransition(
                                      child: child,
                                      position: new Tween<Offset>(
                                        begin: const Offset(1.0, 0.0),
                                        end: Offset.zero,
                                      ).animate(animation),
                                    );
                                  }),
                            );

                            if (result != null)
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text("$result")));
                          },
                          trailing: Icon(Icons.chevron_right),
                          leading: Image.network(
                            getMediaUrl(donation.photo),
                            width: 48.0,
                            height: 48.0,
                          ),
                          title: Text(donation.title),
                          subtitle: Text(donation.description),
                        ),
                  )
                  .toList(),
            );
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

      List<dynamic> resData = json.decode(res.body);

      if (res.statusCode == 200) {
        resData.forEach((item) => list.add(Donation.fromJson(item)));
      }

      return list;
    } on Exception {
      networkError(context);
    }

    return new List<Donation>();
  }
}
