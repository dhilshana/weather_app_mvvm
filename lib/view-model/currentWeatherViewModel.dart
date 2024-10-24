import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utils/providers/provider.dart';

class CurrentWeatherViewModel extends ChangeNotifier {
  Future<void> currentLocation(BuildContext context) async {
    try {
      await context.read<WeatherProvider>().getPosition(context);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Unable to access data.  Please check yor location is enabled')));
    }
  }
}
