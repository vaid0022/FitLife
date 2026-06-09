import 'package:fitlife/Model/ExerciseModel.dart';
import 'package:flutter/material.dart';

class Detailexercisepage extends StatefulWidget {
  int index;
  AsyncSnapshot<ExerciseModel> snapshot;
  Detailexercisepage({super.key, required this.index, required this.snapshot});

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
              Text(widget.snapshot.data!.data![widget.index].title.toString()),
              Text(widget.snapshot.data!.data![widget.index].category.toString()),
            ])),
          ],
        ),
      ),
    );
  }
}
