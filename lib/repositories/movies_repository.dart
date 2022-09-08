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
  

  static Future<MovieDetailsResponse> movieDetails( id)async{
    Uri url = Uri.parse("${AppConfig.API_URL}/movie-details/$id");
    var res = await http.get(url,);
    return movieDetailsResponseFromJson(res.body);
  }


}