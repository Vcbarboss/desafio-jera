import 'dart:convert';
import 'package:catalogo/models/movie.dart';
import 'package:http/http.dart' as http;

const API_KEY = "9ff2d4734cee4b2378d721411ed1a9b7";

class Api {

  search(String search) async{

    http.Response response = await http.get("https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&query=$search&page=1&include_adult=true");

   return decode(response);

  }

  List<Movie> decode(http.Response response){
    if(response.statusCode == 200){

      var decoded = json.decode(response.body);

      List<Movie> movies = decoded["results"].map<Movie>(
          (map){
            return Movie.fromJson(map);
          }
      ).toList();

      return movies;
    }else {
      throw Exception("Falha ao carregar api!");
    }
  }

}