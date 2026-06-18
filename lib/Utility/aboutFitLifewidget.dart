import 'package:fitlife/Utility/textpadding.dart';
import 'package:flutter/cupertino.dart';

class fitLife {
  static Widget InfoOption({
    required String image,
    required String title,
    required String description,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),SizedBox(height: 10,),
          textpadding.TextPadding(
            padding: 2,
            text: title,
            isBold: true,
            isLines: false,
            fontSize: 18,
          ),
          textpadding.TextPadding(
            padding: 2,
            text: description,
            isBold: false,
            isLines: false,
            fontSize: 16,
          ),
        ],
      ),
    );
  }
}
