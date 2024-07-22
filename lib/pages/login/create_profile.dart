import 'package:chat_app/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:versatile_dialogs/loading_dialog.dart';

import '../../Database/firestore_service.dart';
import '../../Models/user_model.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.cyan.shade300, Colors.white],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 20),
            const Text(
              'Profile Info',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.cyan),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Please provide your name and email',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            Icon(
              CupertinoIcons.profile_circled,
              size: 100,
              color: Colors.cyan.shade700,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              width: 250,
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name*',
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              width: 250,
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: _finishButton,
                      child: const Text(
                        'Finish',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _finishButton() async {
    if (nameController.text.trim().isEmpty) return;
    LoadingDialog loadingDialog = LoadingDialog()..show(context);
    User user = FirebaseAuth.instance.currentUser!;
    UserModel userModel = UserModel(
      userId: user.uid,
      name: nameController.text.trim(),
      phoneNumber: user.phoneNumber!,
      lastSeen: DateTime.now(),
      email: emailController.text.trim(),
    );
    await FirestoreService().addUser(userModel);

    if (mounted) {
      loadingDialog.dismiss(context);
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.mainScreen, (Route<dynamic> mainScreen) => false);
    }
  }
}
