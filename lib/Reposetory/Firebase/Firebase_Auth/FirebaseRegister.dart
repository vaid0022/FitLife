import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitlife/Utility/alertbox.dart';
import 'package:fitlife/View/home.dart';
import 'package:fitlife/ViewModel/navifationbar.dart';
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>bottomnavigationabar()));

          final user = userCredential.user;

          FirebaseFirestore.instance.collection("User").doc(user!.uid).set(
              {
                "name" : username,
                "email" : user.email,
                "password" : pass,
                'uid' : user.uid,
                'createAt' : DateTime.now().toIso8601String()
              }).then((_){
            log(" register successfully");
          });

        } else {
          alert.AlertBox(context: context, title: "Error", Decre: "Please enter right information", btnText: "OK");
        }

    } catch (error) {
      alert.AlertBox(context: context, title: "Error", Decre: "Error: ${error.toString()}", btnText: "OK");

    }
  }

}
