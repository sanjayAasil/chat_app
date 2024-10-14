import 'package:chat_app/Database/firestore_service.dart';
import 'package:chat_app/Models/message_model.dart';
import 'package:chat_app/pages/Common/message_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Models/user_model.dart';

class ChatRoom extends StatefulWidget {
  final String userId;

  const ChatRoom({super.key, required this.userId});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    firestoreService.getMessages(
      currentUserId: FirebaseAuth.instance.currentUser!.uid,
      receiverUserId: widget.userId,
    );
    _fetchUser();
  }

  _fetchUser() async {
    user = await FirestoreService().getUser(widget.userId);
    setState(() {});
  }

  final TextEditingController _messageController = TextEditingController();
  FirestoreService firestoreService = FirestoreService();
  UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user?.name ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'last seen at 10:23 pm',
              style: TextStyle(
                fontSize: 15,
              ),
            )
          ],
        ),
        actions: [
          const Icon(Icons.videocam_outlined),
          const SizedBox(width: 15),
          const Icon(Icons.phone_outlined),
          _popUpMenuButton(),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.cyan,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: firestoreService.messageStreamController.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No messages yet.'));
                  } else {
                    List<MessageModel> messages = snapshot.data!;
                    WidgetsBinding.instance.addPostFrameCallback((callback) {
                      print('hevuw vh vh ehrv ev ${messages.length}');
                      _scrollToBottom();
                    });
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return Align(
                            alignment: message.senderId == widget.userId ? Alignment.centerLeft : Alignment.centerRight,
                            child: MessageTile(message: message));
                      },
                    );
                  }
                },
              ),
            ),
            _bottomWidget(),
          ],
        ),
      ),
    );
  }

  Widget _popUpMenuButton() => PopupMenuButton(
        onSelected: (String value) {
          setState(() {});
        },
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'New Group',
              child: Text('New Group'),
            ),
            const PopupMenuItem<String>(
              value: 'New broadcast',
              child: Text('New broadcast'),
            ),
            const PopupMenuItem<String>(
              value: 'Linked Devices',
              child: Text('Linked Devices'),
            ),
            const PopupMenuItem<String>(
              value: 'Starred messages',
              child: Text('Starred messages'),
            ),
            const PopupMenuItem<String>(
              value: 'Payments',
              child: Text('Payments'),
            ),
            const PopupMenuItem<String>(
              value: 'Settings',
              child: Text('Settings'),
            ),
          ];
        },
      );

  Widget _bottomWidget() => Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                height: 40,
                width: double.infinity,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.emoji_emotions_outlined),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Message',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.attach_file),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt_outlined),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: _sendMessage,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.cyan,
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10)
        ],
      );

  _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    firestoreService.createMessage(
      message: _messageController.text.trim(),
      senderId: FirebaseAuth.instance.currentUser!.uid,
      receiverId: widget.userId,
    );
    _messageController.clear();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }
}
