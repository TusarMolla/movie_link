import 'package:movie_link/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:movie_link/models/movie.dart';

class MoviesRepository{
  
  static Future<MoviesResponse> movieList({int page=1})async{
    Uri url = Uri.parse("${AppConfig.API_URL}/movie-links?page=$page");

    var res =await http.get(url,);
    return moviesResponseFromJson(res.body);
  }
  
  
}