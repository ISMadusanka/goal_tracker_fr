import 'package:flutter/cupertino.dart';
import 'package:habittracker/Static%20Data/images.dart';

class OnBoardingProvider with ChangeNotifier{

  List onBoardingData = [
    {"image": ImagesPath.onBoarding1,"title" : "Improve your health with habit tracking","subTitle":"Improve your health with habit tracking from eating more nutritious foods"},
    {"image": ImagesPath.onBoarding2,"title" : "The habit tracking method that really works","subTitle":"The habit tracking method that will help you achieve your wildest dreams"},
    {"image": ImagesPath.onBoarding3,"title" : "Tracking can help you make lasting changes","subTitle":"Habit tracking can help you make lasting changes by building routines"},
  ];

  int currentIndex = 0;

  PageController pageController = PageController();

  upDatePageController(int value){
    pageController.jumpToPage(value);
    notifyListeners();
  }

  upDateCurrentIndex(int value){
    currentIndex = value;
    notifyListeners();
  }

}