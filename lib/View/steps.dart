import 'package:FitLife/Utility/custom.dart';
import 'package:FitLife/ViewModel/StepsLogic.dart';
import 'package:FitLife/ViewModel/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Steps extends StatefulWidget {
  @override
  State<Steps> createState() => _StateState();
}

class _StateState extends State<Steps> {
  final StepsLogic step = StepsLogic();

  @override
  void initState() {
    super.initState();

    step.Initilize(
      Refresh: () {
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).Dark;
    return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        height: 300,
                        width: 350,
                        child: Card(
                          elevation: 5,
                          child: Stack(
                            children: [
                              Positioned(
                                right: 80,
                                left: 80,
                                top: 20,
                                bottom: 100,
                                child: CircularProgressIndicator(
                                  value: step.Progress.clamp(0.0, 1.0),
                                  strokeWidth: 8,
                                  backgroundColor: theme
                                      ? Colors.white.withOpacity(0.4)
                                      : Colors.grey.shade400,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    theme
                                        ? Colors.lightBlue
                                        : Colors.lightGreen,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 25,
                                right: 25,
                                top: 60,
                                bottom: 25,
                                child: Container(
                                  child: Column(
                                    children: [
                                      FaIcon(
                                        step.isWalking
                                            ? FontAwesomeIcons.personRunning
                                            : FontAwesomeIcons.person,

                                        size: 60,
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        step.todaySteps.toString(),
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 30,
                                right: 25,
                                top: 220,
                                bottom: 0,
                                child: Column(
                                  children: [
                                    Text("Goal"),
                                    TextButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            TextEditingController
                                            GoalController =
                                                TextEditingController();
                                            return AlertDialog.adaptive(
                                              title: Text("Goal"),
                                              content: customWidget.textField(
                                                controller: GoalController,
                                                istrue: false,
                                                label: "Enter Goal",
                                                keyboard:
                                                    TextInputType.numberWithOptions(),
                                              ),
                                              actions: [
                                                customWidget.elevatedButton(
                                                  callback: () {
                                                    step.SetGoal(
                                                      int.parse(
                                                        GoalController.text
                                                            .toString(),
                                                      ),
                                                    ).then((_) {
                                                      Navigator.pop(context);
                                                      setState(() {});
                                                    });
                                                  },
                                                  text: "OK",color: theme ? Colors.lightBlueAccent:Colors.lightGreen
                                                ),
                                                customWidget.elevatedButton(
                                                  callback: () {
                                                    Navigator.pop(context);
                                                  },
                                                  text: "Cancel",color: Colors.red
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        step.daily_Goal.toString(),
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 150,
                          width: 200,
                          child: Card(
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.fire,
                                  size: 35,
                                  color: Color.fromARGB(255, 255, 87, 34),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "Calories",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(height: 10),
                                Text(
                            "${step.calories.toStringAsFixed(2)} Kcl",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          height: 150,
                          width: 200,
                          child: Card(
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.route,
                                  size: 35,
                                  color: theme
                                      ? Colors.lightBlue
                                      : Colors.lightGreen,
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "Distance",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "${step.distance.toStringAsFixed(2)} Km",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                      width: 420,
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: theme
                                ? step.isWalking
                                      ? Colors.green
                                      : Colors.lightBlue.withOpacity(0.6)
                                : step.isWalking
                                ? Colors.lightBlue
                                : Colors.green.withOpacity(0.6),
                            child: FaIcon(
                              step.isWalking
                                  ? FontAwesomeIcons.personRunning
                                  : FontAwesomeIcons.person,

                              size: 20,
                            ),
                          ),
                          title: Text(step.isWalking ? "Walking" : "Stop"),
                          subtitle: Text(
                            step.isWalking
                                ? "Tracking your steps in real time."
                                : "Start walking to track your steps.",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 470,
                      width: 400,
                      child: Card(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: step.weeklyData.length,
                          itemBuilder: (context, index) {
                            final data = step.weeklyData[index];
                            return Card(
                              elevation: data['isToday'] ? 8 : 2,
                              shadowColor: theme
                                  ? data['isToday']
                                  ? Colors.pink
                                  : Colors.white
                                  : data['isToday']
                                  ? Colors.pink
                                  : Colors.white,
                              color: theme
                                  ? data['isToday']
                                  ? Colors.green
                                  : Colors.grey.shade600
                                  : data['isToday']
                                  ? Colors.lightGreen
                                  : Colors.white,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: theme
                                      ? data['isToday']
                                            ? Colors.pink
                                            : Colors.blueAccent.withOpacity(0.5)
                                      : data['isToday']
                                      ? Colors.pink
                                      : Colors.green.withOpacity(0.5),

                                  child: Text(
                                    data['day'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                title: Text("Steps: ${data['steps']}"),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
  }
}
