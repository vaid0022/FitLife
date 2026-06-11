import 'package:flutter/cupertino.dart';

class textpadding{

  static Widget TextPadding({
    required double padding,
    required String text,
    required bool isBold,
    double? fontSize,
    int? lines,
    required bool isLines,
  }){
    return Padding(
        padding: EdgeInsetsGeometry.all(padding),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight(1),
            fontSize: fontSize,
          ),
          maxLines: lines,
          overflow:isLines == true ? TextOverflow.ellipsis : null,
        ));
  }
}
