import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitlife/Reposetory/Firebase/FireStore/Fetchdata.dart';
import 'package:fitlife/Utility/custom.dart';
import 'package:fitlife/Utility/textpadding.dart';
import 'package:fitlife/View/LoginPage.dart';
import 'package:fitlife/View/Setting.dart';
import 'package:fitlife/ViewModel/HomepageModel.dart';
import 'package:fitlife/ViewModel/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      FirebaseAuth FirebaseUser = FirebaseAuth.instance;

      if(FirebaseUser.currentUser != null){
        context.read<CurrentUserProvider>().fetchCurrentUser(FirebaseUser.currentUser!.uid);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Fitlife"),
          actions: [
            PopupMenuButton(itemBuilder:(_){
              return [PopupMenuItem(
                child: Row(children: [Icon(Icons.settings), Text("Setting")]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Setting()),
                  );
                },
              )];}
            ),

          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),

                // UserInfo
                user(),

                // Bmi Calculator
                BmiCalculator(),

                Container(
                  width: double.infinity,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      "Information about app",
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class user extends StatefulWidget {
  @override
  State<user> createState() => _userState();
}

class _userState extends State<user> {
  @override
  final Fetchdata userinfo = Fetchdata();

  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Card(
        child:  Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "Welcome to Fit Life!  ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Consumer<CurrentUserProvider>(
                            builder: (_,provider,__){
                              if(provider.currentUser == null || provider.currentUser.toString().isEmpty){
                                return Center(child: CircularProgressIndicator(),);
                              }
                          return Text(
                            provider.currentUser!.name,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        })

                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Your fitness journey starts here."),
                    ),
                  ],
                ),
              )
        )
      )
    );

  }
}

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Center(
              child: Text(
                "Bmi Calculator",
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: customWidget.textField(
                controller: heightController,
                istrue: false,
                label: "Enter your height",
                fontColor: Colors.white,
                icon: Icons.height,
                lcolor: Colors.white,
                scolor: Colors.white,
                stext: "cm",
                keyboard: TextInputType.numberWithOptions(),
                fillColor: Colors.teal.shade400
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: customWidget.textField(
                controller: weightController,
                istrue: false,
                label: "Enter your weight",
                fontColor: Colors.white,
                icon: Icons.monitor_weight_outlined,
                lcolor: Colors.white,
                scolor: Colors.white,
                stext: "Kg",
                keyboard: TextInputType.numberWithOptions(),
                  fillColor: Colors.teal.shade400
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 500,
                child: customWidget.elevatedButton(
                  callback: () {
                    Homepagemodel.BmiCaclulator(
                      heightcon: heightController.text.toString(),
                      weightcon: weightController.text.toString(),
                      context: context,
                    );
                    heightController.clear();
                    weightController.clear();
                    FocusScope.of(context).unfocus();

                    setState(() {});
                  },
                  text: "Calculate your BMI",
                  color: Colors.lightBlueAccent,
                ),
              ),
            ),
            SizedBox(height: 25),
            chart(),
          ],
        ),
      ),
    );
  }
}

class chart extends StatefulWidget {
  const chart({super.key});

  @override
  State<chart> createState() => _chartState();
}

class _chartState extends State<chart> {
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 4), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      width: double.infinity,
      child: Card(
        elevation: 8,
        shadowColor: Colors.lightBlueAccent,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              customWidget.ChartInfo(
                color: Colors.red,
                text: "High Risk – Seek Medical Attention",
              ),
              customWidget.ChartInfo(
                color: Colors.yellowAccent.shade700,
                text: "Moderate Risk – Monitor Your Health",
              ),
              customWidget.ChartInfo(
                color: Colors.green,
                text: "Healthy Range – Keep It Up ",
              ),
              SizedBox(height: 20),
              Expanded(
                child: BarChart(
                  curve: Curves.easeInCubic,
                  BarChartData(
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(toY: 42, color: Colors.redAccent),
                        ],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(toY: 40, color: Colors.orange),
                        ],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(
                            toY: 35,
                            color: Colors.yellow.shade700,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(toY: 30, color: Colors.lightGreen),
                        ],
                      ),
                      BarChartGroupData(
                        x: 7,
                        barRods: [
                          BarChartRodData(
                            toY: Homepagemodel.Bmi,
                            color: Colors.purple,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 4,
                        barRods: [
                          BarChartRodData(
                            toY: 25,
                            color: Colors.yellow.shade700,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 5,
                        barRods: [
                          BarChartRodData(toY: 18.5, color: Colors.orange),
                        ],
                      ),
                      BarChartGroupData(
                        x: 6,
                        barRods: [
                          BarChartRodData(toY: 17, color: Colors.redAccent),
                        ],
                      ),
                    ],
                    rangeAnnotations: RangeAnnotations(
                      horizontalRangeAnnotations: [
                        HorizontalRangeAnnotation(
                          y1: 23.0,
                          y2: 27.0,
                          color: Colors.green.withOpacity(0.4),
                        ),
                      ],
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        axisNameSize: 30,
                        drawBelowEverything: false,
                        axisNameWidget: Text(
                          "BMI RESULTS",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 50,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return SideTitleWidget(
                              angle: -0.4,
                              meta: meta,
                              child: switch (value) {
                                0 => textpadding.TextPadding(
                                  padding: 2,
                                  text: "Obesity 3",
                                  isBold: true,
                                  isLines: false,
                                  fontSize: 15,
                                  color: Colors.redAccent,
                                ),
                                1 => textpadding.TextPadding(
                                  padding: 2,
                                  text: "Obesity 2",
                                  isBold: true,
                                  isLines: false,
                                  fontSize: 15,
                                  color: Colors.orange,
                                ),
                                2 => textpadding.TextPadding(
                                  padding: 2,
                                  text: "Obesity 1",
                                  isBold: true,
                                  isLines: false,
                                  fontSize: 15,
                                  color: Colors.yellow.shade700,
                                ),
                                3 => textpadding.TextPadding(
                                  padding: 2,
                                  text: "Normal",
                                  isBold: true,
                                  isLines: false,
                                  fontSize: 15,
                                  color: Colors.lightGreen,
                                ),
                                4 => textpadding.TextPadding(
                                  padding: 2,
                                  text: "Mild Thinness",
                                  isBold: true,
                                  isLines: false,
                                  fontSize: 15,
                                  color: Colors.yellow.shade700,
                                ),
                                5 => textpadding.TextPadding(
                                  padding: 2,
                                  text: "Moderate Thinness",
                                  isBold: true,
                                  isLines: false,
                                  fontSize: 15,
                                  color: Colors.orange,
                                ),
                                6 => textpadding.TextPadding(
                                  padding: 2,
                                  text: "Severe Thinness",
                                  isBold: true,
                                  isLines: false,
                                  fontSize: 15,
                                  color: Colors.redAccent,
                                ),
                                7 => textpadding.TextPadding(
                                  padding: 2,
                                  text: "User",
                                  isBold: true,
                                  isLines: false,
                                  fontSize: 15,
                                  color: Colors.purple,
                                ),
                                _ => Text("default"),
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    backgroundColor: Colors.lightBlueAccent.withOpacity(0.2),
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipHorizontalAlignment: FLHorizontalAlignment.right,
                        getTooltipColor: (BarChartGroupData group) {
                          return Colors.black;
                        },
                        fitInsideHorizontally: true,
                        fitInsideVertically: true,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Bmi: ${Homepagemodel.Bmi.toStringAsFixed(2)}\nResult: ${Homepagemodel.calBmi}",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
