import 'package:date_format/date_format.dart';
import 'package:fitlife/ViewModel/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class UserBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 15,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(21),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class listboxes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context,listen: false).Dark;
    return Shimmer.fromColors(
      baseColor:theme ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.1),
      highlightColor: Colors.white,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              elevation: 8,
              color: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 8),
                    Container(
                      height: 30,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21),
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),

                        Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21),
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),

                        Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21),
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}class listDietboxes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context,listen: false).Dark;
    return Shimmer.fromColors(
      baseColor:theme ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.1),
      highlightColor: Colors.white,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 2,
          itemBuilder:(context,index)
          {
            return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              elevation: 8,
              color:  Colors.white.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 8),
                    Container(
                      height: 30,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        color: Colors.grey.shade200,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey.shade200,
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21),
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),

                        Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21),
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),

                        Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21),
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
          }
      ),
    );
  }
}
class box extends StatelessWidget {
  box({super.key, required this.isWorkout});

  final bool isWorkout;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        height:isWorkout ? 300 : 400,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21),
          color: Colors.grey,
        ),
      ),
    );
  }
}

class detailboxes extends StatelessWidget {
  const detailboxes({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
         baseColor: Colors.grey,
        highlightColor: Colors.white,
      child: Column(
        children: [
          Container(
            height: 500,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21),
              color: Colors.grey.shade400
            ),
          ),
          SizedBox(height: 15,),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                color: Colors.grey.withOpacity(0.4)
            ),
            child: Column(
              children: [
                SizedBox(height: 25,),
                Container(
                  height: 20,
                  width: 340,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    color: Colors.grey
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 18,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    color: Colors.grey
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 18,
                  width: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    color: Colors.grey
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

