import 'package:movie_link/models/category.dart';
import 'package:movie_link/models/movie.dart';
import 'package:movie_link/models/sliders.dart';
import 'package:movie_link/repositories/categories_repository.dart';
import 'package:movie_link/repositories/movies_repository.dart';
import 'package:movie_link/repositories/sliders_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomePresenter{
  final _moviesFetcher = PublishSubject<MoviesResponse>();
  final _slideFetcher = PublishSubject<SlidersResponse>();
  final _categoryFetcher = PublishSubject<CategoriesResponse>();


  HomePresenter(){
    fetchAllCategory();
    fetchAllMovie();
    fetchAllSlide();
  }

  ValueStream <MoviesResponse> get allMovie=>_moviesFetcher.stream;
  ValueStream <SlidersResponse> get allSlide=>_slideFetcher.stream;
  ValueStream <CategoriesResponse> get allCategory=>_categoryFetcher.stream;

  fetchAllMovie()async{
    var value = await MoviesRepository.movieList(page: 1);
    _moviesFetcher.sink.add(value);
  }
  fetchAllCategory()async{
    var value = await CategoriesRepository.categoryList();
    _categoryFetcher.sink.add(value);
  }
  fetchAllSlide()async{
    var value = await SlidersRepository.sliderList(page: 1);
    _slideFetcher.sink.add(value);
  }



}

