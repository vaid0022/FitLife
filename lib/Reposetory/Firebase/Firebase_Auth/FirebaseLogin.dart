import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitlife/Reposetory/Firebase/Firebase_Auth/check_user.dart';
import 'package:fitlife/Utility/alertbox.dart';
import 'package:fitlife/View/home.dart';
import 'package:fitlife/ViewModel/navifationbar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
          MaterialPageRoute(builder: (context) => bottomnavigationabar()),
        );
      } else {
        alert.AlertBox(context: context, title: "Error", Decre: "Please enter right information", btnText: "OK");

      }
    } catch (e) {
      alert.AlertBox(context: context, title: "Error", Decre: "Error: ${e.toString()}", btnText: "OK");

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
        alert.AlertBox(context: context, title: "Error", Decre: "Please enter right information", btnText: "OK");

      }
    } catch (error) {
      alert.AlertBox(context: context, title: "Error", Decre: "Error: ${error.toString()}", btnText: "OK");
    }
  }

  //=============== Google SignIN ======================

  // static FirebaseSigupWithGoogle({required BuildContext context}) async {
  //   String webClientId =
  //       "25080661999-ns0cq28hae6f39etc9aetniarif7dg78.apps.googleusercontent.com";
  //
  //   try {
  //     GoogleSignIn googleSignIn = GoogleSignIn.instance;
  //
  //     await googleSignIn.initialize(serverClientId: webClientId);
  //
  //     GoogleSignInAccount account = await googleSignIn.authenticate();
  //
  //     GoogleSignInAuthentication GoogleAuth = account.authentication;
  //
  //     final credential = GoogleAuthProvider.credential(
  //       idToken: GoogleAuth.idToken,
  //     );
  //
  //     await FirebaseAuth.instance.signInWithCredential(credential).then(((_){
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>checkuser()));
  //     }));
  //
  //     if(account == null){
  //       return;
  //     }
  //   } catch (error) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text(error.toString())));
  //   }
  // }
}
