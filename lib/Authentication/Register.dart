import 'dart:ui';

import 'package:fitlife/Authentication/LoginPage.dart';
import 'package:fitlife/custom.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  @override
  TextEditingController usercontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image:AssetImage("assets/login_res/bigwhite.png"),
                fit: BoxFit.cover)
        ),
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(30),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 600,
              width: 350,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                      child: Text("Register", style: TextStyle(fontSize: 60,color: Colors.black))
                  ),
                  SizedBox(height: 50,),
                  customWidget.textField(
                      controller: usercontroller,
                      istrue: false,
                      label: "Username",
                      icon: Icons.supervised_user_circle_outlined,
                      lcolor: Colors.black,
                      scolor: Colors.black
                  ),
                  SizedBox(height: 20,),
                  customWidget.textField(
                      controller: emailcontroller,
                      istrue: false,
                      label: "Email",
                      icon: Icons.email,
                      lcolor: Colors.black,
                      scolor: Colors.black
                  ),
                  SizedBox(height: 20,),

                  customWidget.textField(
                      controller: passcontroller,
                      istrue: true,
                      label: "Password",
                      icon: Icons.password_outlined,
                      lcolor: Colors.black,
                      scolor: Colors.black
                  ),
                  SizedBox(height: 30,),
                  SizedBox(
                      width: 315,
                      height: 40,
                      child: customWidget.elevatedButton(callback: (){}, text:"Register",color: Colors.blue)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have account?",style: TextStyle(color: Colors.black,fontSize: 15),),
                      TextButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginpage()));
                      }, child: Text("Log In",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),)),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text("or",style:TextStyle(color: Colors.black,fontSize: 20),),
                  Divider(),
                  SizedBox(height: 5,),
                  SizedBox(
                    width: 315,
                    child: ElevatedButton(onPressed: (){},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white54
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/login_res/google.png",width: 30,),
                            SizedBox(width: 10,),
                            Text("Google",style: TextStyle(fontSize: 30),)
                          ],
                        )),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
