import 'dart:async';
import 'package:chat_app/Models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/user_model.dart';

class FirestoreService {
  final StreamController<List<MessageModel>> messageStreamController = StreamController<List<MessageModel>>();

  ///get collections of userModel

  final CollectionReference<Map<String, dynamic>> _userModelCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference<Map<String, dynamic>> _messageCollection =
      FirebaseFirestore.instance.collection('messages');

  ///CREATE

  Future<void> addUser(UserModel user) async => await _userModelCollection.doc(user.userId).set(user.toJson());

  Future<void> createMessage({
    required String message,
    required String senderId,
    required String receiverId,
  }) async {
    try {
      MessageModel messageModel = MessageModel(
        message: message,
        senderId: senderId,
        receiverId: receiverId,
      );
      _messageCollection.doc().set(messageModel.toJson());
    } catch (e) {
      throw Exception('Error');
    }
  }

  ///READ

  Future<UserModel> getUser(String userId) async {
    DocumentSnapshot doc = await _userModelCollection.doc(userId).get();
    return UserModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> users = [];

    QuerySnapshot querySnapshot = await _userModelCollection.get();

    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    for (var doc in documents) {
      users.add(UserModel.fromJson(doc.data() as Map<String, dynamic>));
    }
    return users;
  }

  void getMessages({required String currentUserId, required String receiverUserId}) {
    _messageCollection.orderBy('timeStamp', descending: false).snapshots().listen((snapshot) {
      List<MessageModel> allMessages = snapshot.docs.map((doc) {
        return MessageModel.fromJson(doc.data());
      }).where((message) {
        return (message.senderId == currentUserId && message.receiverId == receiverUserId) ||
            (message.senderId == receiverUserId && message.receiverId == currentUserId);
      }).toList();

      // Sort messages by timestamp in ascending order (oldest to newest)
      allMessages.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));

      // Add sorted messages to the stream
      messageStreamController.sink.add(allMessages);
    });
  }

//UPDATE

//DELETE
}
