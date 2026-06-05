import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Fetchdata {

  Future<Map<String,dynamic>?> FetchUserData()async{
    final id =  FirebaseAuth.instance.currentUser!.uid;

    final snapshot = await FirebaseFirestore.instance
        .collection("User").doc(id).get();

    if(snapshot.exists){
       return snapshot.data();
    }else{
      log("User not found");
      return null;
    }
  }
}