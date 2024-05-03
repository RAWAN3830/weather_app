import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider.dart';
import 'package:weather_app/weather_item_model.dart';

import 'api_repo.dart';
import 'appcolor.dart';
import 'modelclass.dart';

class Second_screen extends StatefulWidget {
  // List<Forecastday> l1;
  final List<Hour>? hour;
  final String title;
  // final Forecastday dayforcast;
  Second_screen({super.key, required this.hour, required this.title});
  // required this.dayforcast});


  @override
  State<Second_screen> createState() => _Second_screenState();
}

class _Second_screenState extends State<Second_screen> {
  WeatherModel? wm;
  bool isload = false;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      isload = true;
    });
    apiRepo().LoadApiData(widget.title).then((value) {
      wm = value;
      setState(() {
        isload = false;
      });

    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<weatherProvider>(context,listen: true);
    return Scaffold(
        backgroundColor: (provider.getTheme == false)? AppColors.primaryColor :Colors.black,
        appBar: AppBar(
          title: const Text('Forecasts'),
          centerTitle: true,
          backgroundColor: Colors.transparent,//AppColors.primaryColor,
          elevation: 0.0,
        ),
        body: (isload == true)
            ? Center(child: CircularProgressIndicator())
            : Stack(children: [
          Positioned(
            top: 50,
            right: -3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 700,
                width: 400,
                // height: AppConstants.size.height * .75,
                // width: AppConstants.size.width,
                decoration:  BoxDecoration(
                  color: (provider.getTheme == false) ? Colors.white : Colors.grey.shade800,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            left: 22,
            top: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  // width: AppConstants.size.width * .7,
                  decoration: BoxDecoration(
                    gradient: (provider.getTheme == false) ?  LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.center,
                        colors: [
                          Color(0xffa9c1f5),
                          Color(0xff6696f5),
                        ])
                        :
                    LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.black54,
                          Color(0xff6696f5),
                        ]),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(.1),
                        offset: const Offset(0, 25),
                        blurRadius: 3,
                        spreadRadius: -10,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10,
                        left: 10,
                        width: 150,
                        child: Image.asset("assets/new_icons/heavyrain.png"),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Container(
                          width: 350, //AppConstants.size.width * .8,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WeatherItem(
                                value: '${wm!.current!.windKph.toString()}',
                                unit: ' km/h',
                                imageUrl: 'assets/new_icons/windspeed.png',
                                title: 'windSpeed',
                              ),
                              WeatherItem(
                                value: '${wm!.current!.humidity.toString()}',
                                unit: ' % ',
                                imageUrl: 'assets/new_icons/humidity.png',
                                title: 'Humidity',
                              ),
                              WeatherItem(
                                value: '${wm!.current!.uv}',
                                unit: ' % ',
                                imageUrl: 'assets/new_icons/sunny.png',
                                title: 'UV++',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Today's Temp",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                                Text(
                                  '${widget.hour![0].heatindexC}',
                                  // forecast.maxTemperature.round().toString(),
                                  style: TextStyle(
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = AppColors.shader,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  // child: const CurrentForecastDetails(),
                ),
                SizedBox(height: 10),
                Text('Todays weather',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),

                //  const ForecastsList(),
              ],
            ),
          ),
          Positioned(
            top: 440,
            left: 10,
            right: 8,
            child: Container(
              height: 320,
              width: 400,
              child: ListView.separated(
                itemCount: widget.hour!.length, //min(3, forecast.length),
                itemBuilder: (context, index) {
                  return Card(
                    borderOnForeground: true,
                    color: (provider.getTheme == false)?Colors.blue.shade100 :Colors.black12,
                    elevation: 3.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                      "https:" + wm!.current!.condition!.icon),
                                  Text(
                                    '${widget.hour![index].tempC.toString()}°c',

                                    style:  TextStyle(
                                      color:(provider.getTheme == false)? Colors.black54 : Colors.white70,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  //forecastModel.weatherName,
                                ],
                              ),
                              Text(
                                "${DateFormat.j().format(DateTime.parse(widget.hour![index].time))}",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: (provider.getTheme == false)? Colors.black54 : Colors.white70,
                                ),
                              ),

                              // Divider(color: Colors.black,height: 1,thickness: 1,indent: 10,endIndent: 10,),
                              Container(

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          child: Image.asset(
                                              'assets/icons/humidity.png'),
                                        ),
                                        VerticalDivider(
                                          color: Colors.black,
                                        ),
                                        Text(
                                            widget.hour![index].feelslikeC
                                                .toString(),
                                            style: TextStyle(
                                                color: (provider.getTheme == false)? Colors.blue : Colors.white70,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                         SizedBox(height: 20,child: Image.asset('assets/icons/windspeed.png'),),
                                        Text(
                                          "${widget.hour![index].windMph} km"
                                                .toString(),
                                            style: TextStyle(
                                                color:(provider.getTheme == false)? Colors.blue : Colors.white70,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 5,
                  );
                },
              ),
            ),
          )
        ]));
  }
}
