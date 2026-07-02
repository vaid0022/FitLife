import 'package:FitLife/Reposetory/Firebase/Firebase_Auth/FirebaseLogin.dart';
import 'package:FitLife/Utility/alertbox.dart';
import 'package:FitLife/Utility/custom.dart';
import 'package:FitLife/View/Register.dart';
import 'package:FitLife/ViewModel/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              height: 1000,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),

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
                    lcolor: Colors.black,
                    scolor: Colors.black,
                    fontColor: Colors.black,
                    fillColor: Colors.white
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 380,
                    child: customWidget.textField(
                      controller: passcontroller,
                      istrue: true,
                      label: "Password",
                      icon: Icons.password_outlined,
                      lcolor: Colors.black,
                      scolor: Colors.black,
                      fontColor: Colors.black,
                      fillColor: Colors.white
                    ),
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
                      SizedBox(width: 80,)
                    ],
                  ),
                  SizedBox(
                    width: 280,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 50,),
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
                  SizedBox(height: 500),
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
              lcolor: Colors.black,
              label: "E-mail",
              scolor: Colors.black,
              icon: Icons.email,
              fontColor: Colors.black,
              fillColor: Colors.white
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
