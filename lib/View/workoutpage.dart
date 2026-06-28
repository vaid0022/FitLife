import 'dart:io';

import 'package:fitlife/Model/ExerciseModel.dart';
import 'package:fitlife/Utility/shimmer.dart';
import 'package:fitlife/View/DetailExercisePage.dart';
import 'package:fitlife/ViewModel/Exerciselogic.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Workoutpage extends StatefulWidget {
  const Workoutpage({super.key});

  @override
  State<Workoutpage> createState() => _WorkoutpageState();
}

class _WorkoutpageState extends State<Workoutpage> {
  @override
  @override
  void initState() {
    super.initState();

    Exerciselogic.Reset().then((_) {
      if (mounted) {
        setState(() {});
      }
    });

    Exerciselogic.setUpPagination(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void dispose() {
    Exerciselogic.scrollController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Exerciselogic.AllExerciese.isEmpty
          ? listboxes()
          : ListView.builder(
              controller: Exerciselogic.scrollController,
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
                    tag: Exerciselogic.AllExerciese[index].exerciseId
                        .toString(),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListTile(
                            title: Column(
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
                                FutureBuilder<String?>(
                                  future: Exerciselogic.gifToImage(
                                    GifUrl: Exerciselogic
                                        .AllExerciese[index]
                                        .gifUrl!,
                                  ),
                                  builder: (context, Snapshot) {
                                    if (Snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: Container(
                                          height: 300,
                                          width: double.infinity,
                                          child: box(isWorkout: true,),
                                        ),
                                      );
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
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(21),
                                        image: DecorationImage(
                                          image: FileImage(
                                            File(Snapshot.data!),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                            subtitle: Text(
                              Exerciselogic.AllExerciese[index].instructions
                                  .toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 20),
                            ),
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


