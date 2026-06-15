import 'package:fitlife/View/LoginPage.dart';
import 'package:fitlife/View/Register.dart';
import 'package:fitlife/View/dietpage.dart';
import 'package:fitlife/View/home.dart';
import 'package:fitlife/View/workoutpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  final List<Widget> _pages = [home(),Workoutpage(), Dietpage()];
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.lightBlueAccent,
          backgroundColor: Colors.grey.shade100,
          elevation: 10,
          currentIndex: _SelectedIndex,
          onTap: _BottomNavigationbar,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.sports_gymnastics_sharp), label: "WorkOut"),
            BottomNavigationBarItem(
              icon: Icon(Icons.lunch_dining),
              label: "Dietplan",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.directions_walk), label: "Step"),
          ],
        ),
        body: _pages[_SelectedIndex],

    );
  }
}
