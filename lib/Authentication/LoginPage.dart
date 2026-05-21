import 'dart:ui';

import 'package:fitlife/Authentication/Register.dart';
import 'package:fitlife/custom.dart';
import 'package:flutter/material.dart';

class loginpage extends StatelessWidget
{
  @override
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(height: 30,),
                  customWidget.textField(
                    controller: emailcontroller,
                    istrue: false,
                    label: "Email",
                    icon: Icons.email,
                    lcolor: Colors.white,
                    scolor: Colors.white,
                  ),
                  SizedBox(height: 20,),
                  customWidget.textField(
                    controller: passcontroller,
                    istrue: true,
                    label: "Password",
                    icon: Icons.password_outlined,
                    lcolor: Colors.white,
                    scolor: Colors.white,
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
                      callback: () {},
                      text: "Login",
                      color: Colors.white70,
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

                  SizedBox(height: 10),
                  Text(
                    "OR",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Divider(
                    endIndent: 85,
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 240,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white54,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/login_res/google.png", width: 30),
                            SizedBox(width: 10),
                            Text("Google", style: TextStyle(fontSize: 30,color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Forgotpassword extends StatelessWidget {
  TextEditingController Fopass=TextEditingController();

  Widget build(BuildContext context) {
    return Container(
      height: 300,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Forgot Password",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
            SizedBox(height: 75,),
            customWidget.textField(controller: Fopass, istrue: false,label: "E-mail",icon: Icons.email,),
            SizedBox(height: 50,),
            SizedBox(
              width: 400,
                child: customWidget.elevatedButton(callback: (){}, text:"Forgot Password",color: Colors.black))
          ],
        ));
  }
}
