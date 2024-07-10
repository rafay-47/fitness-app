// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String errormessage = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieve verification code
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // Verification failed
      },
      codeSent: (String verificationId, int? resendToken) async {
        // Save the verification ID for future use
        String smsCode = 'xxxxxx'; // Code input by the user
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        );
        // Sign the user in with the credential
        await _auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {

    TextEditingController phoneNoController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   toolbarHeight: deviceHeight * 0.07,
      //   backgroundColor: Colors.black,
      //   title: const Text(
      //     "App Name",
      //     style: TextStyle(
      //       color: Color.fromARGB(255, 74, 74, 75),
      //       fontSize: 28.0,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                    height: deviceHeight * 0.4,
                    width: deviceWidth,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/login_bg.jpg'),
                        fit: BoxFit.cover,
                      ),
                     
                    ),
                ),
                
                Container(
                  height: deviceHeight * 0.4,
                  width: deviceWidth,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)
                  ),
                  child: const Align(
                    alignment: Alignment.bottomCenter,
                    child: Text("App name"
                    ,style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
            Container(
              padding: const EdgeInsets.all(20.0),
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1940469323.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 34.0),
                  TextFormField(
                    controller: phoneNoController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      labelStyle: TextStyle(color: Colors.grey),
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.mail, color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Sets the border color when focused
                        ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    
                  ),
                  const SizedBox(height: 26.0),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.grey),
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Sets the border color when focused
                        ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RawMaterialButton(
                      onPressed: () {
                        //   Navigator.of(context).pushReplacement(
                        //         MaterialPageRoute(builder: (context)=> const ForgotPasswordPage()));
                      },
                      child: const Text(
                        "Forgot Your Password?",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  if (errormessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        errormessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  SizedBox(
                    width: double.infinity,
                    child: RawMaterialButton(
                      fillColor: const Color.fromARGB(255, 14, 167, 255),
                      elevation: 5.0,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () async {
                        await verifyPhoneNumber(phoneNoController.text);

                        // if (user != null) {
                        //   Navigator.of(context).pushReplacement(
                        //     MaterialPageRoute(builder: (context) => const HomeScreen()),
                        //   );
                        // }
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        "Already have an account? Sign In",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ]
              )
            )
          ],
        ),
      ),
    );
  }
}
