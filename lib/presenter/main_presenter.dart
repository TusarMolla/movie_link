import 'package:flutter/cupertino.dart';
import 'package:movie_link/models/category.dart';
import 'package:movie_link/models/movie.dart';
import 'package:movie_link/models/movie_details.dart';
import 'package:movie_link/models/sliders.dart';
import 'package:movie_link/repositories/categories_repository.dart';
import 'package:movie_link/repositories/movies_repository.dart';
import 'package:movie_link/repositories/sliders_repository.dart';
import 'package:rxdart/rxdart.dart';

class MainPresenter{
  // initial variable
  BehaviorSubject<int> _currentIndex = BehaviorSubject<int>.seeded(0);
  final _moviesFetcher = BehaviorSubject<MoviesResponse>();
  final _slideFetcher = BehaviorSubject<SlidersResponse>();
  final _categoryFetcher = BehaviorSubject<CategoriesResponse>();
  final _movieDetailsFetcher = BehaviorSubject<MovieDetailsResponse>();
  final _animationValue = BehaviorSubject<double>.seeded(35);

  MainPresenter(vnc){
    animationcontroller = AnimationController(vsync: vnc,duration: Duration(milliseconds: 1500));
    animationcontroller.repeat();
    animation = Tween<double>(begin: 35, end: 50).animate(animationcontroller);
    animationcontroller.addListener(() {
      _animationValue.sink.add(animation.value);
    });

    fetchAllCategory();
    fetchAllMovie();
    fetchAllSlide();
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
  BehaviorSubject <SlidersResponse> get allSlide=>_slideFetcher.stream;
  BehaviorSubject <CategoriesResponse> get allCategory=>_categoryFetcher.stream;
  BehaviorSubject<double> get getAnimationValue => _animationValue.stream;
  BehaviorSubject<MovieDetailsResponse> get getMovieDetails => _movieDetailsFetcher.stream;

  fetchAllMovie()async{
    var value = await MoviesRepository.movieList(page: 1);
    _moviesFetcher.sink.add(value);
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
