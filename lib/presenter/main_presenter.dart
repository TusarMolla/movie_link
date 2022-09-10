import 'package:flutter/cupertino.dart';
import 'package:movie_link/models/category.dart';
import 'package:movie_link/models/crate_database.dart';
import 'package:movie_link/models/favorite_sqlite_model.dart';
import 'package:movie_link/models/movie.dart';
import 'package:movie_link/models/movie_details.dart';
import 'package:movie_link/models/sliders.dart';
import 'package:movie_link/repositories/categories_repository.dart';
import 'package:movie_link/repositories/movies_repository.dart';
import 'package:movie_link/repositories/sliders_repository.dart';
import 'package:rxdart/rxdart.dart';

class MainPresenter{
  // initial variable
  MyDatabase myDatabase;

  BehaviorSubject<int> _currentIndex = BehaviorSubject<int>.seeded(0);
  final _moviesFetcher = BehaviorSubject<MoviesResponse>();
  final _trandingMoviesFetcher = BehaviorSubject<MoviesResponse>();
  final _tvShowsFetcher = BehaviorSubject<MoviesResponse>();
  final _filteredFetcher = BehaviorSubject<MoviesResponse>();
  final _slideFetcher = BehaviorSubject<SlidersResponse>();
  final _categoryFetcher = BehaviorSubject<CategoriesResponse>();
  final _movieDetailsFetcher = BehaviorSubject<MovieDetailsResponse>();
  final _animationValue = BehaviorSubject<double>.seeded(35);

  final _favoriteMovie = BehaviorSubject<MoviesResponse>();

  MainPresenter(vnc){
    animationcontroller = AnimationController(vsync: vnc,duration: Duration(milliseconds: 1500));
    myDatabase.create();
    animationcontroller.repeat();
    animation = Tween<double>(begin: 35, end: 50).animate(animationcontroller);
    animationcontroller.addListener(() {
      _animationValue.sink.add(animation.value);
    });

    fetchAllCategory();
    fetchAllMovie();
    fetchAllSlide();
    fetchTrandingMovie();
    fetchTvShows();
  }
  
  Animation<double> animation; //animation variable for circle 1
  // var  animation2 = Tween<double>(begin: 35, end: 50).transform(t); //animation variable for circle 1
  AnimationController animationcontroller; //animation controller variable circle 1

  // var   animation = Tween<double>(begin: 35, end: 50).transform(1);


  // animationcontroller = AnimationController(
  // vsync: this, duration: Duration(milliseconds: 1500));
  //

  
  
  // get data
  BehaviorSubject<int> get getIndex => _currentIndex.stream;
  BehaviorSubject <MoviesResponse> get allMovie=>_moviesFetcher.stream;
  BehaviorSubject <MoviesResponse> get trandingMovies=>_trandingMoviesFetcher.stream;
  BehaviorSubject <MoviesResponse> get tvShows=>_tvShowsFetcher.stream;
  BehaviorSubject <MoviesResponse> get getFilteredMovies=>_filteredFetcher.stream;
  BehaviorSubject <SlidersResponse> get allSlide=>_slideFetcher.stream;
  BehaviorSubject <CategoriesResponse> get allCategory=>_categoryFetcher.stream;
  BehaviorSubject<double> get getAnimationValue => _animationValue.stream;
  BehaviorSubject<MovieDetailsResponse> get getMovieDetails => _movieDetailsFetcher.stream;
  BehaviorSubject<MoviesResponse> get getFavoriteMovie => _favoriteMovie.stream;

  fetchAllMovie()async{
    var value = await MoviesRepository.movieList(page: 1);
    _moviesFetcher.sink.add(value);
  }
  fetchTrandingMovie()async{
    var value = await MoviesRepository.trandingMovieList(page: 1);
    _trandingMoviesFetcher.sink.add(value);
  }
  fetchTvShows()async{
    var value = await MoviesRepository.tvShowList(page: 1);
    _tvShowsFetcher.sink.add(value);
  }
  fetchFilters(id)async{
    var value = await MoviesRepository.filteredMovieList(id: id);
    _filteredFetcher.sink.add(value);
  }
  fetchFavoriteMovies()async{
    var ids =await myDatabase.favorites();
    List arrayId;
    ids.forEach((element) {
      arrayId.add(element.id);
    });

    var value = await MoviesRepository.filteredMovieList(id: id);


    _filteredFetcher.sink.add(value);
  }
    fetchMovieDetails(id)async{
    var value = await MoviesRepository.movieDetails(id);
    _movieDetailsFetcher.sink.add(value);
  }


  fetchAllCategory()async{
    var value = await CategoriesRepository.categoryList();
    _categoryFetcher.sink.add(value);
  }
  fetchAllSlide()async{
    var value = await SlidersRepository.sliderList(page: 1);
    _slideFetcher.sink.add(value);
  }

  add(index) {
    _currentIndex.sink.add(index);
  }





disposeAnimation(){
    animationcontroller.dispose();
}

}
