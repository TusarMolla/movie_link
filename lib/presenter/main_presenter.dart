import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movie_link/models/category.dart';
import 'package:movie_link/models/crate_database.dart';
import 'package:movie_link/models/favorite_sqlite_model.dart';
import 'package:movie_link/models/movie.dart';
import 'package:movie_link/models/movie_details.dart';
import 'package:movie_link/models/sliders.dart';
import 'package:movie_link/others/ad_helper.dart';
import 'package:movie_link/repositories/categories_repository.dart';
import 'package:movie_link/repositories/movies_repository.dart';
import 'package:movie_link/repositories/sliders_repository.dart';
import 'package:rxdart/rxdart.dart';

class MainPresenter{
  // initial variable
  InterstitialAd interstitialAd;
  // TODO: Add _isInterstitialAdReady
  bool isInterstitialAdReady = false;
  MyDatabase myDatabase = MyDatabase();
  int homePage=1,trandingPage=1,tvPage=1;

  ScrollController mainScrollController = ScrollController();
  

  BehaviorSubject<int> _currentIndex = BehaviorSubject<int>.seeded(0);
 var _moviesFetcher = BehaviorSubject<List<MovieData>>();
  var _trandingMoviesFetcher = BehaviorSubject<MoviesResponse>();
  var _tvShowsFetcher = BehaviorSubject<MoviesResponse>();
  var _filteredFetcher = BehaviorSubject<MoviesResponse>();
  var _slideFetcher = BehaviorSubject<SlidersResponse>();
  var _categoryFetcher = BehaviorSubject<CategoriesResponse>();
  var _movieDetailsFetcher = BehaviorSubject<MovieDetailsResponse>();
  var _animationValue = BehaviorSubject<double>.seeded(35);

  final _isFavorite = BehaviorSubject<bool>.seeded(false);
  final _favoriteMovie = BehaviorSubject<MoviesResponse>();

  MainPresenter(){
    // serve adds
    _initGoogleMobileAds();
    loadInterstitialAd();


    myDatabase.create().then((value){
      fetchFavoriteMovies();
    });


    fetchAllCategory();
    fetchAllMovie(1);
    fetchAllSlide();
    fetchTrandingMovie(1);
    fetchTvShows(1);

    mainScrollController.addListener(() {
      if(mainScrollController.offset== mainScrollController.position.maxScrollExtent){
        homePage++;
        fetchAllMovie(homePage);;
      }
    });

  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  // TODO: Implement _loadInterstitialAd()
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this.interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              //_moveToHome();
            },
          );
          isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          print('Failed to load an responseInfo ad: ${err.responseInfo}');
          isInterstitialAdReady = false;
        },
      ),
    );
  }

  Animation<double> animation; //animation variable for circle 1
  // var  animation2 = Tween<double>(begin: 35, end: 50).transform(t); //animation variable for circle 1
  AnimationController animationcontroller; //animation controller variable circle 1

  // var   animation = Tween<double>(begin: 35, end: 50).transform(1);


  // animationcontroller = AnimationController(
  // vsync: this, duration: Duration(milliseconds: 1500));
  //

  
  
  // get data
  BehaviorSubject<int> get getIndex => _currentIndex;
  BehaviorSubject <List<MovieData>> get allMovie=>_moviesFetcher;
  BehaviorSubject <MoviesResponse> get trandingMovies=>_trandingMoviesFetcher;
  BehaviorSubject <MoviesResponse> get tvShows=>_tvShowsFetcher;
  BehaviorSubject <MoviesResponse> get getFilteredMovies=>_filteredFetcher;
  BehaviorSubject <SlidersResponse> get allSlide=>_slideFetcher;
  BehaviorSubject <CategoriesResponse> get allCategory=>_categoryFetcher;
  BehaviorSubject<double> get getAnimationValue => _animationValue;
  //BehaviorSubject<MovieDetailsResponse> get getMovieDetails => _movieDetailsFetcher.stream;

  BehaviorSubject<MoviesResponse> get getFavoriteMovie => _favoriteMovie;
  BehaviorSubject<bool> get getIsFavorite => _isFavorite;

  fetchAllMovie(page)async{
    print("bbb");
    var temp =<MovieData> [];
    if(page>1){
      temp.addAll(_moviesFetcher.stream.value);
    }
    print("bbb after ${temp.length}");

    var value = await MoviesRepository.movieList(page: page);
    print(value.data.length.toString() + "bbb");
   // var temp = BehaviorSubject<List<MovieData>>();
   //temp.add(value.data);

    temp.addAll(value.data);

 _moviesFetcher.sink.add(temp);
  }

 Future<bool> fetchTrandingMovie(page)async{
    var value = await MoviesRepository.trandingMovieList(page: page);
    _trandingMoviesFetcher.sink.add(value);

    return true;
  }

Future<bool> fetchTvShows(int page)async{
    var value = await MoviesRepository.tvShowList(page: page);
    _tvShowsFetcher.sink.add(value);
    return true;
  }

  fetchFilters(id)async{
    var value = await MoviesRepository.filteredMovieList(id: id);
    _filteredFetcher.sink.add(value);
  }

  fetchFavoriteMovies()async{
    var ids = await myDatabase.favorites();
    List arrayId=[];
    ids.forEach((element) {
      arrayId.add(element.id);
    });
    if (arrayId.isNotEmpty) {
      var value = await MoviesRepository.favoriteMovieList(ids: arrayId);
      _favoriteMovie.sink.add(value);
    }
  }
    checkIsFavorite(id)async{
    var isFavorite = await myDatabase.checkFavorite(id);
    _isFavorite.sink.add(isFavorite);
  }
     deleteFavorite(id)async{
    var isFavorite = await myDatabase.deleteFavorite(int.parse(id.toString()));
    checkIsFavorite(id);
    fetchFavoriteMovies();

     }
  addFavorite(id)async{
    var isFavorite = await myDatabase.insertFavorite(Favorite(id: int.parse(id)));
    checkIsFavorite(id);
    fetchFavoriteMovies();
  }

  Future<bool> homeReset()async{
    fetchAllCategory();
    fetchAllMovie(1);
    fetchAllSlide();
    return true;
  }

  Future<bool> trandingReset()async{
  await  fetchTrandingMovie(1);

    return true;
  }

  Future<bool> tvReset()async{
  await  fetchTvShows(1);

    return true;
  }

  setAnimation(vnc){
    animationcontroller = AnimationController(vsync: vnc,duration: Duration(milliseconds: 2500));
    animationcontroller.repeat();
    animation = Tween<double>(begin: 45, end: 60).animate(animationcontroller);
    animationcontroller.addListener(() {
      _animationValue.sink.add(animation.value);
    });
  }


  Future<MovieDetailsResponse>  fetchMovieDetails(id,)async{




    var value = await MoviesRepository.movieDetails(id);
    return value;
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

dispose(){
  _currentIndex.close();
  _moviesFetcher.close();
  _trandingMoviesFetcher.close();
  _tvShowsFetcher.close();
  _filteredFetcher.close();
  _slideFetcher.close();
   _categoryFetcher.close();
   _movieDetailsFetcher.close();
   _animationValue.close();
   _isFavorite.close();
   _favoriteMovie.close();
}

}
