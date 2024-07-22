import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.cyan, Colors.white],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQueryData().padding.top + 25),
            Row(
              children: [
                IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.arrow_back)),
                Text(
                  'Profile',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            const SizedBox(height: 30),
            Icon(
              CupertinoIcons.profile_circled,
              size: 100,
              color: Colors.grey.shade700,
            ),
            const SizedBox(height: 30),
            ListTile(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              leading: const Icon(CupertinoIcons.person),
              title: const Text('Name'),
              subtitle: const Text('Sanjay'),
              titleTextStyle: TextStyle(fontSize: 15, color: Colors.grey.shade700),
              subtitleTextStyle: const TextStyle(fontSize: 17, color: Colors.black),
              trailing: IconButton(
                onPressed: () {
                  _editProfile(key: 'name');
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.cyan.shade800,
                ),
              ),
            ),
            ListTile(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              leading: const Icon(CupertinoIcons.info_circle),
              title: const Text('About'),
              subtitle: const Text('Just believe, Every thing happens for a reason'),
              titleTextStyle: TextStyle(fontSize: 15, color: Colors.grey.shade700),
              subtitleTextStyle: const TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
              trailing: IconButton(
                onPressed: () {
                  _editProfile(key: 'about');
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.cyan.shade800,
                ),
              ),
            ),
            ListTile(
              // visualDensity: VisualDensity.adaptivePlatformDensity,
              leading: const Icon(CupertinoIcons.phone),
              title: const Text('Phone'),
              subtitle: const Text('123456789'),
              titleTextStyle: TextStyle(fontSize: 15, color: Colors.grey.shade700),
              subtitleTextStyle: const TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _editProfile({required String key}) => showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.cyan,
                  Colors.white,
                ],
              ),
            ),
            height: 150,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: key == 'name'
                      ? const Text(
                          'Enter your name',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      : const Text(
                          'Enter about here',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Expanded(
                    child: Expanded(
                      child: TextField(
                        controller: controller,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
                    TextButton(onPressed: () {}, child: const Text('Save')),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
