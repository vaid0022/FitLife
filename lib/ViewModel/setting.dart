import 'package:fitlife/Utility/alertbox.dart';
import 'package:fitlife/ViewModel/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class settingLogic {
  static TextEditingController ConformController = TextEditingController();

  static passConform({required BuildContext context}) {
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
}
