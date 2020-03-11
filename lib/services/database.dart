import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/modals/data.dart';
import 'package:firebase_flutter/modals/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});
  // Step 1 : Creating a collection reference

  final CollectionReference dbCollection =
      Firestore.instance.collection('userData');

  // Step 2 : Create a function to update the value

  Future updateUserData(String sugars, String name, int strenght) async {
    return await dbCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strenght,
    });
  }

  // Get database stream

  Stream<List<Data>> get data {
    return dbCollection.snapshots().map(_dataListFromDatabase);
  }

  // Get List from snapshot

  List<Data> _dataListFromDatabase(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Data(
        name: doc.data['name'] ?? '',
        sugars: doc.data['sugars'] ?? '0',
        strength: doc.data['strenght'] ?? 0,
      );
    }).toList();
  }

  // User data from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      strength: snapshot.data['strength'],
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
    );
  }
  // Get user data stream

  Stream<UserData> get userData {
    return dbCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
