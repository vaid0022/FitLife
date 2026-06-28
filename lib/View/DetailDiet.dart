import 'package:fitlife/Utility/shimmer.dart';
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Dietlogic.GetApi(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return detailboxes();
          }
          if(snapshot.hasData ==null || snapshot.data!.meals!.isEmpty){
            return Center(child: Text("Data is Not Available"),);
          }
          final Diet = snapshot.data!.meals;

          return Column(
            children: [
              Hero(
                tag: Diet![widget.index].idMeal.toString(),
                child: Container(
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image:DecorationImage(
                        image: NetworkImage(Diet![widget.index].strMealThumb.toString()),
                      fit: BoxFit.cover
                    )
                  ),
                ),
              ),
              SizedBox(height: 15,),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Card(
                  elevation: 5,
                  surfaceTintColor: Colors.grey,
                    child:SingleChildScrollView(
                      child: Column(
                        children: [
                          textpadding.TextPadding(padding: 10, text: " ${Diet[widget.index].strMeal}", isBold: true, isLines: false,fontSize: 23),
                          textpadding.TextPadding(padding: 10, text: "Description: ${Diet[widget.index].strCountry}", isBold: false, isLines: false,fontSize: 17),
                          textpadding.TextPadding(padding: 10, text: "Calories: ${Diet[widget.index].strArea}", isBold: false, isLines: false,fontSize: 17),
                        ],
                      ),
                    ),
                  ),
              ),

            ],
          );
        }
      ),
    );

  }
}
