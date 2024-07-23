import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile name',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
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
                stream: null,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                        const ListTile(
                  title: Text('check'),
                ),
              ),
            ),
            const Spacer(),
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

  }
}
