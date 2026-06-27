import 'package:fitlife/Utility/CustomChoiceChip.dart';
import 'package:fitlife/View/DetailDiet.dart';
import 'package:fitlife/ViewModel/DietLogic.dart';
import 'package:fitlife/ViewModel/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dietpage extends StatefulWidget {
  const Dietpage({super.key});

  @override
  State<Dietpage> createState() => _DietpageState();
}

class _DietpageState extends State<Dietpage> {


  String SelectedDiet = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: Card(
                    surfaceTintColor: Provider.of<ThemeProvider>(context).Dark ? Colors.lightBlue : Colors.lightGreen,
                    elevation: 8,
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
                                  context: context,
                                    value: "Vegetarian",
                                    valueChanged: (selected){
                                      if(selected){
                                        SelectedDiet = "vegetarian";
                                        Dietlogic.DietCategory(Category: SelectedDiet);
                                        setState(() {

                                        });
                                      }
                                    },
                                    selected: SelectedDiet, Dietname: 'vegetarian'),
                                Custom.choiceChip(
                                  context: context,
                                  value: "Vegan",
                                  valueChanged: (selected){
                                    if(selected){
                                      SelectedDiet = "vegan";
                                      Dietlogic.DietCategory(Category: SelectedDiet);
                                      setState(() {

                                      });
                                    }
                                  },
                                  selected: SelectedDiet, Dietname: 'vegan',
                                ),
                                Custom.choiceChip(
                                  context: context,
                                    value: "Breakfast",
                                    valueChanged: (selected){
                                      if(selected){
                                        SelectedDiet = "Breakfast";
                                        Dietlogic.DietCategory(Category: SelectedDiet);
                                        setState(() {

                                        });
                                      }
                                    },
                                    selected: SelectedDiet, Dietname: 'Breakfast'),
                                Custom.choiceChip(
                                  context: context,
                                    value: "Dessert",
                                    valueChanged: (selected){
                                      if(selected){
                                        SelectedDiet = "Dessert";
                                        Dietlogic.DietCategory(Category: SelectedDiet);
                                        setState(() {

                                        });
                                      }
                                    },
                                    selected: SelectedDiet, Dietname: 'Dessert'),
                                Custom.choiceChip(
                                  context: context,
                                    value: "Seafood",
                                    valueChanged: (selected){
                                      if(selected){
                                        SelectedDiet = "Seafood";
                                        Dietlogic.DietCategory(Category: SelectedDiet);
                                        setState(() {

                                        });
                                      }
                                    },
                                    selected: SelectedDiet, Dietname: 'Seafood'),
                                Custom.choiceChip(
                                  context: context,
                                    value: "Miscellaneous",
                                    valueChanged: (selected){
                                      if(selected){
                                        SelectedDiet = "Miscellaneous";
                                        Dietlogic.DietCategory(Category: SelectedDiet);
                                        setState(() {

                                        });
                                      }
                                    },
                                    selected: SelectedDiet, Dietname: 'Miscellaneous'
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
           Container(
             height: 715,
               width: double.infinity,
             child: SingleChildScrollView(
               child: Column(
                 children: [
                   FutureBuilder(
                     future: Dietlogic.GetApi(),
                     builder: (context, snapshot) {
                       final Diet = snapshot.data;
                       if(snapshot.connectionState == ConnectionState.waiting){
                         return Center(child: CircularProgressIndicator(),);
                       }
                       if(!snapshot.hasData || snapshot.data!.meals ==null || snapshot.data!.meals!.isEmpty){
                         return Center(child: Text("Data is not availavble"),);
                       }
                       return ListView.builder(
                         shrinkWrap: true,
                         physics: NeverScrollableScrollPhysics(),
                                    itemCount:snapshot.data!.meals!.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Detaildiet(index: index,)));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Card(
                                            elevation: 8,
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: ListTile(
                                                title: Column(
                                                  children: [
                                                    Text(Diet!.meals![index].strMeal.toString(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                                    SizedBox(height: 20,),
                   
                                                    Hero(
                                                      tag: Diet!.meals![index].idMeal.toString(),
                                                      child: Container(
                                                        height: 400,
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(21),
                                                          image: DecorationImage(
                                                            image: NetworkImage(
                                                              Diet!.meals![index].strMealThumb.toString(),
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 20,)
                                                  ],
                                                ),
                                                subtitle: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("Country : ",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                                                    Text(Diet!.meals![index].strCountry.toString(),style: TextStyle(fontSize: 20),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                );
                     }
                   ),
                 ],
               ),
             ),
           ),
            ],
          ),
        ),

    );
  }
}
