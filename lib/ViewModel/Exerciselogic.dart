

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:fitlife/Model/ExerciseModel.dart';
import 'package:path_provider/path_provider.dart';

class Exerciselogic{
static int page = 1;
static bool isLoading = false;
static bool hasMoreData = true;
static List<Data> AllExerciese = [];
static ScrollController scrollController =ScrollController();


  static Future<ExerciseModel> GetApi({int? pageOG})async{

    String url = "https://oss.exercisedb.dev/api/v1/exercises";

     Uri urll = Uri.parse(url);
    urll = urll.replace(queryParameters: {
      ...urll.queryParameters,
      "page" : "${pageOG ?? 1}",
      "pageSize" : "10",
    });

    final response = await http.get(urll);

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

  static Future<String?> gifToImage({required String GifUrl})async{
      try{
        // convert gif into uri
        final responce = await http.get(Uri.parse(GifUrl));

        if(responce.statusCode != 200){
          return null;
        }

        //It decode gif into bytes and store into animation
        final animation = img.decodeGif(responce.bodyBytes);
        if(animation == null && animation!.frames.isEmpty){
          return null;
        }

          // It store firest frame of gif
          final frame = animation.frames.first;

        // create new image
          final staticImage = img.Image(
            width: frame.width,
            height: frame.width
          );

          //copy pixels from first image
        img.compositeImage(staticImage, frame);

        //encode as normal png
          final pngBytes = img.encodePng(staticImage,singleFrame: true);


          //use for create and saved png
          final Directory = await getTemporaryDirectory();

          final file = File('${Directory.path}/${DateTime.now().millisecondsSinceEpoch}.png');
          await file.writeAsBytes(pngBytes);
          final pngImage = img.decodeImage(await file.readAsBytes());


          print("PNG saved");



          return file.path;


      }catch(e){
        print("ImageError = $e");
        return null;

      }



  }
}