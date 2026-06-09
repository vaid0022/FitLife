import 'dart:math';

import 'package:flutter/material.dart';

class Homepagemodel {
  static String calBmi = "Normal";
  static double Bmi = 0.0;
  static void BmiCaclulator({
    required String heightcon,
    required String weightcon,
    required BuildContext context,
  }) {
    if (heightcon.isNotEmpty && weightcon.isNotEmpty) {
      double height = double.parse(heightcon);
      double heightM =  height / 100;
      double weight = double.parse(weightcon);

      Bmi = weight / pow(heightM, 2);
      if (Bmi < 16) {
        calBmi = "Severe Thinness";
      } else if (Bmi < 17) {
        calBmi = "Moderate Thinness";
      } else if (Bmi < 18.5) {
        calBmi = "Mild Thinness";
      } else if (Bmi < 25) {
        calBmi = "Normal";
      } else if (Bmi < 30) {
        calBmi = "Overweight";
      } else if (Bmi < 35) {
        calBmi = "Obese Class I";
      } else if (Bmi < 40) {
        calBmi = "Obese Class 2";
      } else {
        calBmi = "Obese Class 3";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Bmi ${Bmi.toStringAsFixed(2)}\ncategory: $calBmi"),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Plesae fill requred filled")));
    }
  }
}
