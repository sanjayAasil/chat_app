import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthMananger {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> requestOTP(
    BuildContext context,
    String phoneNumber,
    Function(String verificationId, int? forceResendingToken) onCodeSent,
  ) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          //Auto-retrieved verification completed
          await auth.signInWithCredential(phoneAuthCredential);
          debugPrint("FirebaseAuthManager requestOTP: verificationCompleted");
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: SnackBar(
              content: Text(' ${e.message}'),
            )),
          );
        },
        codeSent: onCodeSent,
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;

          //timeout for auto phone resolution
        },
      );
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SnackBar(
              content: Text(' ${e.message}'),
            ),
          ),
        );
      }
    }
  }

  Future<User?> signInWithOtp(
      BuildContext context, String otp, String verificationId) async {
    try {
      debugPrint("FirebaseAuthManager signInWithOtp: check $verificationId");
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      debugPrint("FirebaseAuthManager signInWithOtp: chec");

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      debugPrint("FirebaseAuthManager signInWithOtp: $credential");
      return userCredential.user;
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SnackBar(
              content: Text(' ${e.message}'),
            ),
          ),
        );
      }

      return null;
    }
  }
}
