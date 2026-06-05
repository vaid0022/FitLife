import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitlife/View/home.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class registerLogic {
  static FirebaseRegister({
    required String username,
    required String email,
    required String pass,
    required BuildContext context,
  }) async {
    UserCredential userCredential;

    try {

      if (username.isNotEmpty && email.isNotEmpty && pass.isNotEmpty) {

          userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: pass);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home()));

          final user = userCredential.user;

          FirebaseFirestore.instance.collection("User").doc(user! .uid).set(
              {
                "name" : username,
                "email" : user.email,
                'uid' : user.uid,
                'createAt' : DateTime.now().toIso8601String()
              }).then((_){
            log(" register successfully");
          });

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please Enter email in right format")),
          );
        }

    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  static FirebaseSigupWithGoogle({required BuildContext context}) async {
    String webClientId =
        "25080661999-ns0cq28hae6f39etc9aetniarif7dg78.apps.googleusercontent.com";

    try {
      GoogleSignIn googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize(serverClientId: webClientId);

      GoogleSignInAccount account = await googleSignIn.authenticate();

      GoogleSignInAuthentication GoogleAuth = account.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: GoogleAuth.idToken,
      );

      FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}
