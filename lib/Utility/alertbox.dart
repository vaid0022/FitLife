import "package:FitLife/Utility/custom.dart";
import "package:FitLife/ViewModel/provider.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class alert {
  static Future<void> AlertBox({required BuildContext context,required String title,required String Decre,required String btnText}) {
     final theme = Provider.of<ThemeProvider>(context,listen: false).Dark;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text(title),
          content: Text(Decre),
          actions: [
            customWidget.elevatedButton(
              callback: () {
                return Navigator.pop(context);
              },
              text: btnText,color:theme ?  Colors.blue :Colors.lightGreen,
            ),
          ],
        );
      },
    );
  }
}
