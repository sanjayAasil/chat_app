import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/user_model.dart';

class FirestoreService {
  //get collections of userModel

  final CollectionReference<Map<String, dynamic>> _userModelCollection = FirebaseFirestore.instance.collection('users');

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

  Future<UserModel> getUser(String userId) async {
    DocumentSnapshot doc = await _userModelCollection.doc(userId).get();
    return UserModel.fromJson(doc.data() as Map<String, dynamic>);
  }

//UPDATE

//DELETE
}
