import 'package:fitlife/View/LoginPage.dart';
import 'package:fitlife/View/Register.dart';
import 'package:fitlife/View/dietpage.dart';
import 'package:fitlife/View/home.dart';
import 'package:fitlife/View/steps.dart';
import 'package:fitlife/View/workoutpage.dart';
import 'package:fitlife/ViewModel/provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class bottomnavigationabar extends StatefulWidget {
  const bottomnavigationabar({super.key});

  @override
  State<bottomnavigationabar> createState() => _bottomnavigationabarState();
}

class _bottomnavigationabarState extends State<bottomnavigationabar> {
  @override
  int _SelectedIndex = 0;
  _BottomNavigationbar(int index) {
    setState(() {

      _SelectedIndex = index;

    });
  }

  final List<Widget> _pages = [home(),Steps(),Workoutpage(), Dietpage(),];
  Widget build(BuildContext context) {
    final DarkMode = Provider.of<ThemeProvider>(context).Dark ;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: DarkMode ? Colors.lightBlueAccent : Colors.lightGreenAccent,
          backgroundColor: DarkMode ? Colors.black : Colors.grey.shade400,
          elevation: 10,
          currentIndex: _SelectedIndex,
          onTap: _BottomNavigationbar,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.directions_walk), label: "Step"),
            BottomNavigationBarItem(icon: Icon(Icons.sports_gymnastics_sharp), label: "WorkOut"),
            BottomNavigationBarItem(
              icon: Icon(Icons.lunch_dining),
              label: "Dietplan",
            ),

          ],
        ),
        body: _pages[_SelectedIndex],

    );
  }
}
