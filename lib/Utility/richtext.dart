import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class richText extends StatelessWidget {
  String text1;
  double? text1Size;
  double? text2Size;
  String? text2;
  Color? color1;
  Color? color2;

  richText({
    super.key,
    required this.text1,
     this.text2,
     this.text1Size,
     this.text2Size,
     this.color1,
     this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text1,
        style: TextStyle(fontSize: text1Size, fontWeight: FontWeight.bold,color: color1),
        children: [
          TextSpan(
              text: text2,
            style: TextStyle(fontSize: text2Size,color: color2,fontWeight: FontWeight.w100),
          )],
      ),
    );
  }
}
