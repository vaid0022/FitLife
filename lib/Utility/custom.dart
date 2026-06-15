import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customWidget {
  static Widget textField({
    required TextEditingController controller,
    String? label,
    String? stext,
    IconData? icon,
    required bool istrue,
    Color? lcolor,
    Color? scolor,
    Color? fontColor,
    Color? fillColor,
    TextInputType? keyboard,
  }) {
    return TextField(
      style: TextStyle(color: fontColor),
      obscureText: istrue,
      controller: controller,
      keyboardType:keyboard ,
      scrollPadding: EdgeInsets.only(bottom: 200),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        label: Text("$label", style: TextStyle(color: lcolor)),
        suffixIcon: Icon(icon, color: scolor),
        suffix: Text(stext ?? "",style: TextStyle(color: lcolor   ),),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(21),),
      ),
    );
  }

  static Widget elevatedButton({
    required VoidCallback callback,
    required String text,
    Color? color,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: callback,
      child: Text(text, style: TextStyle(fontSize: 20, color: Colors.white)),
    );
  }

  static Widget ChartInfo({required Color color, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
      child: Row(
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: color,
            ),
          ),SizedBox(width: 10,),
          Text(text,style: TextStyle(fontSize: 15,),)
        ],
      ),
    );
  }
}
