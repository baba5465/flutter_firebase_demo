import 'package:firebase_flutter/modals/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_tile.dart';

class DataList extends StatefulWidget {

  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  
  @override
  Widget build(BuildContext context) {

    final data = Provider.of<List<Data>>(context);
    
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index){
        return DataTile(data: data[index]);
      },
    );
  }
}