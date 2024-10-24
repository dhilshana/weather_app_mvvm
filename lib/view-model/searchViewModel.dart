import 'package:flutter/material.dart';
import 'package:weather_app/models/weatherModel.dart';
import 'package:weather_app/services/weatherServices.dart';

class SearchViewModel extends ChangeNotifier{
  WeatherServices weatherServices = WeatherServices();
 Future<WeatherModel?>? weatherFuture; // Holds the future result


   Future<WeatherModel?> searchLocation(String city) async {

      return  await weatherServices.searchByLocation(city); // Fetch the weather data for the city
    
  }

  void getSearchedValue(String city){

    weatherFuture=searchLocation(city);
    notifyListeners();
  }
}