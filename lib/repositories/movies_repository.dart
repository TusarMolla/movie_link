import 'dart:convert';

import 'package:movie_link/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:movie_link/models/movie.dart';
import 'package:movie_link/models/movie_details.dart';

class MoviesRepository{
  
  static Future<MoviesResponse> movieList({int page=1})async{
    Uri url = Uri.parse("${AppConfig.API_URL}/all-movies?page=$page");
    var res = await http.get(url,);
    return moviesResponseFromJson(res.body);
  }
  
  static Future<MoviesResponse> trandingMovieList({int page=1})async{
    Uri url = Uri.parse("${AppConfig.API_URL}/tranding-movies?page=$page");
    var res = await http.get(url,);
    return moviesResponseFromJson(res.body);
  }
  static Future<MoviesResponse> tvShowList({int page=1})async{
    Uri url = Uri.parse("${AppConfig.API_URL}/tv-series?page=$page");
    print(url.toString());
    var res = await http.get(url,);
    return moviesResponseFromJson(res.body);
  }

  static Future<MoviesResponse> filteredMovieList({String id=""})async{
    Uri url = Uri.parse("${AppConfig.API_URL}/filter/$id");
    print(url.toString());
    var res = await http.get(url,);
    return moviesResponseFromJson(res.body);
  }
  static Future<MoviesResponse> favoriteMovieList({var ids})async{
    Uri url = Uri.parse("${AppConfig.API_URL}/favorite");
    var postBody= jsonEncode({"ids":ids});
    var header= {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    var res = await http.post(url,body: postBody,headers: header);
    return moviesResponseFromJson(res.body);
  }


  static Future<MovieDetailsResponse> movieDetails( id)async{
    Uri url = Uri.parse("${AppConfig.API_URL}/movie-details/$id");
    var res = await http.get(url,);
    return movieDetailsResponseFromJson(res.body);
  }


}