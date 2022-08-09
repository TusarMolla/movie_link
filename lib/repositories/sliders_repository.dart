import 'package:movie_link/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:movie_link/models/movie.dart';
import 'package:movie_link/models/sliders.dart';

class SlidersRepository{
  
  static Future<SlidersResponse> sliderList({int page=1})async{
    Uri url = Uri.parse("${AppConfig.API_URL}/sliders");
    var res =await http.get(url,);
    return slidersResponseFromJson(res.body);
  }
  
  
}