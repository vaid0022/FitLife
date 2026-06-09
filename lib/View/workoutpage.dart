import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitlife/Model/ExerciseModel.dart';
import 'package:fitlife/Videowidget.dart';
import 'package:fitlife/ViewModel/Exerciselogic.dart';
import 'package:flutter/material.dart';

class Workoutpage extends StatefulWidget {
  const Workoutpage({super.key});

  @override
  State<Workoutpage> createState() => _WorkoutpageState();
}

class _WorkoutpageState extends State<Workoutpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout", style: TextStyle(fontSize: 40)),
        centerTitle: true,
      ),

      body: FutureBuilder(
        future: Exerciselogic.GetApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData ||
              snapshot.data!.data == null ||
              snapshot.data!.data!.isEmpty) {
            return Center(child: Text("No data available"));
          }
          return ExerciseList(snapshot: snapshot);
        },
      ),
    );
  }
}


class ExerciseList extends StatelessWidget {
  
  AsyncSnapshot<ExerciseModel> snapshot;
  ExerciseList({super.key,required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListView.builder(
        itemCount: snapshot.data!.data!.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Column(
              children: [
                Text(snapshot.data!.data![index].title.toString()),
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        snapshot.data!.data![index].thumbnailUrl.toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Text(
              snapshot.data!.data![index].description.toString(),
            ),
          );
        },
      ),
    );;
  }
}

