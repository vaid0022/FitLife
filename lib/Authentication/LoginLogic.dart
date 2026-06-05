import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitlife/Authentication/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:fitlife/home.dart';

class loginlogic {
  static Future<void> firebaseLogin({
    String? email,
    String? pass,
    required BuildContext context,
  }) async {
    UserCredential userCredential;

    try {
      if (email.toString().isNotEmpty && pass.toString().isNotEmpty) {
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.toString(),
          password: pass.toString(),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => home()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Please Fill requirment")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  static firebaseForgotpassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      if (email.isNotEmpty) {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email.toString(),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Please Fill requirment")));
      }
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}
