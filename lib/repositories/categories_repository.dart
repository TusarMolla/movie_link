import 'package:movie_link/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:movie_link/models/category.dart';
import 'package:movie_link/models/movie.dart';

class CategoriesRepository{
  
  static Future<CategoriesResponse> categoryList()async{
    Uri url = Uri.parse("${AppConfig.API_URL}/categories");

    var res =await http.get(url,);
    return categoriesResponseFromJson(res.body);
  }
  
  
}