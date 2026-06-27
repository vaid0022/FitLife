import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitlife/Utility/alertbox.dart';
import 'package:fitlife/Utility/custom.dart';
import 'package:fitlife/View/LoginPage.dart';
import 'package:fitlife/ViewModel/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class settingLogic {
  static TextEditingController ConformController = TextEditingController();
  static UserCredential? userCredential;

  static passConform({required BuildContext context}) {
    final theme = Provider.of<ThemeProvider>(context, listen: false).Dark;

    final userPass = Provider.of<CurrentUserProvider>(
      context,
      listen: false,
    ).currentUser!.password;
    if (ConformController.text.toString().isEmpty) {
      return alert.AlertBox(
        context: context,
        title: "Error",
        Decre: "Fill the Folowing Filed",
        btnText: "OK",
      );
    } else {
      if (ConformController.text.toString() == userPass) {
        alert.AlertBox(
          context: context,
          title: "CONFORM",
          Decre: "Your Password is Up to Date",
          btnText: "ok",
        );
      } else {
        alert.AlertBox(
          context: context,
          title: "Error",
          Decre: "Somthing went wrong you password dosen't match ",
          btnText: "ok",
        );
      }
    }
  }

  static Conformation({required BuildContext context, required bool isDelete}) {
    final theme = Provider.of<ThemeProvider>(context, listen: false).Dark;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text("Conformation"),
          content: isDelete
              ? Row(
                  children: [
                    Icon(Icons.warning, color: Colors.red),
                    Text(
                      "Are you sure you want to delete your account",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Icon(Icons.warning, color: Colors.red),
                    Text(
                      "Are you sure you want to Logout your account",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
          actions: [
           isDelete ? customWidget.elevatedButton(
              callback: () async {
                await deleteAccount().then((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => loginpage()),
                  );
                });
                ;
              },
              text: "YES",
              color: theme ? Colors.lightBlueAccent : Colors.lightGreen,
            ): customWidget.elevatedButton(
              callback: () async {
                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => loginpage()),
                  );
                });
              },
              text: "YES",
              color: theme ? Colors.lightBlueAccent : Colors.lightGreen,
            ),
            customWidget.elevatedButton(
              callback: () {
                Navigator.pop(context);
              },
              text: "NO",
              color: Colors.red,
            ),
          ],
        );
      },
    );
  }

  static Future<void> deleteAccount() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print("No user login..");
        return;
      }
      await user.delete();

      await FirebaseAuth.instance.signOut();

      print("account delete successfully");
    } catch (e) {
      print("Setting Deleteing Error = $e");
    }
  }
}
