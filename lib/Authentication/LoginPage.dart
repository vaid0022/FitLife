import 'dart:ui';

import 'package:fitlife/Authentication/LoginLogic.dart';
import 'package:fitlife/Authentication/Register.dart';
import 'package:fitlife/custom.dart';
import 'package:flutter/material.dart';

class loginpage extends StatelessWidget {
  @override
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login_res/loginblack.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(30),
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 600,
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 60, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 30),
                  customWidget.textField(
                    controller: emailcontroller,
                    istrue: false,
                    label: "Email",
                    icon: Icons.email,
                    lcolor: Colors.white,
                    scolor: Colors.white,
                    fontColor: Colors.white,
                  ),
                  SizedBox(height: 20),
                  customWidget.textField(
                    controller: passcontroller,
                    istrue: true,
                    label: "Password",
                    icon: Icons.password_outlined,
                    lcolor: Colors.white,
                    scolor: Colors.white,
                    fontColor: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Forgotpassword();
                            },
                          );
                        },
                        child: Text(
                          "Forgot Password??",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 400,
                    height: 40,
                    child: customWidget.elevatedButton(
                      callback: () {
                        loginlogic.firebaseLogin(
                          context: context,
                          email: emailcontroller.text.toString(),
                          pass: passcontroller.text.toString(),
                        );
                      },
                      text: "Login",
                      color: Colors.blue,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't  have account?",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 180),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Forgotpassword extends StatefulWidget {
  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController Fopass = TextEditingController();

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3 + MediaQuery.of(context).viewInsets.bottom,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.all(11),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Forgot Password",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 75),
            customWidget.textField(
              controller: Fopass,
              istrue: false,
              lcolor: Colors.white,
              label: "E-mail",
              scolor: Colors.white,
              icon: Icons.email_outlined,
              fontColor: Colors.white,
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 400,
              child: customWidget.elevatedButton(
                callback: () {
                  loginlogic.firebaseForgotpassword(
                    email: Fopass.text.toString(),
                    context: context,
                  );
                },
                text: "Forgot Password",
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
