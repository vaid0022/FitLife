import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customWidget {
  static Widget textField({
    required TextEditingController controller,
    String? label,
    IconData? icon,
    required bool istrue,
    Color? lcolor,
    Color? scolor,
    Color? fontColor
  }) {
    return
      TextField(
        style: TextStyle(color: fontColor),
        obscureText: istrue,
        controller: controller,
        scrollPadding: EdgeInsets.only(
        bottom: 200,
      ),
        decoration: InputDecoration(
          fillColor: Colors.green,
          label: Text("$label",style:TextStyle(color: lcolor) ,),
          suffixIcon: Icon(icon,color: scolor,),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
        )

    );
  }

  static Widget elevatedButton({required VoidCallback callback,required String text,Color? color}){
    return
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,

        ),
          onPressed: callback, child:Text(text,style: TextStyle(fontSize:20,color: Colors.white))
    );
  }
}
