import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class MainPresenter extends Bloc{
  int currentIndex = 0;

  MainPresenter(initialState) : super(0);

  changeCurrentIndex(index) {
    emit(index);
      //currentIndex = index;
  }

}

