import 'dart:convert';
import 'dart:developer';

import 'package:fitlife/Model/DietModel.dart';
import 'package:http/http.dart' as http;

class Dietlogic {

  static String? CatagoryOG;

static  Future<DietModel> GetApi({int? pageOG}) async {
    String url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=vegetarian";

    Uri urll = Uri.parse(url);


    urll = urll.replace(queryParameters: {
      "c" : CatagoryOG ?? "vegetarian"
    });

    var responce = await http.get(urll);

    if (responce.statusCode == 200){
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
  static void DietCategory({required String Category}){
      CatagoryOG = Category.toLowerCase() ;
  }
}
