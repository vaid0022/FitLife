import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitlife/Reposetory/Firebase/FireStore/Fetchdata.dart';
import 'package:fitlife/View/LoginPage.dart';
import 'package:fitlife/custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fitlife"),
        actions: [
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
          SizedBox(height: 20),

          // UserInfo
          user(),

          // Bmi Calculator
          BmiCalculator(),

          Container(
            height: 176,
            width: double.infinity,
            color: Colors.black,
            child: Center(
              child: Text(
                "Information about app",
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class user extends StatelessWidget {
  @override
  final Fetchdata userinfo = Fetchdata();
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<Map<String, dynamic>?>(
        future: userinfo.FetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text("error");
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Text("data not found");
          }
          var userdata = snapshot.data;

          return Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Welcome to Fit Life!  ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${userdata!["name"].toString().trim() ?? ""},",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Your fitness journey starts here."),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: double.infinity,
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Center(
              child: Text(
                "Bmi Calculator",
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: customWidget.textField(
                controller: heightController,
                istrue: false,
                label: "Enter your height",
                fontColor: Colors.white,
                icon: Icons.height,
                lcolor: Colors.white,
                scolor: Colors.white,
                stext: "Foot"
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: customWidget.textField(
                controller: weightController,
                istrue: false,
                label: "Enter your weight",
                fontColor: Colors.white,
                icon: Icons.monitor_weight_outlined,
                lcolor: Colors.white,
                scolor: Colors.white,
                stext: "Kg"
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 500,
                child: customWidget.elevatedButton(
                  callback: () {},
                  text: "Calculate your BMI",
                  color: Colors.lightBlueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
