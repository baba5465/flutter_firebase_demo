import 'package:firebase_flutter/modals/data.dart';
import 'package:firebase_flutter/screens/home/settings_form.dart';
import 'package:firebase_flutter/services/auth.dart';
import 'package:firebase_flutter/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: SettingsForm(),
            );
          });
    }

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
            FlatButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(Icons.settings),
              label: Text('settings'),
            ),
          ],
        ),
        body: DataList(),
      ),
    );
  }
}
