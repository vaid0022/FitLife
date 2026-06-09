import 'package:fitlife/Model/ExerciseModel.dart';
import 'package:fitlife/ViewModel/Exerciselogic.dart';
import 'package:flutter/material.dart';

class Detailexercisepage extends StatefulWidget {
  int index;
  Detailexercisepage({super.key, required this.index,});

  @override
  State<Detailexercisepage> createState() => _DetailexercisepageState();
}

class _DetailexercisepageState extends State<Detailexercisepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Hero(
              tag: "hero",
              child: Container(
                height: 350,
                width: double.infinity,
                color: Colors.blue,
              ),
            ),
            Container(child: Column(children: [
              Text(Exerciselogic.AllExerciese[widget.index].title.toString()),
              Text(Exerciselogic.AllExerciese[widget.index].description.toString()),
            ])),
          ],
        ),
      ),
    );
  }
}
