import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:fitlife/Model/ExerciseModel.dart';
import 'package:fitlife/Utility/Videowidget.dart';
import 'package:fitlife/Utility/textpadding.dart';
import 'package:fitlife/ViewModel/Exerciselogic.dart';
import 'package:flutter/material.dart';

class Detailexercisepage extends StatefulWidget {
  int index;
  Detailexercisepage({super.key, required this.index});

  @override
  State<Detailexercisepage> createState() => _DetailexercisepageState();
}

class _DetailexercisepageState extends State<Detailexercisepage> {
  @override
  var Exe = Exerciselogic.AllExerciese;

  Widget build(BuildContext context) {
    if(Exe[widget.index].gifUrl == null && Exe[widget.index].gifUrl!.isEmpty){
      return Center(child: Container(child: Column(children: [Icon(Icons.image_not_supported,size: 35,),Text("Not Image Available",style: TextStyle(fontSize: 20),)],),),);
    }
    return Scaffold(
      body: Column(
        children: [
          Hero(
            tag: Exe[widget.index].exerciseId.toString(),
            child: Container(
              height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(Exe[widget.index].gifUrl.toString()),
                  fit: BoxFit.cover
              ),
            ),
          ),),

          SizedBox(

            child: Card(
              elevation: 5,
                surfaceTintColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textpadding.TextPadding(
                          padding: 2,
                          text: Exe[widget.index].name.toString(),
                          isBold: true,
                          isLines: false,
                          fontSize: 22,
                        ),
                        SizedBox(height: 10),
                        textpadding.TextPadding(
                          padding: 2,
                          text: "Description: ${Exe[widget.index].instructions}",
                          isBold: false,
                          isLines: false,
                          fontSize: 17,
                        ),
                        SizedBox(height: 10),

                        textpadding.TextPadding(
                          padding: 2,
                          text: "Equipments:${Exe[widget.index].equipments}",
                          isBold: false,
                          isLines: false,
                          fontSize: 15,
                        ),
                        SizedBox(height: 10),

                        textpadding.TextPadding(
                          padding: 2,
                          text:"Catagory: ${Exe[widget.index].bodyParts ?? "---"}",
                          isBold: false,
                          isLines: false,
                          fontSize: 15,
                        ),
                        SizedBox(height: 10),

                        textpadding.TextPadding(
                          padding: 2,
                          text:"Equipment: ${Exe[widget.index].targetMuscles}",
                          isBold: false,
                          isLines: false,
                          fontSize: 15,
                        ),
                        SizedBox(height: 10),
                        textpadding.TextPadding(
                          padding: 2,
                          text:"Exercise Type: ${Exe[widget.index].secondaryMuscles}",
                          isBold: false,
                          isLines: false,
                          fontSize: 17,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
