import 'dart:developer';
import 'package:chat_app/Firebase/firebase_auth.dart';
import 'package:chat_app/routes.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:versatile_dialogs/loading_dialog.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  String _countryCode = '';
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool isOtpSent = false;
  FirebaseAuthManager auth = FirebaseAuthManager();

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
            if (isOtpSent)
              const Text(
                'Enter Otp number',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.cyan),
                textAlign: TextAlign.center,
              )
            else
              const Text(
                'Enter your phone number',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.cyan),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 30),
            if (isOtpSent)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Otp sent to your mobile number',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'ChatApp will send an SMS message to verify your phone number. '
                  'Enter your country code and phone number.',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 20),
            if (isOtpSent)
              Row(
                children: [
                  const SizedBox(width: 90),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),
                        // Set max characters
                      ],
                    ),
                  ),
                  const SizedBox(width: 90),
                ],
              )
            else
              Row(
                children: [
                  CountryCodePicker(
                    onInit: (countryCode) {
                      _countryCode = '+91';
                      log(_countryCode);
                    },
                    onChanged: (countryCode) {
                      setState(() {
                        _countryCode = countryCode.dialCode!;
                        debugPrint('country code $_countryCode');
                      });
                    },
                    initialSelection: 'भारत',
                    showOnlyCountryWhenClosed: false,
                    favorite: const ['+91', 'IND'],
                  ),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      controller: phoneNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        // Set max characters
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            const Spacer(),
            if (isOtpSent)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _verifyOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _sendOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text(
                          'Send Otp',
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

  void _sendOtp() {
    if (phoneNumberController.text.trim().length < 10) return;
    LoadingDialog loadingDialog = LoadingDialog()..show(context);
    String phoneNumber = '$_countryCode${phoneNumberController.text.trim()}';
    auth.verifyPhoneNumber(
      phoneNumber,
      (verificationId, resendToken) {
        if (mounted) {
          loadingDialog.dismiss(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('OTP sent to $phoneNumber'), behavior: SnackBarBehavior.floating),
          );
        }
        setState(() {
          isOtpSent = true;
          auth.verificationId = verificationId;
        });
      },
      (verificationCompleted) {},
      (verificationFailed) {
        if (mounted) {
          loadingDialog.dismiss(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Verification failed: ${verificationFailed.message}'),
                behavior: SnackBarBehavior.floating),
          );
        }
      },
      (codeAutoRetrievalTimeout) {},
    );
  }

  void _verifyOtp() async {
    if (otpController.text.trim().length < 6) return;
    LoadingDialog loadingDialog = LoadingDialog()..show(context);
    String smsCode = otpController.text;
    await auth.signInWithPhoneNumber(smsCode);

    if (mounted) {
      loadingDialog.dismiss(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone number verified successfully'), behavior: SnackBarBehavior.floating),
      );
      Navigator.of(context).pushNamed(Routes.createProfile);
    }
  }
}
