import 'package:flutter/cupertino.dart';

class MainPresenter extends ChangeNotifier{
  int currentIndex = 0;


  changeCurrentIndex(index) {
      currentIndex = index;
      notifyListeners();
  }

}