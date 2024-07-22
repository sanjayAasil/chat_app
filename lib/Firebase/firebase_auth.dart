import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = '';

  Future<void> verifyPhoneNumber(
    String phoneNumber,
    PhoneCodeSent codeSent,
    PhoneVerificationCompleted verificationCompleted,
    PhoneVerificationFailed verificationFailed,
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
  ) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: (String verificationId, int? resendToken) {
        codeSent(verificationId, resendToken);
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<User> signInWithPhoneNumber(String smsCode) async {
    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    User user = userCredential.user!;
    return user;
  }

  Future<void> signOut() async => FirebaseAuth.instance.signOut();
}
