import 'package:FitLife/Utility/shimmer.dart';
import 'package:FitLife/Utility/textpadding.dart';
import 'package:FitLife/ViewModel/Exerciselogic.dart';
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
            tag: Exe[widget.index].id.toString(),
            child: FutureBuilder(
              future: Exerciselogic.getImage(
                imageId: Exe[widget.index].id.toString(),
              ),
              builder: (context, Snapshot) {
                if (Snapshot.connectionState == ConnectionState.waiting) {
                  return box(height: 500,);
                }
                if (!Snapshot.hasData) {
                  return Center(child: Text("Data is not Available"));
                }
                return Container(
                  height: 500,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(Snapshot.data!),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),

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
                        text: "Description: ${Exe[widget.index].instructions.toString().replaceAll("[", "").replaceAll("]", "")}",
                        isBold: false,
                        isLines: false,
                        fontSize: 17,
                      ),
                      SizedBox(height: 10),

                      textpadding.TextPadding(
                        padding: 2,
                        text: "Equipments:${Exe[widget.index].equipment}",
                        isBold: false,
                        isLines: false,
                        fontSize: 15,
                      ),
                      SizedBox(height: 10),

                      textpadding.TextPadding(
                        padding: 2,
                        text:
                            "Catagory: ${Exe[widget.index].bodyPart ?? "---"}",
                        isBold: false,
                        isLines: false,
                        fontSize: 15,
                      ),
                      SizedBox(height: 10),

                      textpadding.TextPadding(
                        padding: 2,
                        text: "Equipment: ${Exe[widget.index].target}",
                        isBold: false,
                        isLines: false,
                        fontSize: 15,
                      ),
                      SizedBox(height: 10),
                      textpadding.TextPadding(
                        padding: 2,
                        text:
                            "Exercise Type: ${Exe[widget.index].secondaryMuscles.toString().replaceAll("[", "").replaceAll("]", "")}",
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
