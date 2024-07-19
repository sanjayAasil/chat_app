import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  String _countryCode = '';
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();

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
            SizedBox(height: MediaQuery.of(context).padding.top + 10),
            const Text(
              'Enter your phone number',
              style: TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'ChatApp will send an SMS message to verify your phone number. '
                'Enter your country code and phone number.',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: [
                CountryCodePicker(
                  onChanged: (countryCode) {
                    setState(() {
                      _countryCode = countryCode.dialCode!;
                      debugPrint('country code $_countryCode');
                    });
                  },
                  initialSelection: 'भारत',
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  favorite: const ['+91', 'IND'],
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Phone number'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        'Next',
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
}
