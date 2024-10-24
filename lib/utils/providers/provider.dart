import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/utils/helper.dart';

class WeatherProvider extends ChangeNotifier {
  Position? position;
  int selectedIndex = 0;
  int modalIndex = 0;

     Helper dateTime = Helper();

  

  Future<void> getPosition(BuildContext context) async {
    try {
      position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User denied permissions to access the device\'s location.')));
    }
    notifyListeners();
  }

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
