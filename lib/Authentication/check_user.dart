import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitlife/Authentication/LoginPage.dart';
import 'package:fitlife/home.dart';
import 'package:flutter/material.dart';

class checkuser extends StatelessWidget {
  const checkuser({super.key});

  @override
  Widget build(BuildContext context) {
    return user();
  }
  Widget user()
  {
    final User? user=FirebaseAuth.instance.currentUser;
    if(user !=null)
    {
      return home();
    }else{
      return loginpage();
    }
  }
}
