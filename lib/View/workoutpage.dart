import 'dart:io';

import 'package:FitLife/Model/ExerciseModel.dart';
import 'package:FitLife/Utility/shimmer.dart';
import 'package:FitLife/View/DetailExercisePage.dart';
import 'package:FitLife/ViewModel/Exerciselogic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Workoutpage extends StatefulWidget {
  const Workoutpage({super.key});

  @override
  State<Workoutpage> createState() => _WorkoutpageState();
}

class _WorkoutpageState extends State<Workoutpage> {

  final workout = Exerciselogic();
  @override
  void initState() {
    super.initState();

    Exerciselogic.Reset().then((_) {
      if (mounted) {
        setState(() {});
      }
    });

    workout.setUpPagination(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void dispose() {
    workout.scrollController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Exerciselogic.AllExerciese.isEmpty
          ? listboxes()
          : ListView.builder(
              controller: workout.scrollController,
              itemCount:
                  Exerciselogic.AllExerciese.length +
                  (Exerciselogic.hasMoreData ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == Exerciselogic.AllExerciese.length) {
                  return Center(child: CircularProgressIndicator());
                }
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detailexercisepage(index: index),
                      ),
                    );
                  },

                  child: Hero(
                    tag: Exerciselogic.AllExerciese[index].id
                        .toString(),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            children: [
                               Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        Exerciselogic.AllExerciese[index].name
                                            .toString()
                                            .toUpperCase()
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      FutureBuilder<Uint8List?>(
                                        future:Exerciselogic.getImage(imageId: Exerciselogic.AllExerciese[index].id!),
                                        builder: (context, Snapshot) {
                                          if (Snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child: Container(
                                                height: 300,
                                                width: double.infinity,
                                                child: box(height: 300,),
                                            ));
                                          } if (Snapshot.hasError) {
                                            return Text(Snapshot.error.toString());
                                          }

                                          if (!Snapshot.hasData) {
                                            return Center(
                                              child: Container(
                                                height: 300,
                                                width: double.infinity,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .image_not_supported_outlined,
                                                      size: 80,
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      "oops! Image is not availabel",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                          return Container(
                                                height: 300,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(21),
                                                  image: DecorationImage(
                                                      image:MemoryImage(Snapshot.data!),
                                                  fit: BoxFit.cover)
                                                ),
                                              );

                                        },
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                                 Text(
                                  Exerciselogic.AllExerciese[index].instructions
                                      .toString().replaceAll("[", "").replaceAll("]", ""),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 20),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
                ;
              },
            ),
    );
  }
}


