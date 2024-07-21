import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle(),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.camera)),
          _popUpMenuButton(),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) => ListTile(
              leading: const Icon(
                CupertinoIcons.profile_circled,
                size: 30,
              ),
              title: Text('Name $index'),
              subtitle: Text('SubTitle $index'),
              trailing: Text('10:$index'),
            ),
          ),
          Container(
            color: Colors.grey,
          ),
          Container(
            color: Colors.black12,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.chat), label: 'Chats'),
          NavigationDestination(
              icon: Icon(Icons.history_toggle_off_outlined), label: 'Updates'),
          NavigationDestination(
              icon: Icon(Icons.phone_outlined), label: 'Calls'),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
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

  Widget _appBarTitle() => ShaderMask(
        shaderCallback: (bounds) {
          return const LinearGradient(
            colors: [Colors.cyan, Colors.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          );
        },
        child: const Text(
          'ChatApp',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white, // The color must be white to show the gradient
          ),
        ),
      );
}
