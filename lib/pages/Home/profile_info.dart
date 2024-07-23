import 'package:chat_app/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Database/firestore_service.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  bool isLoaded = false;
  TextEditingController controller = TextEditingController();
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      user = await FirestoreService().getUser(FirebaseAuth.instance.currentUser!.uid);
      isLoaded = true;
      setState(() {});
    } catch (e) {
      print('erfyebrunrveruvb errror $e');
    }
  }

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
        child: isLoaded
            ? Column(
                children: [
                  SizedBox(height: const MediaQueryData().padding.top + 25),
                  Row(
                    children: [
                      IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back)),
                      const Text(
                        'Profile',
                        style: const TextStyle(fontSize: 20),
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
                    subTitle: user?.name ?? '',
                    isEdit: true,
                    postIcon: Icons.edit,
                  ),
                  _profileInfo(
                    preIcon: CupertinoIcons.info_circle,
                    title: 'About',
                    subTitle: user?.about ?? '',
                    isEdit: true,
                    postIcon: Icons.edit,
                  ),
                  _profileInfo(
                    preIcon: Icons.alternate_email_outlined,
                    title: 'Email',
                    subTitle: user?.email ?? '',
                    isEdit: true,
                    postIcon: Icons.edit,
                  ),
                  _profileInfo(
                    preIcon: CupertinoIcons.phone,
                    title: 'Phone',
                    subTitle: user?.phoneNumber ?? '',
                    isEdit: false,
                    postIcon: Icons.edit,
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  _editProfile({required String key}) {
    return showDialog(
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

  Widget _profileInfo({
    required String title,
    required String subTitle,
    bool isEdit = true,
    required IconData preIcon,
    required IconData postIcon,
  }) {
    return subTitle != ''
        ? ListTile(
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
                    onPressed: () => _editProfile(key: 'about'),
                    icon: Icon(postIcon, color: Colors.cyan.shade800),
                  )
                : const SizedBox(),
          )
        : const SizedBox();
  }

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
        return const SizedBox();
    }
  }
}
