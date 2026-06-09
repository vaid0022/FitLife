

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fitlife/Model/ExerciseModel.dart';

class Exerciselogic{


  static Future<ExerciseModel> GetApi()async{

    String url =   "https://exercise-api.ymove.app/api/v2/exercises?muscleGroup=chest&hasVideo=true";

    final urll = Uri.parse(url);

    final response = await http.get(urll,headers: {
      "X-API-Key" : "ym_0879d7d7568f72ee85fa90ca3b612d6651506c331918932dfe0845c402a33513"
    });

   if(response.statusCode == 200)
     {
       log("Exercise Api is Loaded...");

       try{
         var data = jsonDecode(response.body.toString());
         return ExerciseModel.fromJson(data);
       }catch(e){
         throw Exception("Error: $e");
       }
     }else{
     throw Exception("Api Failed");
   }
  }
}