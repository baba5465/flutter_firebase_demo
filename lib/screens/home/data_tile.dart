import 'package:firebase_flutter/modals/data.dart';
import 'package:flutter/material.dart';

class DataTile extends StatelessWidget {
  final Data data;
  DataTile({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.brown[data.strength],
            ),
            title: Text(data.name),
            subtitle: Text('Take ${data.sugars} sugar(s)'),
          ),
        ),
      ),
    );
  }
}
