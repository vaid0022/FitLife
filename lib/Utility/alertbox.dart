import "package:fitlife/Utility/custom.dart";
import "package:flutter/material.dart";

class alert {
  static Future<void> AlertBox({required BuildContext context,required String title,required String Decre,required String btnText}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(Decre),
          actions: [
            customWidget.elevatedButton(
              callback: () {
                return Navigator.pop(context);
              },
              text: btnText,color: Colors.blue,
            ),
          ],
        );
      },
    );
  }
}
