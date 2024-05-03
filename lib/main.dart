import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Splash_screen/Splash_Screen.dart';
import 'package:weather_app/api_repo.dart';
import 'package:weather_app/modelclass.dart';
import 'package:weather_app/provider.dart';
import 'package:weather_app/second_page.dart';

import 'appcolor.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => weatherProvider(),)
      ],
      child: Consumer<weatherProvider>(
        builder: (context,provider,child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: (provider.getTheme == false) ?ThemeData.light(useMaterial3: true,) : ThemeData.dark(useMaterial3: true),
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        }
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    TextEditingController searchController = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final provider = Provider.of<weatherProvider>(context,listen: true);
    return Scaffold(
      appBar:  AppBar(
        // automaticallyImplyLeading: false,
        toolbarHeight: 100,
        title: Container(
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            child: TextField(
              onSubmitted: (value){
                searchController.text = value;
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyHomePage(title: searchController.text),), (route) => false);
              },
              controller: searchController,
              style: TextStyle(color: Colors.black),
              maxLines: 1,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                ),
                contentPadding: EdgeInsets.only(
                  left: 0,
                  bottom: 11,
                  top: 11,
                  right: 15,
                ),
                hintText: "Search Location",
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child:(isload == true)
        ? Container(
          height: height,
            child: Center(child: CircularProgressIndicator()))
        : Column(
          children: [
            SizedBox(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: 540,
                width: width,
                decoration: BoxDecoration(
                  // image: DecorationImage(image: AssetImage),
                  gradient: (provider.getTheme == false)
                      ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue.shade200, Colors.blue])
                      :
                  LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.black87, Colors.blue]),


                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(color: Colors.black54,borderRadius: BorderRadius.circular(40)),
                          child:
                              // Container(
                              //   height: 60,
                              //   width: 60,
                              //   decoration: BoxDecoration(
                              //     image: DecorationImage(image: AssetImage('assets/weather/01d.png')),
                              //     color: Colors.black
                              //   ),

                              // ),
                          IconButton(
                            onPressed: () {},
                            icon: (provider.isTheme == true)
                                ? Center(
                              child:
                                GestureDetector(
                                  onTap:() {
                                    provider.setTheme = false;
                                  },
                                    child: CircleAvatar(child: Image.asset('assets/weather/01n.png'),backgroundColor: Colors.transparent,))
                            )
                                : Center(
                              child:
                              GestureDetector(
                                onTap: (){
                                  provider.setTheme = true;
                                },
                                  child: CircleAvatar(child: Image.asset('assets/weather/01d.png'),backgroundColor: Colors.transparent,))

                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      child: Image.network("https:" + wm!.current!.condition!.icon,fit: BoxFit.contain),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: (provider.getTheme == false) ?Text(
                            "${wm!.current!.tempC.round().toString()}°c",
                            style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54
                                // foreground: Paint()..shader = AppColors.shader,
                                ),
                          )
                              :
                          Text(
                            "${wm!.current!.tempC.round().toString()}°c",
                            style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                color: Colors.white54
                              // foreground: Paint()..shader = AppColors.shader,
                            ),
                          )
                        ),

                      ],
                    ),
                    Text(
                      wm!.location!.country,
                      // homeNotifier.weatherModel.currentWeather.weatherName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    Text(

                      wm!.location!.name + ' | '+ wm!.location!.region,
                      // homeNotifier.weatherModel.currentWeather.weatherName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),

                    Text(
                      "${DateFormat.yMMMEd().format(DateTime.parse(wm!.current!.lastUpdated))}",
                      style: const TextStyle(
                        fontSize:20,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Divider(
                        color: Colors.white70,
                      ),
                    ),
                    Container(
                      // padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 100,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text('Fog', style: TextStyle(fontSize: 15,color: Colors.white)),
                                Divider(
                                  color: Colors.white,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                Container(
                                    height: 40,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/new_icons/fog.png'),
                                    )),
                                Text(wm!.current!.gustKph.toString(), style: TextStyle(fontSize: 16,color: Colors.white)),
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text('windSpeed', style: TextStyle(fontSize: 15,color: Colors.white)),
                                Divider(
                                  color: Colors.white,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                Container(
                                    height: 40,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/new_icons/overcast.png'),
                                    )),
                                Text("${wm!.current!.windMph.toString()}", style: TextStyle(fontSize: 16,color: Colors.white)),
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text('Avg.C', style: TextStyle(fontSize: 15,color: Colors.white)),
                                Divider(
                                  color: Colors.white,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                Container(
                                    height: 40,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/new_icons/cloud.png'),
                                    )),
                                Text(wm!.forecast!.forecastday![0].day.avgtempC.toString(), style: TextStyle(fontSize: 16,color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      clipBehavior: Clip.antiAlias,
                      height: 300,
                      decoration: BoxDecoration(
                        // color: Colors.transparent,
                          gradient: (provider.getTheme == false)?LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                              colors: [Colors.blue, Colors.blue.shade300])
                          : LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.black54, Colors.blue.shade400]),
                          borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          // shrinkWrap: true,
                          //physics: BouncingScrollPhysics(),
                          // scrollDirection: Axis.vertical,
                          itemCount: wm!.forecast!.forecastday.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Second_screen(hour: wm!.forecast!.forecastday[index].hour, title:'${widget.title}',),));
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 400,
                                      decoration: BoxDecoration(
                                          color: Colors.black38,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            // Container(
                                            //   height: 80,
                                            //   width: 80,
                                            //   decoration: BoxDecoration(
                                            //       image: DecorationImage(
                                            //           image: AssetImage(
                                            //               'assets/new_icons/moderateorheavyrainshower.png'))),
                                            // ),
                                            Container(
                                              height: 100,
                                              width: 100,
                                              child: Image.network("https:" + wm!.current!.condition!.icon,fit: BoxFit.contain),
                                            ),
                                            Column(
                                              children: [
                                                Text('Date',
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    wm!
                                                        .forecast!
                                                        .forecastday[index]
                                                        .date,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white70)),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text('Min',
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    '${wm!.forecast!.forecastday[index].day.maxtempC.toString()}°c',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white70)),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text('Max',
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    '${wm!.forecast!.forecastday[index].day.mintempC.toString()}°c',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white70)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 220,
                        width: 280,
                        decoration: BoxDecoration(
                            // color: Colors.black45,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(image: AssetImage('assets/images/sky.jpg'),fit: BoxFit.cover),
                            // gradient: LinearGradient(
                            //     colors: [Colors.blue, Colors.blue.shade100],
                            //     end: Alignment.bottomLeft,
                            //     begin: Alignment.topRight),
                            border: Border.all(color: Colors.black38)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Container(
                                height: 180,
                                width: 180,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('assets/images/sun.png'),
                                        opacity: 1)),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sunrise',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${wm!.forecast!.forecastday[0].astro.sunrise}',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Sun-set',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${wm!.forecast!.forecastday[0].astro.sunset}',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ]
                                // Text('MoonRise:\n${wm!.forecast!.forecastday[0].astro.moonrise}'),],
                                ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Todays moon fase: ${wm!.forecast!.forecastday[0].astro.moonPhase}',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),


                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 220,
                        width: 100,
                        decoration: BoxDecoration(

                            // image: DecorationImage(image: AssetImage('assets/images/g2.jpg'),fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                colors: [Colors.black, Colors.black45],
                                end: Alignment.bottomLeft,
                                begin: Alignment.topRight),
                             border: Border.all(color: Colors.black38)
                        ),
                        child: Column(children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration:
                            BoxDecoration(
                                image: DecorationImage(image: AssetImage('assets/images/moon.png'))),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'Moonrise',
                            style: TextStyle(
                                color: Colors.white54,

                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${wm!.forecast!.forecastday[0].astro.moonrise}',
                            style: TextStyle(
                                color: Colors.white,

                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'Moon set',
                            style: TextStyle(
                                color: Colors.white54,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${wm!.forecast!.forecastday[0].astro.moonset}',
                            style: TextStyle(
                                color: Colors.white,

                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            // color: Colors.white54,
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                colors: [Colors.blue.shade400,Colors.blue.shade100],
                                end: Alignment.bottomLeft,
                                begin: Alignment.topRight),
                            border: Border.all(color: Colors.white54),),
                        child: Column(children: [
                          Text(
                            'UV',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            height: 49,
                            width: 50,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/weather/01d.png'))),
                          ),

                          Text(wm!.current!.uv.toString(),style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,fontSize: 18),)
                        ]),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        height: 100,
                        width: 280,
                        decoration: BoxDecoration(
                        // color: Colors.white54,
                          // image: DecorationImage(image: AssetImage('assets/images/g1.jpg'),fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue.shade300,
                            border: Border.all(color: Colors.black38)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Humidity : ${wm!.current!.humidity.toString()} °c',style:TextStyle(color: Colors.black)),
                                  Text('Max : ${wm!.forecast!.forecastday[0].day.maxwindKph} °c',style:TextStyle(color: Colors.black)),
                                  Text('windspeed : ${wm!.current!.windKph.toString()} Km/h',style: TextStyle(color: Colors.black)),
                                  Text('windDegree : ${wm!.current!.windDegree.toString()} ',style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('windspeed',style:TextStyle(color: Colors.black)),
                                Text(wm!.forecast!.forecastday[0].hour[0].heatindexF.toString(),style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold,color: Colors.white54)),
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
          ],
        ),
      ),

    );
  }
}
