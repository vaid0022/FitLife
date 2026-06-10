import 'dart:convert';
import 'dart:developer';

import 'package:fitlife/Model/DietModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Dietlogic {
  static int page = 1;
  static bool isLoading = false;
  static bool hasMoreData = true;
  static List<Data> AllDiet = [];
  static ScrollController scrollController = ScrollController();
  static String? CatagoryOG;

static  Future<DietModel> GetApi({int? pageOG}) async {
    String url =
        "https://exercise-api.ymove.app/api/v2/recipes/search?";

    Uri urll = Uri.parse(url);

    Map<String,String> param ={
      "page" : "${pageOG ?? 1}",
      "pageSize" : "10",
    };
    if(CatagoryOG != null){
      param["diet"] = CatagoryOG!;
    }
    urll = urll.replace(queryParameters:param);



    var responce = await http.get(
      urll,
      headers: {
        "X-API-Key":
            "ym_0879d7d7568f72ee85fa90ca3b612d6651506c331918932dfe0845c402a33513",
      },
    );

    if (responce.statusCode == 200) {
      log("Diet Api Loaded....");

      try {
        final data = jsonDecode(responce.body.toString());

        return DietModel.fromJson(data);
      } catch (error) {
        throw Exception("Error: $error");
      }
    } else {
      throw Exception("Api Failed");
    }
  }

  static Future<void> FetchData()async{
    if(isLoading)return;

    isLoading = true;

    try{
      DietModel Diet = await GetApi(pageOG: page);

      if(Diet.data == null || Diet.data!.isEmpty){

        hasMoreData = false;
      }else{
            hasMoreData = Diet.pagination!.page! < Diet.pagination!.totalPages!;

        AllDiet.addAll(Diet.data!);
      }
    }catch(error){
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

  static void SetUpPagination({required VoidCallback RefreshUi}){
      scrollController.addListener((){

        if(scrollController.position.pixels >= scrollController.position.maxScrollExtent -200){

          HasMoreData().then((_){

            RefreshUi();

          });
        }
      });

  }

  static Future<void>  Reset()async{
  page = 1;
  isLoading =false;
  hasMoreData = true;
  AllDiet.clear();

  await FetchData();
  }

  static void DietCategory({required String Category}){
      CatagoryOG = Category.toLowerCase() ;
  }
}
