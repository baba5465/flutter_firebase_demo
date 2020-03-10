import 'package:cloud_firestore/cloud_firestore.dart';

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
}
