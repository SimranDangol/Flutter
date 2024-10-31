import 'package:http/http.dart' as http;
import 'package:math_game/model/apimodel.dart';
import 'dart:convert';

class TomatoApi {

  String url = "http://marcconrad.com/uob/tomato/api.php?out=json";

  // Function to get json data from the web api link
  Future<TomatoModal> getDatas() async {

    // http request to get json response from the given url
    final response = await http.get(Uri.parse(url));

    // check network connection condition for getting json response body
    if (response.statusCode == 200){

      // Decode json body 
       return TomatoModal.fromJson(jsonDecode(response.body));
       }
       else{
        throw Exception("Failed to load data");
       }
  }

}