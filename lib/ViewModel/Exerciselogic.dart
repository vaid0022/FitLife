

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fitlife/Model/ExerciseModel.dart';

class Exerciselogic{
static int page = 1;
static bool isLoading = false;
static bool hasMoreData = true;
static List<Data> AllExerciese = [];
static ScrollController scrollController =ScrollController();


  static Future<ExerciseModel> GetApi({int? pageOG})async{

    String url =   "https://exercise-api.ymove.app/api/v2/exercises?muscleGroup=chest&hasVideo=true";

     Uri urll = Uri.parse(url);
    urll = urll.replace(queryParameters: {
      ...urll.queryParameters,
      "page" : "${pageOG ?? 1}",
      "pageSize" : "10",
    });

    final response = await http.get(urll,headers: {
      "X-API-Key" : "ym_651d440a04ca0e5308bbb1543e933088e0e0e709ed3008edfb3df68d6f2c39f8"
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

  static Future<void> FetchData()async{

    if(isLoading)return;

    isLoading  = true;

    try{

      ExerciseModel Exercise =  await GetApi(pageOG: page);

      if(Exercise.data == null || Exercise.data!.isEmpty){

        hasMoreData = false;
      }else{

         hasMoreData = Exercise.pagination!.page! <
                        Exercise.pagination!.totalPages!;

         AllExerciese.addAll(Exercise.data!);
      }
    }catch (error){
      throw Exception("Error: $error");
    }finally{
      isLoading = false;
  }
  }

  static Future<void> HasMoreData()async{
    if(isLoading || !hasMoreData)return;

    page++;

    await FetchData();

  }

  static setUpPagination(VoidCallback UiRefresh)async{

    scrollController.addListener((){
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200){

        HasMoreData().then((_){
          UiRefresh();
        });
      }
    });
  }

  static Future<void> Reset()async{
    page = 1;
    isLoading = false;
    hasMoreData = true;
    AllExerciese.clear();

    await FetchData();
  }

}