import 'dart:convert';
import 'dart:developer';

import 'package:fitlife/Model/DietModel.dart';
import 'package:http/http.dart' as http;

class Dietlogic {

  Future<DietModel> GetApi()async{
      String url = "https://exercise-api.ymove.app/api/v2/recipes/search?query=chicken&diet=high_protein";

      Uri urll = Uri.parse(url);

      urll = urll.replace(
        queryParameters: {
          ...urll.queryParameters,

        }
      );

      var responce =await http.get(urll,headers: {        "X-API-Key" :"ym_0879d7d7568f72ee85fa90ca3b612d6651506c331918932dfe0845c402a33513"
      });

      if(responce.statusCode == 200){

        log("Diet Api Loaded....");

        try{
          final  data = jsonDecode(responce.body.toString());

          return DietModel.fromJson(data);
        }catch(error){
          throw Exception("Error: $error");
        }
      }else{
        throw Exception("Api Failed");
      }
  }
}