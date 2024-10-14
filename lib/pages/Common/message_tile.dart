import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Models/message_model.dart';

class MessageTile extends StatelessWidget {
  final MessageModel message;

  const MessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (message.senderId == FirebaseAuth.instance.currentUser!.uid)
          Text(
            DateFormat('hh:mm a').format(message.timeStamp),
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: message.senderId == FirebaseAuth.instance.currentUser!.uid ? Colors.cyan : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '  ${message.message}  ',
            style: const TextStyle(fontSize: 18),
          ),
        ),
        if (message.senderId != FirebaseAuth.instance.currentUser!.uid)
          Text(
            DateFormat('hh:mm a').format(message.timeStamp),
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
      ],
    );
  }
}
