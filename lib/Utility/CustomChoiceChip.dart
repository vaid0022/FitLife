import 'package:fitlife/ViewModel/DietLogic.dart';
import 'package:flutter/material.dart';

class Custom {
  static Widget choiceChip({required String value,required ValueChanged<bool> valueChanged,required var selected,required String Dietname}){
    return     Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ChoiceChip(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(20)
          ),side: BorderSide(color: Colors.lightBlueAccent),
          elevation: 2,
          pressElevation: 8,
          showCheckmark: false,
          label: Text(value),
          selected: selected == Dietname.toLowerCase(),
          selectedColor: Colors.lightBlueAccent,
          onSelected: valueChanged
      ),
    );
  }
}
