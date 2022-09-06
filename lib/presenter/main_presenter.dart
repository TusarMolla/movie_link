import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class MainPresenter {

final _currentIndex = PublishSubject<int>();
PublishSubject<int> get getIndex =>_currentIndex.stream;

add(index){
  _currentIndex.sink.add(index);
}

MainPresenter(){
  _currentIndex.sink.add(0);
}





}

