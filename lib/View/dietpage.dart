import 'package:fitlife/Utility/CustomChoiceChip.dart';
import 'package:fitlife/View/DetailDiet.dart';
import 'package:fitlife/ViewModel/DietLogic.dart';
import 'package:flutter/material.dart';

class Dietpage extends StatefulWidget {
  const Dietpage({super.key});

  @override
  State<Dietpage> createState() => _DietpageState();
}

class _DietpageState extends State<Dietpage> {
  void initState() {
    super.initState();

    Dietlogic.Reset().then((_) {
      if (mounted) {
        setState(() {});
      }
    });

    Dietlogic.SetUpPagination(
      RefreshUi: () {
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  String SelectedDiet = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 120,
                width: double.infinity,
                child: Card(
                  surfaceTintColor: Colors.lightBlue,
                  elevation: 8,
                  shadowColor: Colors.blue.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Diet Category : ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                  children: [
                                    Custom.choiceChip(
                                        value: "Vegetarian",
                                        valueChanged: (selected){
                                         if(selected){
                                           SelectedDiet = "vegetarian";
                                           Dietlogic.DietCategory(Category: SelectedDiet);
                                           Dietlogic.Reset().then((_){
                                             if(mounted){
                                               setState(() {
        
                                               });
                                             }
                                           });
                                         }
                                        },
                                        selected: SelectedDiet, Dietname: 'vegetarian'),
                                    Custom.choiceChip(
                                        value: "Vegan",
                                        valueChanged: (selected){
                                         if(selected){
                                           SelectedDiet = "vegan";
                                           Dietlogic.DietCategory(Category: SelectedDiet);
                                           Dietlogic.Reset().then((_){
                                             if(mounted){
                                               setState(() {
        
                                               });
                                             }
                                           });
                                         }
                                        },
                                        selected: SelectedDiet, Dietname: 'vegan',
                                    ),
                                    Custom.choiceChip(
                                        value: "High-Protein",
                                        valueChanged: (selected){
                                         if(selected){
                                           SelectedDiet = "high_protein";
                                           Dietlogic.DietCategory(Category: SelectedDiet);
                                           Dietlogic.Reset().then((_){
                                             if(mounted){
                                               setState(() {
        
                                               });
                                             }
                                           });
                                         }
                                        },
                                        selected: SelectedDiet, Dietname: 'high_protein'),
                                    Custom.choiceChip(
                                        value: "Low-Carb",
                                        valueChanged: (selected){
                                         if(selected){
                                           SelectedDiet = "low_carb";
                                           Dietlogic.DietCategory(Category: SelectedDiet);
                                           Dietlogic.Reset().then((_){
                                             if(mounted){
                                               setState(() {
        
                                               });
                                             }
                                           });
                                         }
                                        },
                                        selected: SelectedDiet, Dietname: 'low_carb'),
                                    Custom.choiceChip(
                                        value: "Keto",
                                        valueChanged: (selected){
                                         if(selected){
                                           SelectedDiet = "keto";
                                           Dietlogic.DietCategory(Category: SelectedDiet);
                                           Dietlogic.Reset().then((_){
                                             if(mounted){
                                               setState(() {
        
                                               });
                                             }
                                           });
                                         }
                                        },
                                        selected: SelectedDiet, Dietname: 'keto'),
                                    Custom.choiceChip(
                                        value: "Paleo",
                                        valueChanged: (selected){
                                         if(selected){
                                           SelectedDiet = "paleo";
                                           Dietlogic.DietCategory(Category: SelectedDiet);
                                           Dietlogic.Reset().then((_){
                                             if(mounted){
                                               setState(() {
        
                                               });
                                             }
                                           });
                                         }
                                        },
                                        selected: SelectedDiet, Dietname: 'paleo'
                                    ),
                                  ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 20,),
        
            Dietlogic.AllDiet.isEmpty && Dietlogic.isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      controller: Dietlogic.scrollController,
                      itemCount:
                          Dietlogic.AllDiet.length +
                          (Dietlogic.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        var Diet = Dietlogic.AllDiet;
                        if (index == Dietlogic.AllDiet.length) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Detaildiet(index: index,)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ListTile(
                                  title: Column(
                                    children: [
                                      Text(Diet[index].title.toString()),
                                      SizedBox(height: 20,),
                                  
                                      Container(
                                        height: 400,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(21),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              Diet[index].imageUrl.toString(),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20,)
                                    ],
                                  ),
                                  subtitle: Text(Diet[index].description.toString(),maxLines: 3,overflow: TextOverflow.ellipsis,),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
