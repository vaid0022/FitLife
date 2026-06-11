import 'package:fitlife/Utility/textpadding.dart';
import 'package:fitlife/ViewModel/DietLogic.dart';
import 'package:flutter/material.dart';

class Detaildiet extends StatefulWidget {
  int index;
  Detaildiet({required this.index});


  @override
  State<Detaildiet> createState() => _DetaildietState();
}

class _DetaildietState extends State<Detaildiet> {
  @override
  var Diet = Dietlogic.AllDiet;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image:DecorationImage(
                  image: NetworkImage(Diet[widget.index].imageUrl.toString()),
                fit: BoxFit.cover
              )
            ),
          ),
          Expanded(
            child: Card(
              surfaceTintColor: Colors.grey,
                child:SingleChildScrollView(
                  child: Column(
                    children: [
                      textpadding.TextPadding(padding: 10, text: " ${Diet[widget.index].title}", isBold: true, isLines: false,fontSize: 23),
                      textpadding.TextPadding(padding: 10, text: "Description: ${Diet[widget.index].description}", isBold: false, isLines: false,fontSize: 17),
                      textpadding.TextPadding(padding: 10, text: "Calories: ${Diet[widget.index].calories}", isBold: false, isLines: false,fontSize: 17),
                      textpadding.TextPadding(padding: 10, text: "Difficulty: ${Diet[widget.index].difficulty}", isBold: false, isLines: false,fontSize: 17),
                      textpadding.TextPadding(padding: 10, text: "Carbs: ${Diet[widget.index].carbs} ", isBold: false, isLines: false,fontSize: 17),
                      textpadding.TextPadding(padding: 10, text: "CookTimeMin: ${Diet[widget.index].cookTimeMin} min.", isBold: false, isLines: false,fontSize: 17),
                      textpadding.TextPadding(padding: 10, text: "CusineType: ${Diet[widget.index].cuisineType}", isBold: false, isLines: false,fontSize: 17),
                      textpadding.TextPadding(padding: 10, text: "MealType: ${Diet[widget.index].mealType}", isBold: false, isLines: false,fontSize: 17),
                      textpadding.TextPadding(padding: 10, text: "Protein: ${Diet[widget.index].protein}", isBold: false, isLines: false,fontSize: 17),
                      textpadding.TextPadding(padding: 10, text: "Serving: ${Diet[widget.index].servings}", isBold: false, isLines: false,fontSize: 17),
                      textpadding.TextPadding(padding: 10, text: "DietTag: ${Diet[widget.index].dietTags}", isBold: false, isLines: false,fontSize: 17),
                    ],
                  ),
                ),
              ),
          ),

        ],
      ),
    );

  }
}
