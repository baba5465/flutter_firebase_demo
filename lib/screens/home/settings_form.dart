import 'package:firebase_flutter/modals/user.dart';
import 'package:firebase_flutter/services/database.dart';
import 'package:firebase_flutter/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  SettingsForm({Key key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

// form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your data',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: userData.name,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400],
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400],
                        width: 2.0,
                      ),
                    ),
                  ),
                  obscureText: true,
                  validator: (val) =>
                      val.isEmpty ? 'Please enter the name' : null,
                  onChanged: (val) {
                    setState(() {
                      _currentName = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400],
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400],
                        width: 2.0,
                      ),
                    ),
                  ),
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _currentSugars = val;
                    });
                  },
                ),
                Slider(
                  value: (_currentStrength ?? userData.strength),
                  activeColor:
                      Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor:
                      Colors.brown[_currentStrength ?? userData.strength],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) {
                    setState(() {
                      _currentStrength = val.round();
                    });
                  },
                ),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength,
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
