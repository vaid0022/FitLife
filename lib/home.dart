import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitlife/Authentication/LoginPage.dart';
import 'package:fitlife/Notification.dart';
import 'package:fitlife/custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Notification : ${message.notification!.title}"),
          duration: Duration(seconds: 10),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fitlife"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>notification()));
          }, icon: Icon(Icons.notifications)),
          customWidget.elevatedButton(
            callback: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => loginpage()),
                );
              });
            },
            text: "Log Out",
            color: Colors.blue,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 225,
            width: double.infinity,
            color: Colors.blue,child: Center(child: Text("User Information",style: TextStyle(color: Colors.white,fontSize: 50),),),
          ),
          Expanded(
            child: Container(
              height: 176,
              width: double.infinity,
              color: Colors.redAccent,
              child: Center(child: Text("Bmi Calculator",style: TextStyle(color: Colors.white,fontSize: 50),),),
            ),
          ),
        Container(
          height: 176,
          width: double.infinity,
          color: Colors.black,
          child: Center(child: Text("Information about app",style: TextStyle(color: Colors.white,fontSize: 50),),),
        ),
        Container(
          height: 90,
          width: double.infinity,
          color: Colors.tealAccent,
          child: Center(child: Text("bottom navigation bar",style: TextStyle(color: Colors.white,fontSize: 50),),),
        ),

        ],
      ),
    );
  }
}
