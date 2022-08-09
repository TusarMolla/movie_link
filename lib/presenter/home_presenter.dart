


import 'package:bloc/bloc.dart';
import 'package:movie_link/models/category.dart';
import 'package:movie_link/models/movie.dart';
import 'package:movie_link/models/sliders.dart';
import 'package:movie_link/repositories/categories_repository.dart';
import 'package:movie_link/repositories/movies_repository.dart';
import 'package:movie_link/repositories/sliders_repository.dart';

class HomePresenter extends Bloc<Home,HomePageData>{
  HomePresenter(initialState) : super(initialState) {
    on<HomePageData>((event, emit) => emit(state));
  }
}

abstract class Home{
  Future<MoviesResponse>  getTopMovies();
  Future<CategoriesResponse>  getCategories();
  Future<SlidersResponse>  getSliders();
}

class HomePageData extends Home{
  @override
  Future<CategoriesResponse> getCategories() async{
    return await CategoriesRepository.categoryList();
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<SlidersResponse> getSliders() async{
    return await SlidersRepository.sliderList(page: 1);

    // TODO: implement getSliders
    throw UnimplementedError();
  }

  @override
  Future<MoviesResponse> getTopMovies() async{
    var value = await MoviesRepository.movieList(page: 1);
    return value;
    // TODO: implement getTopMovies
    throw UnimplementedError();
  }

}