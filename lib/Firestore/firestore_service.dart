import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/user_model.dart';

class FirestoreService {
  //get collections of userModel

  final CollectionReference<Map<String, dynamic>> _userModelCollection =
      FirebaseFirestore.instance.collection('UserModels');

//CREATE

  Future<void> addUser(UserModel user) async {
    try {
      await _userModelCollection.doc(user.userId).set(user.toJson());
      print('User added successfully');
    } catch (e) {
      print('Failed to add user: $e');
    }
  }
//READ

//UPDATE

//DELETE
}
