import 'dart:ffi';

import 'package:fitlife/ViewModel/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sharedprefrence {

  static Future<void> SetTheme({required bool value})async{
    final Pref = await SharedPreferences.getInstance();

    Pref.setBool("Theme", value);

  }

  static void getTheme({required BuildContext context})async{
    var pref = await SharedPreferences.getInstance();

  bool? theme = pref.getBool("Theme");

  if(theme != null){
Provider.of<ThemeProvider>(context,listen: false).SetTheme(Istheme: theme);
  }
  }
}