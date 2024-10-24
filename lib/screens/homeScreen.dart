// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weatherModel.dart';
import 'package:weather_app/utils/providers/provider.dart';
import 'package:weather_app/screens/googleMapScreen.dart';
import 'package:weather_app/services/weatherServices.dart';
import 'package:weather_app/view-model/homeView-model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeViewModel>(context,listen: false).handleLocationPermission(context);
  }

  

  @override
  Widget build(BuildContext context) {

    final weatherProvider = context.watch<WeatherProvider>();
    return SafeArea(
        child: Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/backgroundImage.jpg'),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 10,
              child: weatherProvider.position != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 50),
                      child: FutureBuilder(
                        future: WeatherServices()
                            .fetchData(weatherProvider.position!.latitude, weatherProvider.position!.longitude),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text(
                              'Error occured ${snapshot.error}',
                              style: const TextStyle(color: Colors.white),
                            );
                          } else {
                            WeatherModel _weather = snapshot.data!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${_weather.place}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '${_weather.temp?.toStringAsFixed(2)}°C',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '${_weather.description?.toUpperCase()}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GoogleMapScreen(
                                                  latlong: LatLng(
                                                      weatherProvider.position!.latitude,
                                                      weatherProvider.position!.longitude),
                                                )),
                                      );
                                    },
                                    child: const Text('Show Map'))
                              ],
                            );
                          }
                        },
                      ),
                    )
                  : const CircularProgressIndicator(),
            ),
            Positioned(
                bottom: 50,
                left: 0,
                child: Image.asset('assets/images/house.png')),
            Positioned(
                bottom: 50,
                right: 0,
                child: Image.asset('assets/images/snowman.png')),
            Positioned(
                bottom: 50,
                right: 0,
                child: Image.asset('assets/images/snowdrift.png')),
            Positioned(
              bottom: 40,
              right: 100,
              width: 200.w,
              child: Image.asset('assets/images/snowdrift.png'),
            ),
            Positioned(
              bottom: 40,
              right: 0,
              width: 200.w,
              child: Image.asset('assets/images/snowdrift.png'),
            ),
            Positioned(
              bottom: 20,
              right: 0,
              width: 40.w,
              child: Image.asset('assets/images/land with snow.png'),
            ),
            Positioned(
              bottom: 0,
              right: 10,
              child: Image.asset('assets/images/land with snow.png'),
            ),
            Positioned(
              bottom: 40,
              left: 0,
              width: 60.w,
              child: Image.asset('assets/images/land with snow.png'),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              child: Transform.flip(
                  flipX: true,
                  child: Image.asset(
                    'assets/images/snowdrift.png',
                  )),
            ),
            Positioned(
              bottom: 20,
              left: 50,
              width: 100.w,
              child: Image.asset('assets/images/snowman.png'),
            ),
          ],
        ),
      ),
    ));
  }
}
