import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/screens/currentWeatherScreen.dart';
import 'package:weather_app/screens/homeScreen.dart';
import 'package:weather_app/utils/helper.dart';

class RootViewModel extends ChangeNotifier{

   Position? position;
  int selectedIndex = 0;
  int modalIndex = 0;

  List<Widget> screens = const [
    HomeScreen(),
    SizedBox(),
    CurrentWeatherScreen()
  ];

   
   void updateIndex(int index) {
    if (index == 1) {
      modalIndex = 1;
      selectedIndex = 0;
    } else {
      selectedIndex = index;
      modalIndex = 0;
    }
    notifyListeners();
  }

}