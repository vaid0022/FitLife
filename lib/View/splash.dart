import 'package:FitLife/Reposetory/Firebase/Firebase_Auth/check_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    navigation();
  }

  void navigation() {
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>checkuser()));
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: Stack(
                children: [
                  Positioned(
                    right:46,
                    top: 40,
                    child: Card(
                      elevation: 15,
                      shadowColor: Colors.tealAccent,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          image: DecorationImage(
                            image: AssetImage("assets/logo/FitLife.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SpinKitWaveSpinner(
                    color: Colors.tealAccent,
                    waveColor: Colors.white30,
                    size: 200,
                    duration: Duration(seconds: 5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
