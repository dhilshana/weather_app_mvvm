import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utils/providers/provider.dart';
import 'package:weather_app/screens/rootScreen.dart';
import 'package:weather_app/view-model/currentWeatherViewModel.dart';
import 'package:weather_app/view-model/homeView-model.dart';
import 'package:weather_app/view-model/rootViewModel.dart';
import 'package:weather_app/view-model/searchViewModel.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => RootViewModel(),
      ),
      ChangeNotifierProvider(create: (context) => WeatherProvider(),),
      ChangeNotifierProvider(create: (context) => HomeViewModel()),
      ChangeNotifierProvider(create: (context) => CurrentWeatherViewModel()),
      ChangeNotifierProvider(create: (context) => SearchViewModel()),
    ],
    child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 805),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const RootScreen(),
        theme: ThemeData(fontFamily: 'Inter'),
      ),
    );
  }
}
