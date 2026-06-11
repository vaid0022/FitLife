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
    return Scaffold(
      body: Column(
        children: [
          Hero(
            tag: "hero",
            child: Container(
              height: 500,
              width: double.infinity,

              child: VideoWidget(
                videoUrl: Exerciselogic.AllExerciese[widget.index].videoUrl
                    .toString(),
              ),
            ),
          ),

          SizedBox(

            child: Card(
              elevation: 5,
                surfaceTintColor: Colors.grey,
                shadowColor: Colors.lightBlueAccent,
                child: Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textpadding.TextPadding(
                          padding: 2,
                          text: Exe[widget.index].title.toString(),
                          isBold: true,
                          isLines: false,
                          fontSize: 22,
                        ),
                        SizedBox(height: 10),
                        textpadding.TextPadding(
                          padding: 2,
                          text: "Description: ${Exe[widget.index].description}",
                          isBold: false,
                          isLines: false,
                          fontSize: 17,
                        ),
                        SizedBox(height: 10),

                        textpadding.TextPadding(
                          padding: 2,
                          text: "Category:${Exe[widget.index].category}",
                          isBold: false,
                          isLines: false,
                          fontSize: 15,
                        ),
                        SizedBox(height: 10),

                        textpadding.TextPadding(
                          padding: 2,
                          text:"Difficulty: ${Exe[widget.index].difficulty ?? "---"}",
                          isBold: false,
                          isLines: false,
                          fontSize: 15,
                        ),
                        SizedBox(height: 10),

                        textpadding.TextPadding(
                          padding: 2,
                          text:"Equipment: ${Exe[widget.index].equipment}",
                          isBold: false,
                          isLines: false,
                          fontSize: 15,
                        ),
                        SizedBox(height: 10),
                        textpadding.TextPadding(
                          padding: 2,
                          text:"Exercise Type: ${Exe[widget.index].exerciseType}",
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
