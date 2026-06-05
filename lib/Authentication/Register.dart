import 'dart:ui';

import 'package:fitlife/Authentication/LoginPage.dart';
import 'package:fitlife/Authentication/RegisterLogic.dart';
import 'package:fitlife/custom.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  TextEditingController usercontroller = TextEditingController();

  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passcontroller = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children:[
          Positioned.fill(
              child:Image.asset(
                "assets/login_res/bigwhite.png",
                fit: BoxFit.cover,
              )
          ),
           SafeArea(
             child:  Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 700,
                  child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Register",
                                  style: TextStyle(fontSize: 60, color: Colors.black),
                                ),
                              ),
                              SizedBox(height: 50),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  width: 270,
                                  child: customWidget.textField(
                                    controller: usercontroller,
                                    istrue: false,
                                    label: "Username",
                                    icon: Icons.supervised_user_circle_outlined,
                                    lcolor: Colors.black,
                                    scolor: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  width: 350,
                                  child: customWidget.textField(
                                    controller: emailcontroller,
                                    istrue: false,
                                    label: "Email",
                                    icon: Icons.email,
                                    lcolor: Colors.black,
                                    scolor: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),

                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  width: 400,
                                  child: customWidget.textField(
                                    controller: passcontroller,
                                    istrue: true,
                                    label: "Password",
                                    icon: Icons.password_outlined,
                                    lcolor: Colors.black,
                                    scolor: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              SizedBox(
                                width: 315,
                                height: 40,
                                child: customWidget.elevatedButton(
                                  callback: () {
                                    registerLogic.FirebaseRegister(
                                      username: usercontroller.text.toString(),
                                      email: emailcontroller.text.toString(),
                                      pass: passcontroller.text.toString(),
                                      context: context,
                                    );
                                  },
                                  text: "Register",
                                  color: Colors.blue,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have account?",
                                    style: TextStyle(color: Colors.black, fontSize: 15),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => loginpage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Log In",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                "or",
                                style: TextStyle(color: Colors.black, fontSize: 20),
                              ),
                              Divider(),
                              SizedBox(height: 5),
                              SizedBox(
                                width: 315,
                                child: ElevatedButton(
                                  onPressed: () {

                                    registerLogic.FirebaseSigupWithGoogle(context: context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white54,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/login_res/google.png", width: 30),
                                      SizedBox(width: 10),
                                      Text("Google", style: TextStyle(fontSize: 30)),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
        ]
      ),
    );
  }
}
