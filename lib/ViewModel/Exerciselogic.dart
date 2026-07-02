

  import 'dart:convert';
  import 'dart:developer';
  import 'dart:io';
  import 'dart:math' hide log;
  import 'dart:typed_data';

  import 'package:date_format/date_format.dart';
  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
  import 'package:image/image.dart' as img;
  import 'package:FitLife/Model/ExerciseModel.dart';
  import 'package:path_provider/path_provider.dart';

  class Exerciselogic{
  static int page = 1;
  static bool isLoading = false;
  static bool hasMoreData = true;
  static List<ExerciseModel> AllExerciese = [];
   ScrollController scrollController =ScrollController();

  static final baseurl = "https://exercisedb.p.rapidapi.com";


    static Future<List<ExerciseModel>> GetApi({int? pageNO})async{

    final  String url = "$baseurl/exercises?sortMethod=bodyPart&offset=0&limit=10&sortOrder=ascending";

       Uri urll = Uri.parse(url);
      urll = urll.replace(queryParameters: {
        ...urll.queryParameters,
        "offset" : "${pageNO ?? 1}",
        "limit" : "10",
      });

      final response = await http.get(urll,headers: {
         "X-RapidAPI-Key" : "4a09348ff4msh7e8c2ba5fe5cde7p1f38cbjsna36d19ce0774",
        "x-rapidapi-host" : "exercisedb.p.rapidapi.com"
      });
    print("URL: $urll");
    print("Status: ${response.statusCode}");
    print("Body: ${response.body}");
     if(response.statusCode == 200)
       {
         log("[Exercise] = Api is Loaded...");

         try{
           final List<dynamic> data = jsonDecode(response.body.toString());

           return data.map((e) =>  ExerciseModel.fromJson(e)).toList();
         }catch(e){
           throw Exception("Error: $e");
         }
       }else{
       throw Exception("[Exercise ] = ${response.statusCode}");
     }
    }

    static Future<void> FetchData()async{

      if(isLoading || !hasMoreData)return;

      isLoading  = true;

      try{

        List<ExerciseModel> Exercise =  await GetApi(pageNO: page);

        if(Exercise.isEmpty){

          hasMoreData = false;
        }else{

           AllExerciese.addAll(Exercise);
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

     setUpPagination(VoidCallback UiRefresh)async{

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


      static Future<Uint8List?> getImage({required String imageId})async{
        final url = "$baseurl/image?exerciseId=0001&resolution=180";

       try{
         Uri urll = Uri.parse(url);

         urll = urll.replace(queryParameters: {
           ...urll.queryParameters,
           "exerciseId" : imageId,
           "resolution" : "180"
         });

         final responce = await http.get(urll,headers: {
           "X-RapidAPI-Key" : "4a09348ff4msh7e8c2ba5fe5cde7p1f38cbjsna36d19ce0774",
           "x-rapidapi-host" : "exercisedb.p.rapidapi.com"
         });
         print("Image URL: $urll");
         print("Status: ${responce.statusCode}");
         print("Headers: ${responce.headers}");
         print("Content-Type: ${responce.headers['content-type']}");
         print("Body length: ${responce.bodyBytes.length}");
         if(responce.statusCode == 200 ){
           log("[image Api] = Loaded");

           return responce.bodyBytes;
           log("Image Error: ${responce.statusCode}");
         }else {
           return null;
         }

       }catch(e){
         throw Exception("Error: $e");
       }
      }
  }