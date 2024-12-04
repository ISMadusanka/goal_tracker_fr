import 'package:flutter/cupertino.dart';
import 'package:habittracker/Static%20Data/images.dart';

class OnBoardingProvider with ChangeNotifier{

  List onBoardingData = [
    {"image": ImagesPath.onBoarding1,"title" : "Set Your Goals, One Step at a Time","subTitle":"Empower yourself to define clear objectives and visualize your progress"},
    {"image": ImagesPath.onBoarding2,"title" : "Stay on Track with Smart Insights","subTitle":"Get personalized plans, reminders, and insights to achieve your milestones"},
    {"image": ImagesPath.onBoarding3,"title" : "Celebrate Every Achievement","subTitle":"Track your journey and celebrate your success with every goal you accomplish"},
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