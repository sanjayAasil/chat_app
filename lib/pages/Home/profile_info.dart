import 'package:chat_app/Database/DataManager.dart';
import 'package:chat_app/Models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Database/firestore_service.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  TextEditingController controller = TextEditingController();
  UserModel user = DataManager().user!;

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: const MediaQueryData().padding.top + 25),
                Row(
                  children: [
                    IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back)),
                    const Text(
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
                _profileInfo(
                  preIcon: CupertinoIcons.person,
                  title: 'Name',
                  subTitle: user.name,
                  isEdit: true,
                  postIcon: Icons.edit,
                  key: 'Name',
                ),
                _profileInfo(
                  preIcon: CupertinoIcons.info_circle,
                  title: 'About',
                  subTitle: user.about,
                  isEdit: true,
                  postIcon: Icons.edit,
                  key: 'About',
                ),
                _profileInfo(
                  preIcon: Icons.alternate_email_outlined,
                  title: 'Email',
                  subTitle: user.email ?? '',
                  isEdit: true,
                  postIcon: Icons.edit,
                  key: 'Email',
                ),
                _profileInfo(
                  preIcon: CupertinoIcons.phone,
                  title: 'Phone',
                  subTitle: user.phoneNumber,
                  isEdit: false,
                  postIcon: Icons.edit,
                  key: 'Phone',
                ),
              ],
            ),
          )),
    );
  }

  Future _editProfileDialog({required String key}) => showDialog(
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
                  child: _editProfileText(key: key),
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
                    TextButton(
                      onPressed: () {
                        controller.clear();
                        Navigator.of(context).pop();
                        setState(() {});
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        UserModel? updatedUser;
                        if (key == 'Name') {
                          updatedUser = user.copyWith(name: controller.text.trim());
                          FirestoreService().addUser(updatedUser);
                        } else if (key == 'About') {
                          updatedUser = user.copyWith(about: controller.text.trim());
                          FirestoreService().addUser(updatedUser);
                        } else {
                          updatedUser = user.copyWith(email: controller.text.trim());
                          FirestoreService().addUser(updatedUser);
                        }
                        controller.clear();
                        setState(() {});
                        Navigator.of(context).pop(updatedUser);
                      },
                      child: const Text('Save'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );

  Widget _profileInfo({
    required String key,
    required String title,
    required String subTitle,
    bool isEdit = true,
    required IconData preIcon,
    required IconData postIcon,
  }) =>
      ListTile(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        leading: Icon(preIcon),
        title: Text(title),
        subtitle: Text(subTitle),
        titleTextStyle: TextStyle(fontSize: 15, color: Colors.grey.shade700),
        subtitleTextStyle: const TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),
        trailing: isEdit
            ? IconButton(
                onPressed: () async {
                  UserModel? newUser = await _editProfileDialog(key: key);
                  if (newUser != null) {
                    setState(() {
                      user = newUser;
                    });
                  }
                },
                icon: Icon(postIcon, color: Colors.cyan.shade800),
              )
            : const SizedBox(),
      );

  Widget _editProfileText({required String key}) {
    switch (key) {
      case 'Name':
        return const Text(
          'Enter your name',
          style: TextStyle(
            fontSize: 20,
          ),
        );
      case 'About':
        return const Text(
          'Enter about here',
          style: TextStyle(
            fontSize: 20,
          ),
        );
      case 'Email':
        return const Text(
          'Enter Email here',
          style: TextStyle(
            fontSize: 20,
          ),
        );

      default:
        return const Text('check');
    }
  }
}
