import 'package:fitlife/ViewModel/DietLogic.dart';
import 'package:fitlife/ViewModel/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Custom {
  static Widget choiceChip({required String value,required ValueChanged<bool> valueChanged,required var selected,required String Dietname,required BuildContext context}){
    return     Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ChoiceChip(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(20)
          ),side: BorderSide(color: Provider.of<ThemeProvider>(context).Dark ? Colors.lightBlue : Colors.lightGreen),
          elevation: 2,
          pressElevation: 8,
          showCheckmark: false,
          label: Text(value),
          selected: selected == Dietname,
          selectedColor: Colors.lightBlueAccent,
          onSelected: valueChanged
      ),
    );
  }
}
