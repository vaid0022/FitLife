import 'package:fitlife/View/DetailExercisePage.dart';
import 'package:fitlife/ViewModel/Exerciselogic.dart';
import 'package:flutter/material.dart';

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

    Exerciselogic.Reset().then((_){
      if(mounted){
        setState(() {

        });
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
      appBar: AppBar(
        title: Text("Workout", style: TextStyle(fontSize: 40)),
        centerTitle: true,
      ),

      body: Exerciselogic.AllExerciese.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: Exerciselogic.scrollController,
              itemCount: Exerciselogic.AllExerciese.length + (Exerciselogic.hasMoreData ? 1 : 0),
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
                    tag: "hero",
                    child: Card(
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Card(
                                elevation: 8,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    Exerciselogic.AllExerciese[index].title
                                        .toString(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                height: 300,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 3),
                                  borderRadius: BorderRadius.circular(21),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      Exerciselogic
                                          .AllExerciese[index]
                                          .thumbnailUrl
                                          .toString(),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Text(
                          Exerciselogic.AllExerciese[index].description
                              .toString(),
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
