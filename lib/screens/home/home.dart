import 'package:firebase_flutter/modals/data.dart';
import 'package:firebase_flutter/services/auth.dart';
import 'package:firebase_flutter/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_list.dart';


class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Data>>.value(
      value: DatabaseService().data,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Firebase'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('Logout'),
            ),
          ],
        ),
        body: DataList(),
      ),
    );
  }
}
