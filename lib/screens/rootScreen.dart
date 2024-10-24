import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/models/hourlyForecasteModel.dart';
import 'package:weather_app/screens/searchScreen.dart';
import 'package:weather_app/services/weatherServices.dart';
import 'package:weather_app/utils/providers/provider.dart';
import 'package:weather_app/view-model/rootViewModel.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
 

  void onTabTapped(int index) {
    final rootProvider = Provider.of<RootViewModel>(context, listen: false);
    final weatherProvider = Provider.of<WeatherProvider>(context,listen: false);
    rootProvider.updateIndex(index);

    if (rootProvider.modalIndex == 1) {
      showModalBottomSheet(
        context: context,
        backgroundColor:
            Colors.transparent, // Ensure the modal background is transparent
        builder: (context) {
          return Container(
            height: 360.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kBgColor.withOpacity(0.8), // Starting color with opacity
                  kPurpleColor.withOpacity(0.8), // Ending color with opacity
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0.r),
                topRight: Radius.circular(30.0.r),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Hourly Forecast',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Searchscreen()));
                        },
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 10,
                            color: Colors.white)
                      ],
                      border: Border.all(
                        color: kPurpleColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  FutureBuilder(
                    future: WeatherServices().fetchHourlyData(
                        weatherProvider.position!.latitude,
                        weatherProvider.position!.longitude),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text(
                          snapshot.error.toString(),
                          style: const TextStyle(color: Colors.white),
                        );
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              List<HourlyForecast> hourlyForecast =
                                  snapshot.data!;

                              List<Weather>? weather =
                                  hourlyForecast[index].weather;
                              dynamic rain = hourlyForecast[index].rain?.d3h;
                              dynamic temp = hourlyForecast[index].main?.temp;

                              String? iconCode = weather![0].icon;

                              final iconUrl =
                                  'http://openweathermap.org/img/wn/$iconCode@2x.png';
                              return Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 10),
                                width: 100.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.r),
                                    color: kPurpleColor,
                                    gradient: LinearGradient(
                                      colors: [
                                        kBgColor.withOpacity(
                                            0.8), // Starting color with opacity
                                        kPurpleColor.withOpacity(
                                            0.8), // Ending color with opacity
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    border: Border.all(color: kPurpleColor)),
                                child: Column(
                                  children: [
                                    Text(
                                     weatherProvider. dateTime.timeConverter(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              hourlyForecast[index].dt! *
                                                  1000)),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Image.network(iconUrl),
                                    Text(
                                      rain != null
                                          ? '${rain.toStringAsFixed(1)}%'
                                          : '',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '${temp.toStringAsFixed(0)}°C',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }


  @override
  void initState() {
    super.initState();
    Provider.of<WeatherProvider>(context, listen: false).getPosition(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RootViewModel>();
    return SafeArea(
        child: Scaffold(
      body: provider.screens[provider.selectedIndex],
      bottomNavigationBar: ConvexAppBar(
          style: TabStyle.custom,
          backgroundColor: kBgColor,
          activeColor: kPurpleColor,
          shadowColor: kPurpleColor,
          curveSize: 100.r,
          height: 50.h,
          elevation: 10,
          items: const [
            TabItem(
              icon: Icon(
                Icons.place,
                color: Colors.white,
              ),
            ),
            TabItem(
              icon: Icon(
                Icons.add_circle,
                color: Colors.white,
              ),
            ),
            TabItem(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            )
          ],
          initialActiveIndex: 0,
          onTap: onTabTapped
          ),
    ));
  }
}
